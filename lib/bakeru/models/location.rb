module Bakeru
  class Location < ::ActiveRecord::Base
    validates :template, :tiles, presence: true

    belongs_to :character
    has_many :item_locations
    has_many :items, through: :item_locations

    accepts_nested_attributes_for :item_locations

    def self.build(template, attributes={})
      new(
        {
          tiles: template.map,
          template: template.to_s,
          item_locations_attributes: template.item_locations
        }.merge(attributes)
      )
    end
  end
end
