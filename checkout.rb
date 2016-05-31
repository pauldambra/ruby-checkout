class Price
  LIST = {a: 50, b: 30, c: 20, d: 15}

  def self.for(item)
    LIST[item]
  end
end

class Discount
  DISCOUNTS = {a: {quantity: 3, discount:20}}

  def self.calculate_discount(sku, quantity)
    return 0 unless DISCOUNTS.key? sku

    discount_quantity = DISCOUNTS[sku][:quantity]
    eligible_count = (quantity / discount_quantity).floor
    eligible_count * DISCOUNTS[sku][:discount]
  end

  def self.for(basket)
    basket
      .map { |k, v| {sku: k, items: v} }
      .reduce(0) do |memo, i|
        memo += calculate_discount i[:sku], i[:items].length
      end
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
    sub_total(basket) - Discount.for(basket)
  end
end
