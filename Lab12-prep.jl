# Import packages
using DataFrames, CSV, Plots, Dates, Statistics, StatsBase, StatsPlots
using GLM, DataFramesMeta, Chain

"""
Task 1: Load and preprocess S&P 500 stock price data
"""
function load_and_preprocess_data(filepath)
    # Load data
    df = DataFrame(CSV.read(filepath, DataFrame))
    
    # Convert numeric columns to Float64
    numeric_columns = ["Real Earnings", "Earnings", "Dividend", "PE10"]
    for col in numeric_columns
        transform!(df, col => (x -> Float64.(x)) => col)
    end
    
    return df
end

"""
Task 2: Normalize numerical columns using min-max scaling
"""
function normalize_numerical_columns!(df)
    num_cols = names(df, Real)
    for col in num_cols
        df[!, "$(col)"] = (df[!, col] .- minimum(df[!, col])) ./ 
                                    (maximum(df[!, col]) - minimum(df[!, col]))
    end
end

"""
Task 3: Create time-based features and filter data
"""
function process_time_features!(df)
    # Add time-based columns
    df.Year = year.(df.Date)
    df.Month = month.(df.Date)
    df.Quarter = quarterofyear.(df.Date)
    
    # Filter for 2014-2022
    filter!(row -> 2014 <= year(row.Date) <= 2022, df)
end

"""
Task 4: Calculate aggregated statistics
"""
function calculate_statistics(df)
    # Yearly statistics
    yearly_stats = combine(groupby(df, :Year), 
        :Dividend => sum,
        :PE10 => mean,
        :Earnings => maximum)
    
    # Monthly and quarterly statistics
    monthly_stats = combine(groupby(df, :Month), :Dividend => sum)
    quarterly_stats = combine(groupby(df, :Quarter), :Dividend => sum)
    return yearly_stats, monthly_stats, quarterly_stats
end

"""
Task 5A: Create 1D visualizations
"""
function create_visualizations(df)
    # Basic plots
    p1 = boxplot(df.Year, df.PE10, title="PE10 by Year", label="PE10", legend=:topleft)
    p2 = histogram(df.Dividend, bins=50, title="Dividend Distribution", label="Frequency")
    p3 = scatter(df.PE10, df.Dividend, title="PE10 vs Dividend", label="Data Points")
    
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
    
    for (i, col) in enumerate(num_cols)
        p = plot(sorted_dates, df[1:n, col],
            seriestype=:line,
            linewidth=4,
            title=col,
            xlabel="Time",
            ylabel=col,
            legend=false,
            color=colors[mod1(i, length(colors))],
            xticks=(sorted_dates[1:10:n], string.(sorted_dates[1:10:n])),
            xtickfontsize=15
        )
        push!(plots, p)
    end
    
    final_plot = plot(plots..., layout=(3,3), size=(4800,4800))
    savefig(final_plot, "time-series-all-numericals.png")
end

# Main execution
function main()
    # Load and process data
    df = load_and_preprocess_data("sp_500_stock_price.csv")
    
    # Normalize and add time features
    normalize_numerical_columns!(df)
    process_time_features!(df)
    
    # Calculate statistics
    yearly_stats, monthly_stats, quarterly_stats = calculate_statistics(df)
    # Create visualizations
    create_visualizations(df)

    select!(df, Not([:Year, :Month, :Quarter]))
    create_time_series_plots(df, 100)
end

# Run the analysis
main()
