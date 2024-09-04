# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test '#editanble' do
    assert reports(:alice).editable?(users(:alice))
  end

  test '#created_on' do
    travel_to Time.zone.local(2024, 9, 1, 12, 0, 0)
    reports(:alice).created_at = Time.current
    assert_equal Date.new(2024, 9, 1), reports(:alice).created_on
  end
end
