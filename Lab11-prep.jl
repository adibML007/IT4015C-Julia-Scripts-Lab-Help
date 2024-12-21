using DataFrames
using JSON3
showln(x) = (show(x); println())
# Read a JSON file into a DataFrame
df = DataFrame(JSON3.read("flat-ui-data.json"))

# Perform some operations on the DataFrame
showln(first(df, 15))  # Print the first 5 rows

# Write the DataFrame to a JSON file
#JSON3.write("output.json", df)
using CSV

# Read a CSV file into a DataFrame
df_csv = CSV.read("flat-ui-data.csv", DataFrame)

# Perform some operations on the DataFrame
println(last(df_csv, 15))  # Print the last 15 rows

# GICS Sector refers to the Global Industry Classification Standard sector
# CIK refers to the Central Index Key, a unique identifier for a company

# Write the DataFrame to a CSV file
#CSV.write("output.csv", df_csv)