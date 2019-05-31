require "pry"

def consolidate_cart(cart)
  cart_out = {}
  cart.each do |item|
    if cart_out.has_key?(item.keys[0])
      cart_out[item.keys[0]][:count] += 1
    else
      cart_out[item.keys[0]] = { :price => item[item.keys[0]][:price], :clearance => item[item.keys[0]][:clearance], :count => 1 }
    end
  end
  cart_out
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    if cart.has_key?(coupon[:item])
      new_item = cart[coupon[:item]]
      new_item_name = "#{coupon[:item]} W/COUPON"
      binding.pry
      if coupon[:num] > cart[coupon[:item]][:count]
        cart[coupon[:item]] = {}
      else
        cart[coupon[:item]][:count] -= coupon[:num]
      end
      new_item[:price] = coupon[:cost]
      new_item[:count] = 1
      cart[new_item_name] = new_item
    end
  end
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
