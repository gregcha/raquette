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

class VenuesController < ApplicationController

  skip_before_filter :authenticate_user!
  skip_before_filter :next_seven_days

  def index
    @venues = Venue.all
  end

end
