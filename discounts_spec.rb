require './checkout'
#
# Item   Unit      Special
#        Price     Price
# --------------------------
#   A     50       3 for 130
#   B     30       2 for 45
#   C     20
#   D     15
#
RSpec.describe Checkout do
  describe "scanning multiples of a sku with no discount" do
    it "returns the total as expected" do
      checkout = Checkout.new
      checkout.scan(:c)
      checkout.scan(:c)
      checkout.scan(:c)
      expect(checkout.total).to eq(60)
    end
  end
  describe "scanning 3 As" do
    it "returns a total of 130" do
      checkout = Checkout.new
      checkout.scan(:a)
      checkout.scan(:a)
      checkout.scan(:a)
      expect(checkout.total).to eq(130)
    end
  end

  describe "scanning 5 As" do
    it "returns a total of 230" do
      checkout = Checkout.new
      checkout.scan(:a)
      checkout.scan(:a)
      checkout.scan(:a)
      checkout.scan(:a)
      checkout.scan(:a)
      expect(checkout.total).to eq(230)
    end
  end

  describe "scanning 6 As" do
    it "returns a total of 260" do
      checkout = Checkout.new
      checkout.scan(:a)
      checkout.scan(:a)
      checkout.scan(:a)
      checkout.scan(:a)
      checkout.scan(:a)
      checkout.scan(:a)
      expect(checkout.total).to eq(260)
    end
  end
end
