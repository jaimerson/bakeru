module Bakeru
  class Shield < Item
    def defense
      data['defense'] || DEFAULT_DEFENSE
    end

    def defense=(value)
      data['defense'] = value
    end
  end
end
