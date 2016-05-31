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
  describe "scanning a single A" do
    it "returns a total of 50" do
      checkout = Checkout.new
      checkout.scan(:a)
      expect(checkout.total).to eq(50)
    end
  end

  describe "scanning 2 As" do
    it "returns a total of 100" do
      checkout = Checkout.new
      checkout.scan(:a)
      checkout.scan(:a)
      expect(checkout.total).to eq(100)
    end
  end

  describe "scanning a single B" do
    it "returns a total of 30" do
      checkout = Checkout.new
      checkout.scan(:b)
      expect(checkout.total).to eq(30)
    end
  end

  describe "scanning a single C" do
    it "returns a total of 20" do
      checkout = Checkout.new
      checkout.scan(:c)
      expect(checkout.total).to eq(20)
    end
  end

  describe "scanning a single D" do
    it "returns a total of 15" do
      checkout = Checkout.new
      checkout.scan(:d)
      expect(checkout.total).to eq(15)
    end
  end

  describe "scanning one of each" do
    it "returns a total of 115" do
      checkout = Checkout.new
      checkout.scan(:d)
      checkout.scan(:c)
      checkout.scan(:b)
      checkout.scan(:a)
      expect(checkout.total).to eq(115)
    end
  end
end
