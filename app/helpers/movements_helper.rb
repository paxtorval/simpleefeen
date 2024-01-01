module MovementsHelper

    def self.get_all_assets
        Asset.all.map { |asset| [asset.name, asset.id] }
    end
end
