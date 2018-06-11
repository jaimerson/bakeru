require 'bakeru/models/imp'

module Bakeru
  class Character < ::ActiveRecord::Base
    validates :color, presence: true, inclusion: { in: Imp::COLORS }

    validates :name, presence: true
    has_many :locations
    has_one :inventory
    has_one :equipment
    has_one :weapon, through: :equipment, foreign_key: :right_hand_item_id
  end
end
