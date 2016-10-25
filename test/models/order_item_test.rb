require 'test_helper'

class OrderItemTest < ActiveSupport::TestCase
  test "Create an OrderItem with valid data" do
    order_item = order_items(:one)
    assert order_item.valid?
  end

  test "Must have positive quantity" do
    order_item1 = order_items(:one)
    order_item2 = OrderItem.new(quantity: -4)
    assert order_item1.valid?
    assert_not order_item2.valid?

    assert_includes order_item2.errors, :quantity

  end

  test "Will create a total sum for all the order items associated with an order upon purchasing" do
    # @order_items.sum_total_prices

  end

end
