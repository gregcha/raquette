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

  def index
    @venues = Venue.all
  end

  def show
    @venue = Venue.find(params[:id])
  end

  def upvote
    @venue = Venue.find(params[:id])
    if current_user.voted_for? @venue
      current_user.unvote_for @venue
    else
      current_user.up_votes @venue
    end

  end

end
