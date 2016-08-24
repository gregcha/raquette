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

class Account < ActiveRecord::Base
  has_many :bookings
  belongs_to :user
end
