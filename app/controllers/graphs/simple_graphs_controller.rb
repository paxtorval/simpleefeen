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
      time_unit = params[:time_unit]
      number_of_units = params[:number_of_units]

      debits = Movement.where('original_amount >= 0')
                       .group_by_month(:settled_date, range: start_time(number_of_units, time_unit).ago..Time.now)
                       .sum(:original_amount)

      credits = Movement.where('original_amount < 0')
                        .group_by_month(:settled_date, range: start_time(number_of_units, time_unit).ago..Time.now)
                        .sum(:original_amount)
      credits.transform_values!(&:abs)

      puts debits.inspect
      puts credits.inspect
      render json: [
        {
          name: 'Debits', data: debits
        },
        {
          name: 'Credits', data: credits
        }
      ]
    end

    private

    def start_time(number, time_unit)
      normalised_number = number&.to_i&.positive? ? number.to_i : 1
      normalised_time_unit = time_unit.presence || 'month'

      normalised_number.send(normalised_time_unit)
    end
  end
end
