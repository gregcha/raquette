# == Schema Information
#
# Table name: metros
#
#  id         :integer          not null, primary key
#  station    :string
#  venue_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_metros_on_venue_id  (venue_id)
#
# Foreign Keys
#
#  fk_rails_6b8a702fca  (venue_id => venues.id)
#

class Metro < ActiveRecord::Base
  belongs_to :venue
end
