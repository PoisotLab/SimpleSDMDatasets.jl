module TestSSDWorldClim

using SimpleSDMDatasets
using Test
using Dates

@test WorldClim <: RasterProvider

# Test the interface
for T in Base.uniontypes(SimpleSDMDatasets.WorldClimDataset)
    @test SimpleSDMDatasets.provides(WorldClim, T)
    data = RasterData(WorldClim, T)
    @test typeof(data) == RasterData{WorldClim, T}
    @test SimpleSDMDatasets.resolutions(data) |> !isnothing
end

@test SimpleSDMDatasets.months(RasterData(WorldClim, BioClim)) |> isnothing
@test SimpleSDMDatasets.months(RasterData(WorldClim, AverageTemperature)) |> !isnothing
@test SimpleSDMDatasets.months(RasterData(WorldClim, AverageTemperature)) |> !isempty
@test SimpleSDMDatasets.layers(RasterData(WorldClim, AverageTemperature)) |> isnothing
@test SimpleSDMDatasets.layers(RasterData(WorldClim, BioClim)) |> !isnothing

@info slurp(RasterData(WorldClim, BioClim); resolution = 10.0, layer = "BIO8")
@info slurp(RasterData(WorldClim, BioClim); resolution = 5.0, layer = "BIO4")
@info slurp(RasterData(WorldClim, Elevation); resolution = 5.0)
@info slurp(RasterData(WorldClim, MinimumTemperature); resolution = 10.0, month = Month(4))
@info slurp(RasterData(WorldClim, MinimumTemperature); resolution = 2.5, month = Month(12))

#@info slurp(WorldClim, BioClim, SSP126, ACCESS_CM2)

end