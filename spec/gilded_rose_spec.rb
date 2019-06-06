require 'gilded_rose'

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality
      expect(items[0].name).to eq "foo"
    end

    it 'decreases quality of item' do
      items = [Item.new("foo", 10, 10)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 9
    end

    it 'quality of item is never negative' do
      items = [Item.new("foo", 10, 0)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 0
    end

    it 'quality of item is never higher than 50' do
      items = [Item.new("Aged Brie", 10, 50)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 50
    end

    it 'aged brie increases in quality' do
      items =[Item.new("Aged Brie", 10, 5)]
      GildedRose.new(items).update
      expect(items[0].quality).to eq 6
    end

    it 'once sell by date passed, quality degrades quicker' do
      items =[Item.new("toast", 0, 4)]
      GildedRose.new(items).update
      expect(items[0].quality).to eq 2
    end

    it 'sulfuras are never sold or decreased in quality' do
      items =[Item.new("Sulfuras, Hand of Ragnaros", 10, 10)]
      GildedRose.new(items).update
      expect(items[0].quality).to eq 10
      expect(items[0].sell_in).to eq 10
    end

    it 'backstage passes increase in quality as sell in value approaches' do
      items =[Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 5)]
      GildedRose.new(items).update
      expect(items[0].quality).to eq 8
      items =[Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 5)]
      GildedRose.new(items).update
      expect(items[0].quality).to eq 7
      items =[Item.new("Backstage passes to a TAFKAL80ETC concert", -1, 2)]
      GildedRose.new(items).update
      expect(items[0].quality).to eq 0
    end

    it 'conjured items degrade twice as fast' do
      items =[Item.new("Conjured", 5, 5)]
      GildedRose.new(items).update
      expect(items[0].quality).to eq 2
    end
  end
end
