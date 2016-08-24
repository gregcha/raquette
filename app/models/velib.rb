# == Schema Information
#
# Table name: velibs
#
#  id         :integer          not null, primary key
#  station    :string
#  address    :string
#  venue_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_velibs_on_venue_id  (venue_id)
#
# Foreign Keys
#
#  fk_rails_bb1b91525b  (venue_id => venues.id)
#

class Velib < ActiveRecord::Base
  belongs_to :venue
end
