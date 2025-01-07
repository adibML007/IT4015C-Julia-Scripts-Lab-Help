# Visualization with Julia
using DataFrames
using Base: LinRange
using CSV
showln(x) = (show(x); println())
# Read a JSON file into a DataFrame
df = DataFrame(CSV.read("sp_500_stock_price.csv", DataFrame))
# println(df)
# Perform some operations on the DataFrame
# showln(first(df, 15))  # Print the first 5 rows
X = sort(df[1:100, 1], rev=true)  # Get the first column
# xt = collect(range(1, 100, 10))
# y = df[!, 7:9]  # Get the second column
# using GR
header_names = names(df)
# println(header_names)
# ["Date", "SP500", "Dividend", "Earnings", "Consumer Price Index", "Long Interest Rate", "Real Price", "Real Dividend", "Real Earnings", "PE10"]
# showln(X)
# GICS Sector refers to the Global Industry Classification Standard sector
# CIK refers to the Central Index Key, a unique identifier for a company
using Plots
# for i in 2:10
fig = plot(X, df[1:100, 7], seriestype = :line, title = "Real Earning vs. Time", xlabel = "Time", ylabel = "Real Earning", legend = false)
# yticks!([-1:1:1;], ["min", "zero", "max"])
plot!(xticks = (X[Int.(collect(range(1,100,10)))], string.(X[Int.(collect(range(1,100,10)))])), xtickfontsize=5)
display(fig)
# savefig("plot.png")
# end
readline()

# using plotlyJS

# Write the DataFrame to a CSV file
#CSV.write("output.csv", df_csv)