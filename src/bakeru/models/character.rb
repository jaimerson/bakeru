require 'bakeru/active_record_setup'
require 'bakeru/models/imp'

module Bakeru
  class Character < ::ActiveRecord::Base
    validates :color, presence: true, inclusion: { in: Imp::COLORS }
    validates :weapon, presence: true, inclusion: { in: Imp::WEAPONS }
  end
end