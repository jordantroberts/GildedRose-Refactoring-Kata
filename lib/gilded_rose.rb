require_relative 'item'

class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      if !item.special_item?
        if item.quality > 0
          if item.name != "Sulfuras, Hand of Ragnaros"
            item.decrease_quality
          end
        end
      else
        if item.quality < 50
          item.quality = item.quality + 1
          if item.name == "Backstage passes to a TAFKAL80ETC concert"
            if item.sell_in < 11
              if item.quality < 50
                item.increase_quality
              end
            end
            if item.sell_in < 6
              if item.quality < 50
                item.increase_quality
              end
            end
          end
        end
      end
      if item.name != "Sulfuras, Hand of Ragnaros"
        item.sell_in = item.sell_in - 1
      end
      if item.out_of_date?
        if !item.special_item?
          if item.quality > 0
            if item.name != "Sulfuras, Hand of Ragnaros"
              item.decrease_quality
            end
          else
            item.decrease_quality
          end
        else
          if item.quality < 50
            item.increase_quality
          end
        end
      end
    end
  end
end
