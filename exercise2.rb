module Round
  def self.format_tax(amount)
    return amount if (amount % 5) == 0
    amount + 5 - (amount % 5)
  end

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

  def quantity_total
    @quantity * @price
  end

  def sales_tax
    Round.format_tax (quantity_total * tax_rate).ceil
  end

  def total
    quantity_total + sales_tax
  end

  def tax_rate
    0.10
  end

  def to_s
    "#{@quantity} #{@name} : #{Round.format_price(total)}"
  end
end

class Exempt < Product
  def tax_rate
    0
  end
end

class Import < Product
  def tax_rate
    super + 0.05
  end
end

class ImportedExempt < Exempt
  def tax_rate
    super + 0.05
  end
end

class ShoppingCart
  def initialize
    @products = []
  end

  def add_item(product_string)
    strings = product_string.split(" ")
    quantity = strings[0].to_i
    price = strings[-1].to_f
    name = strings[1...-2].join(" ")

    @products << product_sort(quantity, name, price)
  end

  def receipt
    calculate_final_total_and_tax

    results = ""
    @products.each {|product| results << "#{product.to_s}\n"}

    results << "-----------------------\nSales Tax: #{Round::format_price(@sales_tax)}\n=======================\n"
    results << "Total: #{Round::format_price(@total)}"
  end

  private
  def calculate_final_total_and_tax
    @total = 0
    @sales_tax = 0

    @products.each do |product|
      @sales_tax += product.sales_tax
      @total += product.total
    end
  end

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

# exempt = books, food, medical
# imported 

cart = ShoppingCart.new

cart.add_item "1 book at 12.49"
cart.add_item "1 music CD at 14.99"
cart.add_item "1 chocolate bar at 0.85"
puts cart.receipt

puts "\n"

cart = ShoppingCart.new

cart.add_item "1 imported box of chocolates at 10.00"
cart.add_item "1 imported bottle of perfume at 47.50"
puts cart.receipt

puts "\n"

cart = ShoppingCart.new

cart.add_item "1 imported bottle of perfume at 27.99"
cart.add_item "1 bottle of perfume at 18.99"
cart.add_item "1 packet of headache pills at 9.75"
cart.add_item "1 imported box of chocolates at 11.25"
puts cart.receipt