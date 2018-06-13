module Bakeru
  class Equipment < ::ActiveRecord::Base
    belongs_to :left_hand_item, class_name: 'Bakeru::Shield'
    belongs_to :right_hand_item, class_name: 'Bakeru::Weapon'
  end
end
