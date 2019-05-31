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
  #binding.pry
  cart_out
end

def apply_coupons(cart, coupons)
  debug = false
  if coupons.find_index{|x| x[:item] == "AVOCADO"} != nil
    #binding.pry
    debug = true
  end
  coupons.each do |coupon|
    if cart.has_key?(coupon[:item])
      new_item_name = "#{coupon[:item]} W/COUPON"
      previous_count = 0
      if cart.has_key?(new_item_name)
        #previous_count = cart[new_item_name][:count]
      end
      new_item = {:price => coupon[:cost], :clearance => false, :count=> previous_count}
      count_coupons_added = 0
      if coupon[:num] > cart[coupon[:item]][:count]
        count_coupons_added = 1
        coupon[:num] -= cart[coupon[:item]][:count]
        cart[coupon[:item]][:count] = 0
        #binding.pry
      elsif coupon[:num] <= cart[coupon[:item]][:count]
        count_coupons_added = 1
        cart[coupon[:item]][:count] -= coupon[:num]
        coupon[:num] = 0
        if debug
          binding.pry
        end
      end
      if cart[coupon[:item]][:count] == 0
        #cart.delete(coupon[:item])
      end
      new_item[:count] += count_coupons_added
      new_item[:clearance] = cart[coupon[:item]][:clearance]
      cart[new_item_name] = new_item
      if debug
        binding.pry
      end
      #binding.pry
    end
  end
  #binding.pry
  cart
end

def apply_clearance(cart)
  if cart.class != Hash
    cart.each do |item|
      binding.pry
      if item[1][:clearance]
        item[1][:price] = ( item[1][:price] * 0.8).round(2)
      end
    end
  else
    #binding.pry
    cart.keys.each do |item_name|
      if cart[item_name][:clearance]
        cart[item_name][:price] = (cart[item_name][:price] * 0.8).round(2)
      end
    end
  end
  cart
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  if cart.has_key?("BEER") && cart["BEER"][:count] == 3
    #binding.pry
  end
  apply_coupons(cart, coupons)
    #binding.pry
  apply_clearance(cart)
  #binding.pry
  total_cost = 0
  cart.keys.each do |item_name|
    total_cost += (cart[item_name][:price] * cart[item_name][:count])
  end
  if total_cost > 100
    total_cost = (total_cost * 0.9).round(2)
  end
  total_cost
end
