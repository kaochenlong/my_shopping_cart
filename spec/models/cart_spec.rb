require 'rails_helper'

RSpec.describe Cart, type: :model do

  describe "基本功能" do
    it "可以把商品丟到到購物車裡，然後購物車裡就有東西了。" do
      cart = Cart.new
      cart.add_item 1
      expect(cart.empty?).to be false
      #expect(cart).not_to be_empty
    end

    it "加了相同商品到購物車裡，購買項目不會增加，但數量會改變。" do
      cart = Cart.new
      3.times { cart.add_item 1 }
      5.times { cart.add_item 2 }

      expect(cart.items.length).to be 2
      expect(cart.items.first.quantity).to be 3
      expect(cart.items.last.quantity).to be 5
    end

    it "商品可以放到購物車裡，也可以再拿出來。" do
      p1 = Product.create(title: "P1", price: 100)
      p2 = Product.create(title: "P2", price: 200)

      cart = Cart.new
      3.times { cart.add_item(p1.id) }
      4.times { cart.add_item(p2.id) }

      expect(cart.items.last.product_id).to be p2.id
      expect(cart.items.first.product).to be_kind_of Product
    end

    #it "可以計算整台購物車的總消費金額。"
    #it "特別活動可能可搭配折扣（例如聖誕節的時候全面打 9 折，或是滿額滿千送百或滿額免運費）。"
  end

  describe "進階功能" do
    #it "可以將購物車內容轉換成 Hash 並存到 Session 裡。"
    #it "也可以存放在 Session 的內容（Hash 格式），還原成購物車的內容。"
  end
end
