# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test '#editanble' do
    assert reports(:alice_report).editable?(users(:alice))

    assert_not reports(:alice_report).editable?(users(:bob))
  end

  test '#created_on' do
    travel_to Time.zone.local(2024, 9, 1, 12, 0, 0)
    reports(:alice_report).created_at = Time.current
    assert_equal Date.new(2024, 9, 1), reports(:alice_report).created_on
  end
end
