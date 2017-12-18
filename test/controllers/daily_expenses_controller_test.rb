require 'test_helper'

class DailyExpensesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get daily_expenses_new_url
    assert_response :success
  end

  test "should get show" do
    get daily_expenses_show_url
    assert_response :success
  end

  test "should get edit" do
    get daily_expenses_edit_url
    assert_response :success
  end

  test "should get destroy" do
    get daily_expenses_destroy_url
    assert_response :success
  end

end
