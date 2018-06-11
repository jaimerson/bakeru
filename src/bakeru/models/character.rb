require 'bakeru/models/imp'
require 'bakeru/models/weapon'
require 'bakeru/models/equipment'

module Bakeru
  class Character < ::ActiveRecord::Base
    validates :color, presence: true, inclusion: { in: Imp::COLORS }

    validates :name, presence: true
    has_many :locations
    has_one :inventory
    has_one :equipment
    has_one :weapon, through: :equipment, foreign_key: :right_hand_item_id, source: :right_hand_item
  end
end
