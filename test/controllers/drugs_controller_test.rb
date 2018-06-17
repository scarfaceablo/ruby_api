require 'test_helper'

class DrugsControllerTest < ActionDispatch::IntegrationTest

  test "get_data" do
    
    get "/api/v1/drugs"
    assert_response 400
  end

  test "get_data_by_user_type" do

    get "/api/v1/drugs?user_type=MD"
    assert_response :success

  end

  test "get_data_by_non-existing_user_type" do

    get "/api/v1/drugs?user_type=dd"
    assert_response :missing

  end

  test "get_data_by_user_type_and_insurance_list" do

    get "/api/v1/drugs?user_type=MD&insurance_list=A"
    assert_response :success

  end

  test "get_data_by_user_type_and_insurance_list_multiple" do

    get "/api/v1/drugs?user_type=MD&insurance_list=A+B"
    assert_response :success

  end

  test "get_data_by_user_type_and_insurance_list_emtpy" do

    get "/api/v1/drugs?user_type=Student&insurance_list="
    assert_response 400

  end

end
