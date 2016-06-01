class Price
  #.freeze makes constants imutable and are a bit more performant
  LIST = { a: 50, b: 30, c: 20, d: 15 }.freeze

  def self.for(item)
    LIST[item]
  end
end

class Discount
  #Im being an arse but have a space after the curl on hashes (Most of my PR reviews are comments about that)
  #It should also probably not be a single line as well but its minor
  DISCOUNTS = { a: { quantity: 3, discount: 20 } }.freeze

  #We go with using class << self over self.method_name. There is no performance benefit, its just easier to see static methods
  class << self
    def calculate_discount(sku, quantity)
      return 0 unless DISCOUNTS.key? sku

      discount_quantity = DISCOUNTS[sku][:quantity]
      eligible_count = (quantity / discount_quantity).floor
      eligible_count * DISCOUNTS[sku][:discount]
    end

    def for(basket)
      basket
        .map { |k, v| { sku: k, items: v } }
        .reduce(0) do |memo, i|
          #Minor but we tend to add () to methods. Just for consistency
          #No need for += in a reduce. It just takes the returned value anyway
          memo + calculate_discount(i[:sku], i[:items].length)
        end
    end
  end
end

class Checkout
  #This is a different way of setting up items
  #Trivial for this case but if this was doing something heavy its worth it
  #If nil set as []
  def items
    @items ||= []
  end

  def scan(item)
    items.push(item)
  end

  def sub_total(basket)
    basket
      .map { |k, v| { sku: k, qty: v.length } }
      .reduce(0) do |memo, i|
        memo + Price.for(i[:sku]) * i[:qty]
      end
  end

  def total
    basket = items.group_by { |i| i }
    sub_total(basket) - Discount.for(basket)
  end
end
