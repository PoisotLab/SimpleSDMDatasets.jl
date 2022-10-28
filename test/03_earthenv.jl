module TestSSDEarthEnv

using SimpleSDMDatasets
using Test

@test EarthEnv <: RasterProvider

# Test the interface
for T in Base.uniontypes(SimpleSDMDatasets.EarthEnvDataset)
    @test SimpleSDMDatasets.provides(EarthEnv, T)
    data = RasterData(EarthEnv, T)
    @test typeof(data) == RasterData{EarthEnv, T}
    @test SimpleSDMDatasets.resolutions(data) |> isnothing
end

@test SimpleSDMDatasets.months(RasterData(EarthEnv, LandCover)) |> isnothing
@test SimpleSDMDatasets.layers(RasterData(EarthEnv, LandCover)) |> !isnothing

begin
    out = slurp(RasterData(EarthEnv, LandCover); layer = "Shrubs", full = true)
    @test isfile(first(out))
    @test out[2] == SimpleSDMDatasets.filetype(RasterData(EarthEnv, LandCover))
end

begin
    out = slurp(RasterData(EarthEnv, LandCover); layer = "Shrubs", full = false)
    @test isfile(first(out))
    @test out[2] == SimpleSDMDatasets.filetype(RasterData(EarthEnv, LandCover))
end

end