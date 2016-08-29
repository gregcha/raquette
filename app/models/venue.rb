# == Schema Information
#
# Table name: venues
#
#  id          :integer          not null, primary key
#  name        :string
#  district    :integer
#  address     :string
#  street      :string
#  zip_code    :integer
#  city        :string
#  phone       :string
#  description :text
#  surfaces    :string
#  handi       :boolean
#  pt_id       :string
#  pt_name     :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  available   :boolean
#

class Venue < ActiveRecord::Base
  has_many :results
  has_many :bookings
  has_many :courts
  has_many :pictures
  has_many :metros
  has_many :velibs
  acts_as_votable
end
