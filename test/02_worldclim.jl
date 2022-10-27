module TestSSDWorldClim

using SimpleSDMDatasets
using Test

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

@info slurp(WorldClim, BioClim; resolution = 10.0)
@info slurp(WorldClim, MinimumTemperature; resolution = 10.0)

end