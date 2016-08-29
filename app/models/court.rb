# == Schema Information
#
# Table name: courts
#
#  id                    :integer          not null, primary key
#  court_number          :integer
#  surface               :string
#  roof                  :boolean
#  lights                :boolean
#  pt_court_id           :string
#  pt_venue_id           :string
#  pt_court_and_venue_id :string
#  venue_id              :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
# Indexes
#
#  index_courts_on_venue_id  (venue_id)
#
# Foreign Keys
#
#  fk_rails_76668ccd5c  (venue_id => venues.id)
#

class Court < ActiveRecord::Base
  has_many :results
  has_many :bookings
  belongs_to :venue
end
