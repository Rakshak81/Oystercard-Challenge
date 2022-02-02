# frozen_string_literal: true

require_relative '../lib/oystercard'
require_relative '../lib/station'

# In order to know where I have been
# As a customer
# I want to see all my previous trips

describe "User Story 9:" do
  it "show previous trips" do
    oyster_card = Oystercard.new
    entry_station = Station.new("Oxford")
    exit_station = Station.new("Holborn")
    oyster_card.top_up(5)
    oyster_card.touch_in(entry_station)
    oyster_card.touch_out(exit_station)
    expect(oyster_card.journeys).to include({:entry_station => entry_station, :exit_station => exit_station})
  end
end
