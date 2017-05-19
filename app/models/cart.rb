class Cart
  def initialize
    @items = []
  end

  def add_item(n)
    @items << n
  end

  def empty?
    @items.empty?
  end
end
