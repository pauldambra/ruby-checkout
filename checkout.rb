class Price
  def self.list
    {a: 50, b: 30, c: 20, d: 15}
  end
end

class Checkout
  def initialize
    @items = []
  end

  def scan(item)
    @items.push(item)
  end

  def total
    @items.reduce(0) { |memo, item| memo += Price.list[item] }
  end
end
