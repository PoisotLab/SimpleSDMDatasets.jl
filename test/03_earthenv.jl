module TestSSDEarthEnv

using SimpleSDMDatasets
using Test

@test EarthEnv <: RasterProvider

# Test the interface
for T in Base.uniontypes(SimpleSDMDatasets.EarthEnvDataset)
    @test SimpleSDMDatasets.provides(EarthEnv, T)
    @test T in SimpleSDMDatasets.provides(EarthEnv)
    @test SimpleSDMDatasets.resolutions(EarthEnv, T) |> isnothing
end

@test SimpleSDMDatasets.months(EarthEnv, LandCover) |> isnothing
@test SimpleSDMDatasets.layers(EarthEnv, LandCover) |> !isnothing

@info slurp(EarthEnv, LandCover; layer = "Snow/Ice")
@info SimpleSDMDatasets.layers(EarthEnv, LandCover)

end