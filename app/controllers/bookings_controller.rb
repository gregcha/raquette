# == Schema Information
#
# Table name: bookings
#
#  id         :integer          not null, primary key
#  court_id   :integer
#  date       :string
#  hour       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  account_id :integer
#  venue_id   :integer
#
# Indexes
#
#  index_bookings_on_account_id  (account_id)
#  index_bookings_on_court_id    (court_id)
#  index_bookings_on_user_id     (user_id)
#  index_bookings_on_venue_id    (venue_id)
#
# Foreign Keys
#
#  fk_rails_2b4cdfa9aa  (court_id => courts.id)
#

class BookingsController < ApplicationController

  skip_before_filter :update_user_bookings, except: :index

  def index
  end

  def create
    account = Account.where(id: params[:account_id]).first
    login_paris_tennis(account.identifiant, account.password)
    query_page = @agent.get('https://teleservices.paris.fr/srtm/reservationCreneauInit.action')
    query_form = query_page.form('reservationCreneauCriteresForm')
    tennisArrond = Venue.where(pt_id: params[:pt_id]).first
    query_form.tennisArrond = tennisArrond.pt_name
    court = Court.where(pt_court_id: params[:pt_court_id]).first

    query_form.court = court.pt_court_and_venue_id
    query_form.dateDispo = params[:date]
    query_form.heureDispo = params[:hour][0..1]
    @agent.submit(query_form)

    @@booking_page = @agent.get('https://teleservices.paris.fr/srtm/reservationCreneauReserver.action')
    booking_form = @@booking_page.form('ReservationCreneauValidationForm')

    images = @@booking_page.search("#ImageCaptcha img")
    FileUtils.rm_rf(Dir.glob("#{Rails.root}/public/tmp/*"))
    @agent.get(images.first.attributes["src"]).save "#{Rails.root}/public/tmp/captcha.jpg"
    client = DeathByCaptcha.new('gregy17', 'paristenniscaptcha', :http)
    captcha = client.decode(path: "#{Rails.root}/public/tmp/captcha.jpg")
    booking_form.jcaptcha_reponse = captcha.text

    booking_form.libelleReservation = params[:libelleReservation]
    booking_form.cle = params[:cle]
    booking_form.rechercheElargie = ''
    confirm_page = @agent.submit(booking_form)

    if confirm_page.search("td .style7").first.text.strip == "Confirmation de votre réservation"
      # booking = Booking.new
      # booking.user_id = current_user.id
      # booking.account_id = params[:account_id]
      # booked_venue = Venue.where(pt_id: params[:pt_id])
      # booking.venue_id = booked_venue.first.id
      # booked_court = Court.where(pt_court_id: params[:pt_court_id])
      # booking.court_id = booked_court.first.id
      # booking.date = params[:date]
      # booking.hour = params[:hour][0..1].to_i.to_s
      # booking.save
      redirect_to page_path('home'), :notice => "Votre réservation est bien enregistrée"
    else
      flash[:alert] = "Désolé une erreur s'est produite"
      redirect_to :back
    end
  end

  def destroy
    booking = Booking.where(id: params[:id]).first
    account = Account.where(id: booking.account_id).first
    login_paris_tennis(account.identifiant, account.password)
    confirm_page = @agent.get('https://teleservices.paris.fr/srtm/reservationCreneauSuppressionReservation.action')
    if confirm_page.search("span.erreur ul li").nil?
      redirect_to page_path('home'), :notice => "Votre réservation est bien supprimée"
    else
      redirect_to :back, :alert => "Vous ne pouvez plus annuler cette réservation"
    end
  end

end

