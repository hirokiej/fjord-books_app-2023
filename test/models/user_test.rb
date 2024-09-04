# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test '#name_or_email' do
    assert_equal 'Alice', users(:alice).name_or_email
  end
end
