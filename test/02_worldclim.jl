module TestSSDWorldClim

using SimpleSDMDatasets
using Test
using Dates

@test WorldClim <: RasterProvider

# Test the interface
for T in Base.uniontypes(SimpleSDMDatasets.WorldClimDataset)
    @test SimpleSDMDatasets.provides(WorldClim, T)
    @test T in SimpleSDMDatasets.provides(WorldClim)
    @test SimpleSDMDatasets.resolutions(WorldClim, T) |> !isnothing
end

@test SimpleSDMDatasets.months(WorldClim, BioClim) |> isnothing
@test SimpleSDMDatasets.months(WorldClim, AverageTemperature) |> !isnothing
@test SimpleSDMDatasets.months(WorldClim, AverageTemperature) |> !isempty
@test SimpleSDMDatasets.layers(WorldClim, AverageTemperature) |> isnothing
@test SimpleSDMDatasets.layers(WorldClim, BioClim) |> !isnothing

@info slurp(WorldClim, BioClim; resolution = 10.0, layer = "BIO8")
@info slurp(WorldClim, BioClim; resolution = 5.0, layer = "BIO4")
@info slurp(WorldClim, Elevation; resolution = 5.0)
@info slurp(WorldClim, MinimumTemperature; resolution = 10.0, month = Month(4))
@info slurp(WorldClim, MinimumTemperature; resolution = 2.5, month = Month(12))

#@info slurp(WorldClim, BioClim, SSP126, ACCESS_CM2)

end