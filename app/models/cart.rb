class Cart
  attr_reader :items

  def initialize
    @items = []
  end

  def add_item(n)
    found_item = items.find { |item| item.product_id == n }

    if found_item
      found_item.increment
    else
      items << CartItem.new(n)
    end
  end

  def empty?
    items.empty?
  end

  def total_price
    total = items.reduce(0) { |total, item| total + item.total_price }

    if Time.now.month == 1 && total >= 1000
      total -= 100
    else
      total
    end
  end
end

