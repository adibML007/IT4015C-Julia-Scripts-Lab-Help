# This file contains functions and scripts to generate plots for the HF Paper RF Max Depth analysis.
# The plots will help visualize the data and results, providing insights into the performance and behavior
# of the Random Forest model with varying maximum depths.
using Plots

# Generate some complex data
x = 1:100
y1 = sin.(x .* 0.1) .* exp.(-x .* 0.01)
y2 = cos.(x .* 0.1) .* exp.(-x .* 0.01)
y3 = tanh.(x .* 0.1)

# Create a plot with multiple subplots
plot(
    plot(x, y1, title="Damped Sine Wave", xlabel="x", ylabel="y1", legend=false),
    plot(x, y2, title="Damped Cosine Wave", xlabel="x", ylabel="y2", legend=false),
    plot(x, y3, title="Tanh Function", xlabel="x", ylabel="y3", legend=false),
    layout = (3, 1)
)

# Save the complex plot
savefig("complex_plots.svg")
# .eps, .pdf, & .png are also supported
# we used svg here because it respects the width and height specified above
# To display the plot in the notebook, use the following command:
# display("complex_plots.svg", "image/svg+xml")
# This will render the plot in the notebook as an SVG image.
# You can also use the Plots.jl backend to display the plot directly in the notebook.
# For more information on Plots.jl, see: https://docs.juliaplots.org/latest/