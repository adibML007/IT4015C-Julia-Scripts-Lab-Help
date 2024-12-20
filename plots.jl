# This file contains functions and scripts to generate plots for the HF Paper RF Max Depth analysis.
# The plots will help visualize the data and results, providing insights into the performance and behavior
# of the Random Forest model with varying maximum depths.
using Plots

x = range(0, 10, length=100)
y1 = sin.(x)
y2 = cos.(x)
p = plot(x, [y1 y2])

y3 = @. sin(x)^2 - 1/2
plot!(p, x, y3)

savefig("myplot.png")      # saves the CURRENT_PLOT as a .png
savefig(p, "myplot.pdf")   # saves the plot from p as a .pdf vector graphic