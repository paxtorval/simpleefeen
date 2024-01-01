module AssetsHelper

    def self.all_currencies
        Money::Currency.all.map { | currency | currency.id.to_s.upcase }
    end
end
