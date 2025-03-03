# Import packages
using DataFrames, CSV, Plots, Dates, Statistics, StatsBase, StatsPlots, GLM, Chain

"""
Task 1: Load and preprocess S&P 500 stock price data
"""
function load_and_preprocess_data(filepath)
    # Load data
    df = DataFrame(CSV.read(filepath, DataFrame))
    
    # Convert numeric columns to Float64
    numeric_columns = ["Real Earnings", "Earnings", "Dividend", "PE10"]
    # TODO: Complete the conversion of numeric columns to Float64
    
    return df
end

"""
Task 2: Normalize numerical columns using min-max scaling
"""
function normalize_numerical_columns!(df)
    num_cols = names(df, Real)
    for col in num_cols
        # TODO: Implement min-max scaling formula
    end
end

"""
Task 3: Create time-based features and filter data
"""
function process_time_features!(df)
    # TODO: Add time-based columns (Year, Month, Quarter)
    
    # Filter for 2014-2022
    filter!(row -> 2014 <= year(row.Date) <= 2022, df)
end

"""
Task 4: Calculate aggregated statistics
"""
function calculate_statistics(df)
    # TODO: Calculate yearly statistics using combine and groupby
    yearly_stats = # Your code here
    
    # Monthly and quarterly statistics
    monthly_stats = combine(groupby(df, :Month), :Dividend => sum)
    quarterly_stats = combine(groupby(df, :Quarter), :Dividend => sum)
    return yearly_stats, monthly_stats, quarterly_stats
end

"""
Task 5A: Create 1D visualizations
"""
function create_visualizations(df)
    # TODO: Create three plots (boxplot, histogram, scatter)
    p1 = # Your code here
    p2 = # Your code here
    p3 = # Your code here
    
    combined_plot = plot(p1, p2, p3, layout=(1,3), size=(1200,400))
    savefig(combined_plot, "multiple-visualization.png")
end

"""
Task 5B: Create time series plots for 2D visualizations
"""
function create_time_series_plots(df, n)
    num_cols = names(df, Real)
    plots = []
    colors = [:blue, :red, :green, :purple, :orange, :brown, :pink, :gray, :cyan]
    
    sorted_dates = sort(df[1:n, :Date], rev=true)
    
    # TODO: Create time series plots for each numerical column
    
    final_plot = plot(plots..., layout=(3,3), size=(4800,4800))
    savefig(final_plot, "time-series-all-numericals.png")
end

# Main execution
function main()
    df = load_and_preprocess_data("sp_500_stock_price.csv")
    normalize_numerical_columns!(df)
    process_time_features!(df)
    
    yearly_stats, monthly_stats, quarterly_stats = calculate_statistics(df)
    create_visualizations(df)

    select!(df, Not([:Year, :Month, :Quarter]))
    create_time_series_plots(df, 100)
end

main()
