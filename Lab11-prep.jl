using DataFrames
using JSON3
showln(x) = (show(x); println())
# Read a JSON file into a DataFrame
# df = DataFrame(JSON3.read("flat-ui-data.json"))

# Perform some operations on the DataFrame
# showln(first(df, 15))  # Print the first 5 rows

# Write the DataFrame to a JSON file
#JSON3.write("output.json", df)
# using CSV

# Read a CSV file into a DataFrame
# df_csv = CSV.read("flat-ui-data.csv", DataFrame)

# Perform some operations on the DataFrame
# println(last(df_csv, 15))  # Print the last 15 rows

# using GR
using Plots
display(histogram(randn(1000), label="histogram"))
display(plot(rand(5), rand(5), label="scatter", seriestype=:scatter, reuse=false))

x = range(0, stop=2π, length=100)
plot(x, sin.(x), label="sin(x)", legend=:top, reuse=false)
display(plot!(x, cos.(x), label="cos(x)", legend=:top, yflip=true, reuse=true))
sleep(15)
# GICS Sector refers to the Global Industry Classification Standard sector
# CIK refers to the Central Index Key, a unique identifier for a company

# Write the DataFrame to a CSV file
#CSV.write("output.csv", df_csv)