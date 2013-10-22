#Question 5

class Person
  def initialize(name)
    @name = name
  end

  def greet 
    puts "Hi, my name is #{@name}"
  end
end


#Question 1, 2

class Student < Person
  def learn
    puts "I get it"
  end
end

#Question 3

class Instructor < Person
  def teach
    puts "Everything in Ruby is an Object"
  end
end

#Question 4


#Question 6

instructor = Instructor.new("Chris")
puts "Instructor Greeting"
puts instructor.greet


#Question 7

student = Student.new("Cristina")
puts "Student Greeting"
puts student.greet

#Question 8


puts instructor.teach
puts student.learn