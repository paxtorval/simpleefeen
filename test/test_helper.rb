ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require 'minitest/mock'
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    Faker::Config.random = Random.new
    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end
