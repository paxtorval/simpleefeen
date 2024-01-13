require "test_helper"

class ImportMovementsJobTest < ActiveJob::TestCase
  include ActiveJob::TestHelper

  SUCCESS_TEST_FILE = "#{Rails.root.to_s}/test/jobs/Movements to_test.xlsx".freeze
  ERROR_HEADER_TEST_FILE = "#{Rails.root.to_s}/test/jobs/invalid_header_file.xlsx".freeze
  ERROR_VALUES_TEST_FILE = "#{Rails.root.to_s}/test/jobs/invalid_value_file.xlsx".freeze
  ERROR_FILE_TEST_FILE = "#{Rails.root.to_s}/test/jobs/invalid_file.txt".freeze

  test 'successfully imports an excel file' do
    assert_difference 'Movement.all.count', 5 do
      assert_performed_jobs 0

      perform_enqueued_jobs do
        ImportMovementsJob.perform_later(SUCCESS_TEST_FILE, assets(:bank).id)
      end

      assert_performed_jobs 1
      assert_no_enqueued_jobs
    end
  end

  test 'does not retry the job if it does not find any column expected in the header row' do
    assert_performed_jobs 0

    perform_enqueued_jobs do
      ImportMovementsJob.perform_later(ERROR_HEADER_TEST_FILE, assets(:bank).id)
    end

    assert_performed_jobs 1
    assert_no_enqueued_jobs
  end

  test 'does not retry the job if there are missing values in the expected columns' do
    assert_performed_jobs 0

    perform_enqueued_jobs do
      ImportMovementsJob.perform_later(ERROR_VALUES_TEST_FILE, assets(:bank).id)
    end

    assert_performed_jobs 1
    assert_no_enqueued_jobs
  end

  test 'does not retry the job if no asset id is passed' do
    assert_performed_jobs 0

    perform_enqueued_jobs do
      ImportMovementsJob.perform_later(SUCCESS_TEST_FILE, nil)
    end

    assert_performed_jobs 1
    assert_no_enqueued_jobs
  end

  test 'does not retry the job if no file is passed' do
    assert_performed_jobs 0

    perform_enqueued_jobs do
      ImportMovementsJob.perform_later(nil, assets(:bank).id)
    end

    assert_performed_jobs 1
    assert_no_enqueued_jobs
  end

  test 'does not retry the job if an invalid file is passed' do
    assert_performed_jobs 0

    perform_enqueued_jobs do
      ImportMovementsJob.perform_later(ERROR_FILE_TEST_FILE, assets(:bank).id)
    end

    assert_performed_jobs 1
    assert_no_enqueued_jobs
  end
end
