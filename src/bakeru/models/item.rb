module Bakeru
  class Item < ::ActiveRecord::Base
    belongs_to :inventory
    validates :name, presence: true
  end
end
