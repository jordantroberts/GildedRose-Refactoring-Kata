require_relative 'gilded_rose'

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end

  def out_of_date?
    @sell_in < 0
  end

  def increase_quality
    @quality += 1
  end

  def decrease_quality
    @quality -= 1
  end
end
