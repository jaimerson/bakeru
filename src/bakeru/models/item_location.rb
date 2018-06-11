module Bakeru
  class ItemLocation < ::ActiveRecord::Base
    belongs_to :item
    belongs_to :location

    validates :map_location, presence: true, format: /\d+,\d+/
  end
end
