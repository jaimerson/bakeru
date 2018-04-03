require 'active_record_setup'
require 'models/imp'

class Account < ActiveRecord::Base
  validates :color, presence: true, inclusion: { in: Imp::COLORS }
  validates :weapon, presence: true, inclusion: { in: Imp::WEAPONS }
end
