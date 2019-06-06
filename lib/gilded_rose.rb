require_relative 'item'

class GildedRose

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
      if item.conjured?
        item.decrease_double
      end
      if !item.special_item?
        if item.quality > 0
          if item.name != "Sulfuras, Hand of Ragnaros"
            item.decrease_quality
          end
        end
      else
        if item.quality < 50
          item.increase_quality
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
            if item.sell_in < 0
              if item.quality < 50
                return item.reset_quality
              end
            end
          end
        end
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
