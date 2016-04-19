require 'bigdecimal'
require 'bigdecimal/util'
require 'yaml'

module BadgesCalculator
  class << self

    def load_unit_prices
      @unit_prices = YAML.load_file('config.yml')['unit_prices']
    end

    def calculate_price(quantity)
      @unit_prices ||= load_unit_prices
      unit_price = @unit_prices.select{ |range| (range.first...range.last).include?(quantity) }
      x0, x1, y0, y1 = unit_price.flatten(2)
      x1 = 1 if x1 == Float::INFINITY
      total_price = quantity.to_d * interpolate(x0, y0, x1, y1, quantity)
      total_price.round(2).to_s('F')
    end

    def interpolate(x0, y0, x1, y1, x2)
      y2 = y0.to_d + ((y1.to_d - y0.to_d) * (x2.to_d - x0.to_d) / (x1.to_d - x0.to_d))
    end
  end
end