module Bakeru
  class Inventory < ::ActiveRecord::Base
    belongs_to :character
    has_many :items
  end
end
