class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # include Pundit

  protect_from_forgery with: :null_session
  before_action :authenticate_user!, unless: :pages_controller?
  before_action :next_seven_days
  before_action :update_user_bookings, unless: :not_current_user

  # before_filter :logged_in?, unless: :user_or_pages_controller?
  # after_action :verify_authorized, except:  :index, unless: :devise_or_pages_controller?
  # after_action :verify_policy_scoped, only: :index, unless: :devise_or_pages_controller?
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def not_current_user
    current_user == false
  end

  def pages_controller?
    controller_name == "pages"
  end

  def next_seven_days
    i = 0
    @week_days = []
    loop do
      i += 1
      d = Date.today + i - 1
      label = I18n.localize(d, format: "%a")
      day = d.strftime("%d")
      month = d.strftime("%m")
      year = d.strftime("%Y")
      @week_days << [label, day, month, year]
      break if i == 7
    end
  end

  def update_user_bookings
    accounts = Account.where(user_id: current_user)
    accounts.each do |a|
      login_paris_tennis(a.identifiant, a.password)
      welcome_page = @agent.get('https://teleservices.paris.fr/srtm/reservationAccueil.action')
      if welcome_page.form('srtmForm')
        raw_booking_data = welcome_page.form('srtmForm').cle
        match_data = raw_booking_data.match(/(.+@)(\d{2}\/\d{2}\/\d{4})\s(\d{2}):\d{2}(.+)/)
        pt_court_id = match_data[1]
        date = match_data[2]
        hour = match_data[3].to_i.to_s
        pt_id = match_data[4]
        bug_pt_id = ["@14@45@54@53","@9@91@428@26","@12@141@429@41","@17@202@198@70","@9@108@472@28","@14@82@327@56","@17@189@430@70","@11@135@257@37"]
        bug_pt_id.each_with_index do |b, index|
          patched_pt_id = ["@14@45@53@53","@9@91@76@26","@12@141@212@41","@17@202@431@70","@9@102@218@28","@14@82@326@56","@17@189@23@70","@11@261@258@37"]
          pt_id = patched_pt_id[index] if b == pt_id
        end
        already_in_db = Booking.where(user_id: current_user, account_id: a, pt_court_id: pt_court_id, date: date, hour: hour).first
        if already_in_db.nil?
          booking = Booking.new
          booking.user_id = current_user.id
          booking.account_id = a.id
          booked_venue = Venue.where(pt_id: pt_id).first
          booking.venue_id = booked_venue.id
          booked_court = Court.where(pt_court_id: pt_court_id).first
          booking.court_id = booked_court.id
          booking.pt_court_id = pt_court_id
          booking.date = date
          booking.hour = hour
          booking.save
        end
      end
    end
    all_bookings = Booking.where(user_id: current_user)
    @active_bookings = []
    all_bookings.each do |booking|
      date = booking.date.split("/")
      hour = booking.hour
      timestamp = Time.new(date[2], date[1], date[0], hour)
      if timestamp > Time.now
        @active_bookings << booking
      end
    end
  end

  def login_paris_tennis(identifiant, password)
    @agent = Mechanize.new
    login_page = @agent.get('https://teleservices.paris.fr/srtm/jsp/web/index.jsp')
    login_form = login_page.form('authentificationConnexionForm')
    login_form.login = identifiant
    login_form.password = password
    login_form.submit
  end

end
