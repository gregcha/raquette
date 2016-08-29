class AddVenueAndCourtToResults < ActiveRecord::Migration[5.0]
  def change
    add_reference :results, :venue , index: true
    add_reference :results, :court , index: true
  end
end
