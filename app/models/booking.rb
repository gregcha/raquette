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

class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :account
  belongs_to :venue
  belongs_to :court
end
