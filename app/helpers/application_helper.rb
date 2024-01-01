module ApplicationHelper

    class << self
        def all_currencies
            Money::Currency.all.map { | currency | currency.id.to_s.upcase }
        end

        def asset_name_by_id(id)
            Asset.find(id).name
        end
    end
end
