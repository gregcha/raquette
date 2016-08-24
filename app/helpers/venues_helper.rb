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

module VenuesHelper
end
