require_relative 'item'

class GildedRose

  MAXIMUM_QUALITY = 50

  def initialize(items)
    @items = items
  end

  def update
    update_sell_in
    update_quality
  end

  def update_sell_in
    @items.each do |item|
      if item.name != "Sulfuras, Hand of Ragnaros"
        item.sell_in -= 1
      end
    end
  end

  def update_quality
    @items.each do |item|
      decrease_quality(item)
      decrease_quality(item) if out_of_date?(item)
        if item.name == "Aged Brie"
          increase_quality(item)
          increase_quality(item) if out_of_date?(item)
        end
        if item.name == "Backstage passes to a TAFKAL80ETC concert"
          increase_double(item)
          increase_quality(item) if item.sell_in < 11
          increase_quality(item) if item.sell_in < 6
          return item.quality = 0 if out_of_date?(item)
        end
      end
    end


  private

  def conjured?(item)
    item.name == "Conjured"
  end

  def out_of_date?(item)
    item.sell_in < 0
  end

  def increase_quality(item)
    item.quality += 1 if below_max_quality?(item)
  end

  def decrease_quality(item)
    if item.name != "Sulfuras, Hand of Ragnaros" && item.name != "Aged Brie"
      if item.quality > 0
        item.quality -= 1
        decrease_double(item) if conjured?(item)
      end
    end
  end

  def decrease_double(item)
    item.quality -= 2
  end

  def increase_double(item)
    item.quality += 2
  end

  def below_max_quality?(item)
    item.quality < MAXIMUM_QUALITY
  end
end
