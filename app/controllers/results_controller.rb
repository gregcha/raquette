class ResultsController < ApplicationController

  def index
    @results = Result.where(user_id: current_user.id)

    #group results by venue then by date then by hour
    @results_by_venue = @results.group_by { |r| r.venue.name }.map do |venue, results|
      [venue, results.group_by { |r| r.date }.map do |date, results|
        [date, results.group_by { |r| r.hour}]
      end.to_h]
    end.to_h

    get_user_accounts_and_status

  end

  def create
    raise
    previous_results = Result.where(user_id: current_user.id)
    previous_results.destroy_all if previous_results

    accounts = Account.where(user_id: current_user)
    if accounts.first.nil?
      login_paris_tennis("091182051", "4293")
    else
      login_paris_tennis(accounts.first.identifiant, accounts.first.password)
    end
    query_page = @agent.get('https://teleservices.paris.fr/srtm/reservationCreneauInit.action')
    query_form = query_page.form('reservationCreneauCriteresForm')
    query_form.checkbox_with(:name => 'tousArrondissements').check if params[:tousArrondissements] == 'yes'
    query_form.tennisArrond = params[:tennisArrond] if params[:tennisArrond].present?
    query_form.arrondissement  = params[:arrondissement][0] if params[:arrondissement].present?
    query_form.arrondissement2 = params[:arrondissement][1] if params[:arrondissement].present?
    query_form.arrondissement3 = params[:arrondissement][2] if params[:arrondissement].present?
    query_form.dateDispo = params[:dateDispo] if params[:dateDispo].present?
    query_form.heureDispo = params[:heureDispo]
    query_form.plageHoraireDispo = params[:plageHoraireDispo]
    query_form.checkbox_with(:name => 'courtEclaire').check if params[:courtEclaire] == 'yes'
    query_form.checkbox_with(:name => 'courtCouvert').check if params[:courtCouvert] == 'yes'
    query_form.revetement = params[:revetement]
    results_page = query_form.submit

    if results_page.search("span.erreur").first.nil? || results_page.search("span.erreur").first.text.strip == "Vous avez déjà une réservation sur notre système. La réservation d'un autre créneau vous fera perdre votre réservation actuelle."
      results_string = []
      loop do
        results = results_page.search("table.normal tbody a")
        results.each do |court|
          results_string << court.attributes["href"].value if court.attribute('href').value.include?('javascript:doReservation')
        end

        if next_button = results_page.link_with(:text => 'Suivant')
          results_page = next_button.click
        else
          break
        end
      end
      results_string.each do |string|
        match_data = string.match(/(\d+@)(\d{2}\/\d{2}\/\d{4})\s(\d{2})h\d{2}([@|\d]+)/)
        info_booking = string.match(/'(.+)','\/srtm','(.+)'/)
        pt_id = match_data[4]
        court = Court.where(pt_court_id: match_data[1]).first
        result = Result.new(
          pt_court_id: match_data[1],
          date: match_data[2],
          hour: match_data[3],
          pt_id: match_data[4],
          cle: info_booking[1],
          libelleReservation: info_booking[2],
          venue_id: court.venue_id,
          court_id: court.id
        )
        result.user_id = current_user.id
        result.save
      end
      redirect_to results_path
    else
      error = results_page.search("span.erreur").first.text.strip
      flash[:alert] = error
      redirect_to page_path('home')
    end
  end

  private

  def get_user_accounts_and_status
    @my_accounts = []
    current_user.accounts.collect do |account|
      if booking = Booking.where(account_id: account).first
        date = booking.date.split("/")
        hour = booking.hour
        timestamp = Time.new(date[2], date[1], date[0], hour)
        if timestamp > Time.now
          @my_accounts << [account.first_name + ' ' + account.last_name, account.id, true]
        else
          @my_accounts << [account.first_name + ' ' + account.last_name, account.id, false]
        end
      else
        @my_accounts << [account.first_name + ' ' + account.last_name, account.id, false]
      end
    end
  end

end
