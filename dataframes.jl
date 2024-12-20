x = 10;
# Today we will learn about dataframes in Julia
# Co-pilot is working super fine
# I am happy with the results
using DataFrames
df = DataFrame(A = 1:4, B = ["M", "F", "F", "M"])
df
groupped = groupby(df, :B)
for i in groupped
    println(i)
end
# I am happy with the results