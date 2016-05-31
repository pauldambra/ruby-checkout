class Price
  LIST = {a: 50, b: 30, c: 20, d: 15}

  def self.for(item)
    LIST[item]
  end
end

class Discount
  @discounts = {a: {quantity: 3, discount:20}}
  def self.for(basket)
    0
  end
end

class Checkout
  def initialize
    @items = []
  end

  def scan(item)
    @items.push(item)
  end

  def sub_total(basket)
   basket
    .map { |k, v| {sku: k, qty: v.length} }
    .reduce(0) do |memo, i|
     memo += Price.for(i[:sku]) * i[:qty]
   end
  end

  def total
    basket = @items.group_by { |i| i }
                  #  .map { |k, v| {k => v.length} }
                  #  .reduce(:merge)
    sub_total(basket) - Discount.for(basket)
  end
end
