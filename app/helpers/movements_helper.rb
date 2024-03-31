module MovementsHelper

    def self.get_all_assets
        Asset.all.map { |asset| [asset.name, asset.id] }
    end

    def self.get_all_categories
        Category.all.map { | category| [category.name, category.id] }
    end
end
