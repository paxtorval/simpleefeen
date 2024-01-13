require "test_helper"

class AssetTest < ActiveSupport::TestCase

  test 'valid Asset if all params are set' do
    valid_asset = assets(:bank)

    assert valid_asset.valid?
  end

  test 'invalid Asset if no params are set' do
    invalid_asset = Asset.new

    assert_not invalid_asset.valid?
  end

  test 'invalid Asset if no kind' do
    invalid_asset = Asset.new(
      country: Faker::Address.country_code,
      currency: Faker::Currency.code,
      name: Faker::Bank.name,
      description: Faker::String.random
    )

    assert_not invalid_asset.valid?
  end

  test 'invalid Asset if no country' do
    invalid_asset = Asset.new(
      kind: Asset.kinds[:bank_account],
      currency: Faker::Currency.code,
      name: Faker::Bank.name,
      description: Faker::String.random
    )

    assert_not invalid_asset.valid?
  end

  test 'invalid Asset if no currency' do
    invalid_asset = Asset.new(
      kind: Asset.kinds[:bank_account],
      country: Faker::Address.country_code,
      name: Faker::Bank.name,
      description: Faker::String.random
    )

    assert_not invalid_asset.valid?
  end

  test 'invalid Asset if no name' do
    invalid_asset = Asset.new(
      kind: Asset.kinds[:bank_account],
      country: Faker::Address.country_code,
      currency: Faker::Currency.code,
      description: Faker::String.random
    )

    assert_not invalid_asset.valid?
  end

  test 'valid Asset if no description' do
    invalid_asset = Asset.new(
      kind: Asset.kinds[:bank_account],
      country: Faker::Address.country_code,
      currency: Faker::Currency.code,
      name: Faker::Bank.name
    )

    assert invalid_asset.valid?
  end
end
