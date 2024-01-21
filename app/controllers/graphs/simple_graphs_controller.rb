module Graphs
  class SimpleGraphsController < ApplicationController

    def credits_vs_debits
      debits = Movement.where('original_amount >= 0').sum(:original_amount)
      credits = Movement.where('original_amount < 0').sum(:original_amount).abs
      total = Movement.all.count
      Rails.logger.info "#{debits} Debits + #{credits} Credits = #{total}"

      render json: {
        'Debits' => debits,
        'Credits' => credits
      }
    end

    def movements_by_day
      debits = Movement.where('original_amount >= 0').group_by_month(:settled_date, range: 10.months.ago..Time.now).sum(:original_amount)

      credits = Movement.where('original_amount < 0').group_by_month(:settled_date, range: 10.months.ago..Time.now).sum(:original_amount)
      credits.transform_values! { |value| value.abs }

      puts debits.inspect
      puts credits.inspect
      render json: [
        {
          name: 'Debits', data: debits
        },
        {
          name: 'Credits', data: credits
        }]
    end
  end
end