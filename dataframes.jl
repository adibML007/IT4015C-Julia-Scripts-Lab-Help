# This one demonstrates some usages of DataFrames in Julia programming language
using DataFrames
showln(x) = (show(x); println())
# A DataFrame is an in-memory database
df = DataFrame(A = [1, 2], B = [ℯ, π], C = ["xx", "xy"])
showln(df)


# The columns of a DataFrame can be indexed using numbers or names
showln(df[!, 1])

showln(df[!, :A])


showln(df[!, 2])

# Showing column B
showln(df[!, :B])


showln(df[!, 3])

showln(df[!, :C])


# The rows of a DataFrame can be indexed only by using numbers
showln(df[1, :])

showln(df[1:2, :])


using CSV

# DataFrames can be loaded from CSV files using CSV.read()
iris = CSV.read("iris.csv",DataFrame)

# the iris dataset (and plenty of others) is also available from
using RData, RDatasets
iris = dataset("datasets","iris")

# you can directly import your own R .rda dataframe with
# mydf = load("path/to/your/df.rda")["name_of_df"], e.g.
diamonds = load(joinpath(dirname(pathof(RDatasets)),"..","data","ggplot2","diamonds.rda"))["diamonds"]

# showing DataFrames
# ------------------

# Check the names and element types of the columns of our new DataFrame
showln(names(iris))
#> Symbol[:SepalLength, :SepalWidth, :PetalLength, :PetalWidth, :Species]
showln(eltype.(eachcol(iris)))
#> DataType[Float64, Float64, Float64, Float64, CategoricalString{UInt8}]

# Subset the DataFrame to only include rows for one species
showln(iris[iris[!, :Species] .== "setosa", :])

# Note: The 'by' keyword is not available in this version of Julia. 
# Consider using an alternative approach to achieve the desired functionality.
showln(combine(groupby(iris, [:Species]), nrow => :count))

using DataFrames


# Discretize entire columns at a time
iris[!, :SepalLength] = round.(Integer, iris[!, :SepalLength])
iris[!, :SepalWidth] = round.(Integer, iris[!, :SepalWidth])


# Tabulate data according to discretized columns to see "clusters"
showln(combine(groupby(iris, [:Species, :SepalLength, :SepalWidth]), nrow => :count))


gdf = groupby(iris,[:Species, :SepalLength, :SepalWidth])

# and then iterate over it
for idf in gdf
	println(size(idf,1))
end

# Adding/Removing columns
# -----------------------

# insert!(df::DataFrame,index::Int64,item::AbstractArray{T,1},name::Symbol)
# insert random numbers at col 5:
insertcols!(iris, 5, :randCol => rand(nrow(iris)))
showln(iris)
# remove it
select!(iris, Not(:randCol))
showln(iris)