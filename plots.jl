# This file contains functions and scripts to generate plots for the HF Paper RF Max Depth analysis.
# The plots will help visualize the data and results, providing insights into the performance and behavior
# of the Random Forest model with varying maximum depths.

using Plots

# plot some data
plot([cumsum(rand(500) .- 0.5), cumsum(rand(500) .- 0.5)])

# save the current figure
savefig("plots.svg")
# .eps, .pdf, & .png are also supported
# we used svg here because it respects the width and height specified above