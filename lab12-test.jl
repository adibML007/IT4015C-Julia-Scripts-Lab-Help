using Test
using DataFrames
using CSV
using Dates
using Statistics

# Test Setup
function create_test_data()
    dates = Date("2023-01-01"):Day(1):Date("2023-01-10")
    df = DataFrame(
        date = dates,
        sales = rand(500:2000, 10),
        revenue = rand(1000.0:5000.0, 10),
        quantity = rand(10:100, 10),
        region = rand(["North", "South", "East", "West"], 10),
        product_category = rand(["A", "B", "C"], 10)
    )
    CSV.write("test_sales_data.csv", df)
    return df
end

@testset "Sales Analysis Tests" begin
    # Setup
    test_df = create_test_data()
    
    @testset "Data Loading" begin
        @test size(CSV.read("test_sales_data.csv", DataFrame)) == (10, 6)
        @test names(test_df) == ["date", "sales", "revenue", "quantity", "region", "product_category"]
    end

    @testset "Data Types" begin
        @test eltype(test_df.sales) <: Integer
        @test eltype(test_df.revenue) <: Float64
        @test eltype(test_df.quantity) <: Integer
        @test eltype(test_df.date) <: Date
    end

    @testset "Filtering" begin
        filtered = filter(row -> row.sales > 1000, test_df)
        @test all(x -> x > 1000, filtered.sales)
    end

    @testset "Grouping" begin
        grouped = combine(groupby(test_df, :region), :sales => sum)
        @test nrow(grouped) == length(unique(test_df.region))
    end

    @testset "Statistics" begin
        stats = describe(test_df, :mean, :std, :min, :max)
        @test all(x -> x in names(stats), [:variable, :mean, :std, :min, :max])
    end

    @testset "Date Operations" begin
        @test year(test_df.date[1]) == 2023
        @test month(test_df.date[1]) == 1
    end

    @testset "Data Export" begin
        CSV.write("test_export.csv", test_df)
        exported_df = CSV.read("test_export.csv", DataFrame)
        @test size(exported_df) == size(test_df)
    end

    @testset "Error Handling" begin
        @test_throws SystemError CSV.read("nonexistent_file.csv", DataFrame)
    end

    # Teardown
    rm("test_sales_data.csv", force=true)
    rm("test_export.csv", force=true)
end