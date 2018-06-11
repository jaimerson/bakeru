module Bakeru
  class Location < ::ActiveRecord::Base
    validates :template, :tiles, presence: true

    belongs_to :character

    def self.build(template, attributes={})
      new(
        {
          tiles: template.map,
          template: template.to_s
        }.merge(attributes)
      )
    end
  end
end
