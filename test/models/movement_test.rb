require "test_helper"

class MovementTest < ActiveSupport::TestCase

  test 'valid Movement if all params are set' do
    valid_movement = movements(:one)

    assert valid_movement.valid?
  end

  test 'invalid movement if not params are set' do
    invalid_movement = Movement.new

    assert_not invalid_movement.valid?
  end

  test 'invalid Movement if no concept' do
    invalid_movement = Movement.new(
      description: Faker::Commerce.product_name,
      original_amount: Faker::Number.decimal(r_digits: 2),
      original_currency: Faker::Currency.code,
      movement_date: Faker::Date.new,
      settled_date: Faker::Date.new,
      asset_id: assets(:bank).id
    )

    assert_not invalid_movement.valid?
  end

  test 'valid Movement if no description' do
    valid_movement = Movement.new(
      concept: Faker::Commerce.brand,
      original_amount: Faker::Number.decimal(r_digits: 2),
      original_currency: Faker::Currency.code,
      movement_date: Faker::Date.new,
      settled_date: Faker::Date.new,
      asset_id: assets(:bank).id
    )

    assert valid_movement.valid?
  end

  test 'invalid Movement if no original amount' do
    invalid_movement = Movement.new(
      concept: Faker::Commerce.brand,
      description: Faker::Commerce.product_name,
      original_currency: Faker::Currency.code,
      movement_date: Faker::Date.new,
      settled_date: Faker::Date.new,
      asset_id: assets(:bank).id
    )

    assert_not invalid_movement.valid?
  end

  test 'invalid Movement if no original currency' do
    invalid_movement = Movement.new(
      concept: Faker::Commerce.brand,
      description: Faker::Commerce.product_name,
      original_amount: Faker::Number.decimal(r_digits: 2),
      movement_date: Faker::Date.new,
      settled_date: Faker::Date.new,
      asset_id: assets(:bank).id
    )

    assert_not invalid_movement.valid?
  end

  test 'invalid Movement if no movement date' do
    invalid_movement = Movement.new(
      concept: Faker::Commerce.brand,
      description: Faker::Commerce.product_name,
      original_amount: Faker::Number.decimal(r_digits: 2),
      original_currency: Faker::Currency.code,
      settled_date: Faker::Date.new,
      asset_id: assets(:bank).id
    )

    assert_not invalid_movement.valid?
  end

  test 'invalid Movement if no settled date' do
    invalid_movement = Movement.new(
      concept: Faker::Commerce.brand,
      description: Faker::Commerce.product_name,
      original_amount: Faker::Number.decimal(r_digits: 2),
      original_currency: Faker::Currency.code,
      movement_date: Faker::Date.new,
      asset_id: assets(:bank).id
    )

    assert_not invalid_movement.valid?
  end

  test 'invalid Movement if no Asset id' do
    invalid_movement = Movement.new(
      concept: Faker::Commerce.brand,
      description: Faker::Commerce.product_name,
      original_amount: Faker::Number.decimal(r_digits: 2),
      original_currency: Faker::Currency.code,
      movement_date: Faker::Date.new,
      settled_date: Faker::Date.new
    )

    assert_not invalid_movement.valid?
  end
end
