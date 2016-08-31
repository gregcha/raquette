# == Schema Information
#
# Table name: accounts
#
#  id           :integer          not null, primary key
#  gender       :string
#  first_name   :string
#  last_name    :string
#  birthdate    :string
#  address1     :string
#  address2     :string
#  zip_code     :integer
#  city         :string
#  email        :string
#  mobile_phone :string
#  perso_phone  :string
#  pro_phone    :string
#  coins        :integer
#  identifiant  :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :integer
#  password     :string
#
# Indexes
#
#  index_accounts_on_user_id  (user_id)
#

class AccountsController < ApplicationController
  def index
    @accounts = Account.where(user_id: current_user.id)
  end

  def new
    @account = Account.new
  end

  def create
    check_account_registration
    if @accounts.first.nil?
      signup_paris_tennis
      if @welcome_page.search('span.erreur').first.nil?
        store_login_infos
        account_infos_updator
        flash[:notice] = "Compte ajouté avec succès"
        @accounts = Account.where(user_id: current_user.id)
      else
        @error = "Compte invalide"
        @accounts = Account.where(user_id: current_user.id)
      end
    else
      signup_paris_tennis
      if @welcome_page.search('span.erreur').first.nil?
        @account = @accounts.first
        account_infos_updator
        flash[:notice] = "Vous disposez déjà de ce compte et il est toujours valide"
        @accounts = Account.where(user_id: current_user.id)
      else
        @error = "Vous disposez déjà de ce compte mais soit il n'est plus valide, soit votre mot de passe est erroné."
        @accounts = Account.where(user_id: current_user.id)
      end
    end
    redirect_to accounts_path
  end

  def destroy
    account = Account.find(params[:id])
    bookings = Booking.where(account_id: account)
    account.destroy
    bookings.destroy_all
    redirect_to accounts_path
  end

  private

  def account_params
    params.require(:account).permit(:identifiant, :password)
  end

  def check_account_registration
    identifiant = account_params[:identifiant]
    @accounts = Account.where(identifiant: identifiant, user_id: current_user)
  end

  def signup_paris_tennis
    agent = Mechanize.new
    login_page = agent.get('https://teleservices.paris.fr/srtm/jsp/web/index.jsp')
    login_form = login_page.form('authentificationConnexionForm')
    login_form.login = account_params[:identifiant]
    login_form.password = account_params[:password]
    @welcome_page = login_form.submit
  end

  def store_login_infos
    @account = Account.new(account_params)
    @account.user_id = current_user.id
    @account.save
  end

  def account_infos_updator
    profil_page = @welcome_page.link_with(:href => '/srtm/compteConsulterDonneePersoInit.action').click
    raw_infos = profil_page.search("td.deg2[align = 'left']")
    account_infos = []
    raw_infos.each do |t|
      account_infos << t.text.strip
    end
    match_data = account_infos[0].match(/^([[:alpha:]]+.)\W+([[:alpha:]-]+)\W+([[:alpha:]\s-]+).+/)
    @account.gender = match_data[1]
    @account.first_name = match_data[2]
    @account.last_name = match_data[3]
    @account.birthdate = account_infos[0].match(/(\d{2}\/\d{2}\/\d{4})/)[1]
    @account.coins = account_infos[1].match(/(\d)/)[1]
    @account.address1 = account_infos[2]
    @account.address2 = account_infos[3]
    @account.zip_code = account_infos[4]
    @account.city = account_infos[5]
    @account.email = account_infos[6]
    @account.mobile_phone = account_infos[7]
    @account.perso_phone = account_infos[8]
    @account.pro_phone = account_infos[9]
    @account.save
  end

end
