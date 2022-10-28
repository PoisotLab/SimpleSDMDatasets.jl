module TestSSDCHELSA2

using SimpleSDMDatasets
using Test

@test CHELSA2 <: RasterProvider

# Test the interface
for T in Base.uniontypes(SimpleSDMDatasets.CHELSA2Dataset)
    @test SimpleSDMDatasets.provides(CHELSA2, T)
    data = RasterData(CHELSA2, BioClim)
    @test SimpleSDMDatasets.resolutions(data) |> isnothing
end

@test SimpleSDMDatasets.months(RasterData(CHELSA2, BioClim)) |> isnothing
@test SimpleSDMDatasets.layers(RasterData(CHELSA2, BioClim)) |> !isnothing

begin
    out = slurp(RasterData(CHELSA2, BioClim); layer = "BIO12")
    @test isfile(first(out))
    @test out[2] == SimpleSDMDatasets.filetype(RasterData(CHELSA2, BioClim))
end

end