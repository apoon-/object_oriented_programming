module Round
  #round tax values to nearest 5
  def self.format_tax(amount)
    return amount if (amount % 5) == 0
    amount + 5 - (amount % 5)
  end

  #round price to two decimal places
  def self.format_price(price)
    sprintf("%.2f", price / 100.00)
  end
end

class Product
  def initialize(quantity, name, price)
    @quantity = quantity
    @price = price * 100
    @name = name
  end

  #find price using number of items
  def quantity_total
    @quantity * @price
  end

  #round tax after total found post quantity
  def sales_tax
    Round.format_tax (quantity_total * tax_rate).ceil
  end

  #add quantity total with taxes
  def total
    quantity_total + sales_tax
  end

  #normal tax rate 
  def tax_rate
    0.10
  end

  #print out product name with calculated price to string 
  def to_string
    "#{@quantity} #{@name} : #{Round.format_price(total)}"
  end
end

#exempt tax rate inherit from product superclass
class Exempt < Product
  def tax_rate
    0
  end
end

#import tax rate inherirt from product superclass
class Import < Product
  def tax_rate
    super + 0.05
  end
end

#import & exempt tax rate inherit from exempt class
class ImportedExempt < Exempt
  def tax_rate
    super + 0.05
  end
end

#shoppingcart class to id type of item & print out outputs 
class ShoppingCart
  def initialize
    @products = []
  end

  #splice out item, quantity, price from input product string array 
  def add_item(product_string)
    strings = product_string.split(" ")
    quantity = strings[0].to_i
    price = strings[-1].to_f
    name = strings[1...-2].join(" ")

    @products << product_sort(quantity, name, price)
  end

  #output all calculations for reciept 
  def receipt_output
    calculate_final_total_and_tax

    results = ""
    @products.each {|product| results << "#{product.to_string}\n"}

    results << "-----------------------\nSales Tax: #{Round::format_price(@sales_tax)}\n=======================\n"
    results << "Total: #{Round::format_price(@total)}"
  end

  #privatizes calculate & product sort so outside the class it is inaccessible 
  private
  def calculate_final_total_and_tax
    @total = 0
    @sales_tax = 0

    @products.each do |product|
      @sales_tax += product.sales_tax
      @total += product.total
    end
  end

  #sort type of products by key words 
  def product_sort(quantity, name, price)
    if name.include? ("imported box of chocolates")
      ImportedExempt.new(quantity, name, price)
    elsif name.include?("book") || name.include?("chocolate") || name.include?("pills")
      Exempt.new(quantity, name, price)
    elsif name.include?("imported")
      Import.new(quantity, name, price)
    else
      Product.new(quantity, name, price)
    end
  end
end

#first set of items
cart = ShoppingCart.new

cart.add_item "1 book at 12.49"
cart.add_item "1 music CD at 14.99"
cart.add_item "1 chocolate bar at 0.85"
puts cart.receipt_output

puts "\n"

#second set of items 
cart = ShoppingCart.new

cart.add_item "1 imported box of chocolates at 10.00"
cart.add_item "1 imported bottle of perfume at 47.50"
puts cart.receipt_output

puts "\n"

#second set of items
cart = ShoppingCart.new

cart.add_item "1 imported bottle of perfume at 27.99"
cart.add_item "1 bottle of perfume at 18.99"
cart.add_item "1 packet of headache pills at 9.75"
cart.add_item "1 imported box of chocolates at 11.25"
puts cart.receipt_output