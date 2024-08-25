require "application_system_test_case"

class ImportConfigsTest < ApplicationSystemTestCase
  setup do
    @import_config = import_configs(:one)
  end

  test "visiting the index" do
    visit import_configs_url
    assert_selector "h1", text: "Import configs"
  end

  test "should create import config" do
    visit import_configs_url
    click_on "New import config"

    fill_in "Asset", with: @import_config.asset_id
    fill_in "Config", with: @import_config.config
    click_on "Create Import config"

    assert_text "Import config was successfully created"
    click_on "Back"
  end

  test "should update Import config" do
    visit import_config_url(@import_config)
    click_on "Edit this import config", match: :first

    fill_in "Asset", with: @import_config.asset_id
    fill_in "Config", with: @import_config.config
    click_on "Update Import config"

    assert_text "Import config was successfully updated"
    click_on "Back"
  end

  test "should destroy Import config" do
    visit import_config_url(@import_config)
    click_on "Destroy this import config", match: :first

    assert_text "Import config was successfully destroyed"
  end
end
