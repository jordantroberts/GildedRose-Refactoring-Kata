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
      if conjured?(item)
        decrease_double(item)
      end
      if !special_item?(item)
        not_legendary_item(item)
      else
          increase_quality(item)
          if item.name == "Backstage passes to a TAFKAL80ETC concert"
            if item.sell_in < 11
              increase_quality(item)
            end
            if item.sell_in < 6
              increase_quality(item)
            end
            if item.sell_in < 0 && item.quality < 50
              return item.quality = 0
            end
          
        end
      end
      if out_of_date?(item)
        if !special_item?(item)
          not_legendary_item(item)
        else
          increase_quality(item)
        end
      end
    end
  end

  private

  def conjured?(item)
    item.name == "Conjured"
  end

  def special_item?(item)
    item.name == "Aged Brie" || item.name == "Backstage passes to a TAFKAL80ETC concert"
  end

  def out_of_date?(item)
    item.sell_in < 0
  end

  def increase_quality(item)
    item.quality += 1 if below_max_quality?(item)
  end

  def decrease_quality(item)
    item.quality -= 1
  end

  def decrease_double(item)
    item.quality -= 2
  end

  def below_max_quality?(item)
    item.quality < MAXIMUM_QUALITY
  end

  def not_legendary_item(item)
    if item.quality > 0 && item.name != "Sulfuras, Hand of Ragnaros"
      decrease_quality(item)
    end
  end
end
