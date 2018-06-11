require 'bakeru/models/item_location'

module Bakeru
  class Item < ::ActiveRecord::Base
    belongs_to :inventory
    has_one :item_location
    has_one :location, through: :item_location

    validates :name, presence: true
  end
end
