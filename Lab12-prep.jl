using DataFrames, CSV, Plots, Dates, Statistics, StatsBase
using GLM, DataFramesMeta, Chain

# Task 1: Data Loading

df = DataFrame(CSV.read("sp_500_stock_price.csv", DataFrame))


# Original dataframe
println(df[1:10, ["Dividend", "Earnings", "PE10"]])

# Task 2: Multiple Column Type Conversions
transform!(df,
    :Dividend => (x -> Float64.(x)) => :Dividend,
    :Earnings => (x -> floor.(x)) => :Earnings,
    :PE10 => (x -> ceil.(x)) => :PE10
)
# Transform dataframes
println(df[1:10, ["Dividend", "Earnings", "PE10"]])


# Task 3: Time Series Visualization
# The original columns :revenue, :sales don't exist in the provided DataFrame
# We'll use existing columns from the SP500 data
# @df df plot(:Date, [:Dividend, :PE10],
#     layout=(2,1),
#     label=["Dividend" "PE10"],
#     linetype=:steppost,
#     marker=(:circle, 2))

# # Task 4: Advanced Filtering
# # Modifying to use existing columns
# filtered_df = @chain df begin
#     @subset(:PE10 .> 10)
#     @select(:Date, :PE10, :Dividend)
# end

# # Task 5: Multiple Grouping Operations
# # SP500 data doesn't have region/product categories
# # Using year grouping instead
# df.Year = year.(df.Date)
# grouped = combine(groupby(df, :Year), 
#     :Dividend => sum,
#     :PE10 => mean,
#     :Earnings => maximum)

# # Task 6: Date Operations
# # Already have Date column, adding time components
# df.Month = month.(df.Date)
# df.Quarter = quarterofyear.(df.Date)
# monthly_stats = combine(groupby(df, :Month), :Dividend => sum)

# # Task 7: Complex Visualization
# p1 = boxplot(df.Year, df.PE10, title="PE10 by Year")
# p2 = histogram(df.Dividend, bins=50, title="Dividend Distribution")
# p3 = scatter(df.PE10, df.Dividend, title="PE10 vs Dividend")
# plot(p1, p2, p3, layout=(1,3), size=(1200,400))

# Removing tasks 8-15 as they rely on non-existent data files and columns
# The SP500 dataset has different structure


using Plots
X = sort(df[1:100, 1], rev=true)
# for i in 2:10
fig = plot(X, df[1:100, 7], seriestype = :line, title = "Real Earning vs. Time", xlabel = "Time", ylabel = "Real Earning", legend = false)
# yticks!([-1:1:1;], ["min", "zero", "max"])
plot!(xticks = (X[Int.(collect(range(1,100,10)))], string.(X[Int.(collect(range(1,100,10)))])), xtickfontsize=5)
display(fig)
# savefig("plot.png")
# end
readline()