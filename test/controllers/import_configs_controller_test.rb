require "test_helper"

class ImportConfigsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @import_config = import_configs(:one)
  end

  test "should get index" do
    get import_configs_url
    assert_response :success
  end

  test "should get new" do
    get new_import_config_url
    assert_response :success
  end

  test "should create import_config" do
    assert_difference("ImportConfig.count") do
      post import_configs_url, params: { import_config: { asset_id: @import_config.asset_id, config: @import_config.config } }
    end

    assert_redirected_to import_config_url(ImportConfig.last)
  end

  test "should show import_config" do
    get import_config_url(@import_config)
    assert_response :success
  end

  test "should get edit" do
    get edit_import_config_url(@import_config)
    assert_response :success
  end

  test "should update import_config" do
    patch import_config_url(@import_config), params: { import_config: { asset_id: @import_config.asset_id, config: @import_config.config } }
    assert_redirected_to import_config_url(@import_config)
  end

  test "should destroy import_config" do
    assert_difference("ImportConfig.count", -1) do
      delete import_config_url(@import_config)
    end

    assert_redirected_to import_configs_url
  end
end
