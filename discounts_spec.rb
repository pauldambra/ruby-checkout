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
  describe "scanning a 3 As" do
    it "returns a total of 130" do
      checkout = Checkout.new
      checkout.scan(:a)
      checkout.scan(:a)
      checkout.scan(:a)
      expect(checkout.total).to eq(130)
    end
  end
end
