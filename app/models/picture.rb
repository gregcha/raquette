# == Schema Information
#
# Table name: pictures
#
#  id           :integer          not null, primary key
#  picture_path :string
#  venue_id     :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_pictures_on_venue_id  (venue_id)
#
# Foreign Keys
#
#  fk_rails_822c83584f  (venue_id => venues.id)
#

class Picture < ActiveRecord::Base
  belongs_to :venue
end
