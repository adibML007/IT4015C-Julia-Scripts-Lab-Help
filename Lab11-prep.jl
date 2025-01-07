# 1st task
println("Hello, Julia World")

# Create variables to store a person's name, age, and height
person_name = "John Doe"
person_age = 30
person_height = 5.9

# Use the println() function to display each variable
println("Name: ", person_name)
println("Age: ", person_age)
println("Height: ", person_height, " ft")

# Create a list called favorite_foods with at least six items and print it
favorite_foods = ["Pizza", "Sushi", "Burger", "Pasta", "Salad", "Ice Cream"]
println(favorite_foods)

# Create a dictionary called movie_info containing keys for title, director, and year and their respective values. Print the dictionary
movie_info = Dict("title" => "Inception", "director" => "Christopher Nolan", "year" => 2010)
println(movie_info)

# Conditional statement to check if a number is positive, negative, or zero
number = 5
if number > 0
    println("The number is positive.")
elseif number < 0
    println("The number is negative.")
else
    println("The number is zero.")
end

# For loop to print each item in the favorite_foods list
for food in favorite_foods
    println(food)
end

# Define a function named print_square that accepts one number (integer) and returns its squared value
function print_square(number::Int)
    return number^2
end

# Call the function with a few different numbers
println(print_square(2))  # Should print 4
println(print_square(3))  # Should print 9
println(print_square(4))  # Should print 16

# Ask the user for their name and age
print("Enter your name: ")
name = chomp(readline())
print("Enter your age: ")
age = tryparse(Int, chomp(readline()))
if age === nothing
    println("Invalid age entered.")
else
    # Calculate the age in 5 years
    age_in_5_years = age + 5

    # Print the greeting message
    println("Hello, $name In 5 years, you will be $age_in_5_years years old.")
end
