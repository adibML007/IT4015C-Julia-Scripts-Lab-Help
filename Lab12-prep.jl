using DataFrames, CSV, Plots, Dates, Statistics, StatsBase
using GLM, DataFramesMeta, Chain

# Task 1: Data Loading

df = DataFrame(CSV.read("sp_500_stock_price.csv", DataFrame))

# Print the original dataframe
# println(describe(df))


# Task 2: Multiple Column Type Conversions for practice
transform!(df,
    :"Real Earnings" => (x -> ceil.(x)) => :"Real Earnings",
    :Earnings => (x -> floor.(x)) => :Earnings,
    :Dividend => (x -> ceil.(x)) => :Dividend,
    :PE10 => (x -> ceil.(x)) => :PE10
)
println(describe(df))
# Reverse transformation
# select!(df, Not([:Dividend1, :Earnings1, :PE101]))
# println(describe(df))

# Get numerical columns
num_cols = names(df, Real)

# # Min-max scaling of numerical columns
for col in num_cols
    df[!, "$(col)_normalized"] = (df[!, col] .- minimum(df[!, col])) ./ (maximum(df[!, col]) - minimum(df[!, col]))
end

# Print summary of normalized columns
println("Normalized columns summary:")
println(describe(select(df, r"_normalized$")))

# Task 3: Time Series Visualization (Most recent 100 rows by time)
n = 100
using Plots
# Creating X-axis as time
X = sort(df[1:n, 1], rev=true)
# Filter data between 2016 and 2022
df = filter(row -> year(row.Date) >= 2014 && year(row.Date) <= 2022, df)
# Create subplots for each numerical column
n_cols = length(num_cols)
plots = []
colors = [:blue, :red, :green, :purple, :orange, :brown, :pink, :gray, :cyan]
for (i, col) in enumerate(num_cols)
    p = plot(X, df[1:n, col], 
        seriestype = :line,
        linewidth = 2,  # Added line weight
        title = col, 
        xlabel = "Time", 
        ylabel = col,
        legend = false,
        color = colors[mod1(i, length(colors))])  # Use different color for each plot
    plot!(xticks = (X[Int.(collect(range(1,n,10)))], string.(X[Int.(collect(range(1,n,10)))])), 
        xtickfontsize=5)
    push!(plots, p)
end

# Arrange all plots in a grid
final_plot = plot(plots..., layout=(3,3), size=(2400,2400))
savefig("time-series-all-numericals.png")
# readline()
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


