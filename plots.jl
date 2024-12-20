# This file contains functions and scripts to generate plots for the HF Paper RF Max Depth analysis.
# The plots will help visualize the data and results, providing insights into the performance and behavior
# of the Random Forest model with varying maximum depths.

using Plots

# Example function to create a simple plot
function example_plot()
    x = 1:10
    y = rand(10)
    plot(x, y, title="Example Plot", xlabel="X-axis", ylabel="Y-axis", legend=false)
end

# Call the example plot function to generate the plot
example_plot()