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

begin
    out = slurp(RasterData(WorldClim, BioClim); resolution = 10.0, layer = "BIO8")
    @test isfile(first(out))
    @test out[2] == SimpleSDMDatasets.filetype(RasterData(WorldClim, BioClim))
end

begin
    out = slurp(RasterData(WorldClim, BioClim); resolution = 5.0, layer = "BIO4")
    @test isfile(first(out))
    @test out[2] == SimpleSDMDatasets.filetype(RasterData(WorldClim, BioClim))
end

begin
    out = slurp(RasterData(WorldClim, Elevation); resolution = 5.0)
    @test isfile(first(out))
    @test out[2] == SimpleSDMDatasets.filetype(RasterData(WorldClim, Elevation))
end

begin
    out = slurp(
        RasterData(WorldClim, MinimumTemperature);
        resolution = 10.0,
        month = Month(4),
    )
    @test isfile(first(out))
    @test out[2] == SimpleSDMDatasets.filetype(RasterData(WorldClim, MinimumTemperature))
end

begin
    out = slurp(
        RasterData(WorldClim, MinimumTemperature);
        resolution = 2.5,
        month = Month(12),
    )
    @test isfile(first(out))
    @test out[2] == SimpleSDMDatasets.filetype(RasterData(WorldClim, MinimumTemperature))
end

#@info slurp(WorldClim, BioClim, SSP126, ACCESS_CM2)

end