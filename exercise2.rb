#module for tax constants

module TaxCalc

  TAX == 0.10
  IMPORT == 0.05

#normal item tax

  def tax(price)
    price * TAX
  end

#import item tax

  def i_tax(price)
    price * IMPORT
  end

end

#working shopping cart class

class Cart

#importing TaxCalc methods & constants

  include TaxCalc

  attr_accessor :item, :price, :import, :exempt

  def initialize(item, price, import=false, exempt)
    @item = item
    @price = price
    @import = import
    @exempt = exempt
  end 

  def tax_type_finder
    case 
      when @exempt == false && @import == false
        tax_type = TaxCalc::TAX
      when @exempt == true && @import == false
        tax_type = 0
      when @exempt == false && @import == true
        tax_type = TaxCalc::IMPORT + TaxCalc::TAX
      else      
        tax_type = TaxCalc::IMPORT
    end 
  end

  def tax_amount
    just_tax = @price * tax_type
  end

end

#User Interface

hash = []
item_num = 0

if continue == true #will continue user prompt as long as it is true

 item_num+=1

  puts "Please enter the NAME of the item you wish to purchase:"
    i_name = gets.chomp

#look for exempt cases
    if i_name.include? "book" = true
      @exempt = true
    elsif i_name.include? "bar" = true
      @exempt = true
    elsif i_name.include? "chocolate" = true
      @exempt = true
    elsif i_name.include? "pills" = true
      @exempt = true
    else 
      @exempt = false
    end

  puts "Please enter the PRICE of the item you wish to purchase:"
    i_price = gets.chomp.to_f
  puts "Is the item you wish to purchase IMPORTED (yes/no):"
    i_import = gets.chomp
    i_import = i_import.downcase

  hash["item#{item_num}"] = Cart.new i_name, i_price, i_import

    puts "Do you wish to purchase ANOTHER item (yes/no)?"
      u_continue = gets.chomp 
      u_continue = u_continue.downcase

    #determine continue user prompt
    if u_continue == "yes"
      continue = true
      puts "------------------------\n"
    else
      continue = false
    end 
end


#Receipt Printout

total = 0.0

hash.each { |k,v| 
taxtotal += v.tax_amount
total = @price+v.tax_amount

puts "1 x #{v::name} : #{@price+v.tax_amount}"

}
puts "----------------\n"
puts "Taxes: #{taxtotal}"
puts "================\n"
puts "Total: #{total}"
    
