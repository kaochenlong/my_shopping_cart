require 'rails_helper'

RSpec.describe Cart, type: :model do

  let(:cart) { Cart.new }

  describe "基本功能" do
    it "可以把商品丟到到購物車裡，然後購物車裡就有東西了。" do
      cart.add_item 1
      expect(cart).not_to be_empty
    end

    it "加了相同商品到購物車裡，購買項目不會增加，但數量會改變。" do
      3.times { cart.add_item 1 }
      5.times { cart.add_item 2 }

      expect(cart.items.length).to be 2
      expect(cart.items.first.quantity).to be 3
      expect(cart.items.last.quantity).to be 5
    end

    it "商品可以放到購物車裡，也可以再拿出來。" do
      p1 = FactoryGirl.create(:product)
      p2 = FactoryGirl.create(:product)

      3.times { cart.add_item(p1.id) }
      4.times { cart.add_item(p2.id) }

      expect(cart.items.last.product_id).to be p2.id
      expect(cart.items.first.product).to be_kind_of Product
    end

    it "可以計算整台購物車的總消費金額。" do
      p1 = FactoryGirl.create(:product, :price_100)
      p2 = FactoryGirl.create(:product, :price_200)

      3.times { cart.add_item(p1.id) }
      4.times { cart.add_item(p2.id) }

      expect(cart.total_price).to be 1100
    end

    it "特別活動 - 或是滿額滿千元折百元" do
      p1 = FactoryGirl.create(:product, :price_100)
      p2 = FactoryGirl.create(:product, :price_200)

      3.times { cart.add_item(p1.id) }
      4.times { cart.add_item(p2.id) }

      # 每年 1 月
      t = Time.local(2017, 1, 10, 10, 5, 0)
      Timecop.travel(t) {
        expect(cart.total_price).to be (1100 - 100)
      }
    end

    #it "特別活動 - 聖誕節的時候全面打 9 折"
  end

  describe "進階功能" do
    it "可以將購物車內容轉換成 Hash 並存到 Session 裡。" do
      3.times { cart.add_item 1 }
      2.times { cart.add_item 2 }

      expect(cart.to_hash).to eq cart_hash
    end

    it "也可以存放在 Session 的內容（Hash 格式），還原成購物車的內容。" do
      cart = Cart.from_hash(cart_hash)

      expect(cart.items.length).to be 2
      expect(cart.items.first.product_id).to be 1
      expect(cart.items.last.quantity).to be 2
    end

    private
    def cart_hash
      {
        "items" => [
          {"product_id" => 1, "quantity" => 3},
          {"product_id" => 2, "quantity" => 2}
        ]
      }
    end
  end
end
