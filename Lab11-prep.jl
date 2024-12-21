using DataFrames
using CSV
showln(x) = (show(x); println())
# Read a JSON file into a DataFrame
df = DataFrame(CSV.read("sp_500_stock_price.csv", DataFrame))

# Perform some operations on the DataFrame
# showln(first(df, 15))  # Print the first 5 rows
X = df[!, 1]  # Get the first column

# y = df[!, 7:9]  # Get the second column
# using GR
header_names = names(df)
showln(header_names[5])
# GICS Sector refers to the Global Industry Classification Standard sector
# CIK refers to the Central Index Key, a unique identifier for a company
using Plots
for i in 2:10
    display(plot!(X, df[!, i], seriestype = :line, title = "Real Earning vs. Time", xlabel = "Time", ylabel = "Real Earning", legend = false))
end
readline()
# Write the DataFrame to a CSV file
#CSV.write("output.csv", df_csv)