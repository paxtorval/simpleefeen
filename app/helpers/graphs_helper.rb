module GraphsHelper
  def self.get_time_units
    [
      ['Month', 'month'], ['Year', 'year']
    ]
  end
  
  def self.get_unit_numbers
    (1..12).each.map { |x| [x, x] }
  end
end
