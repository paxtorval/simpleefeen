module ApplicationHelper

    class << self
        def all_currencies
            Money::Currency.all.map { | currency | currency.id.to_s.upcase }
        end

        def all_assets
            Asset.all.map { |asset| [asset.name, asset.id] }
        end

        def asset_name_by_id(id)
            Asset.find(id).name
        end
    end
end
