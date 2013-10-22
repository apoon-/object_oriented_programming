#Question 1, 2

class Student 
  def learn
    puts "I get it"
  end
end

#Question 3

class Instructor
  def teach
    puts "Everything in Ruby is an Object"
  end
end

#Question 4

class Person
  def initializer(name)
    $name = name
  end

#Question 5

  def greet 
    puts "Hi, my name is #{$name}"
  end
end

#Question 6

instructor = Instructor.new
instructor.name = Chris
puts instructor.greet


#Question 7

Student = Student.new
student.name = Cristina
puts student.greet

#Question 8

puts instructor.teach
puts student.learn