module TestSSDCHELSA

using SimpleSDMDatasets
using Test

@test CHELSA <: RasterProvider

# Test the interface
for T in Base.uniontypes(SimpleSDMDatasets.CHELSADataset)
    @test SimpleSDMDatasets.provides(CHELSA, T)
    data = RasterData(CHELSA, BioClim)
    @test SimpleSDMDatasets.resolutions(data) |> isnothing
end

@test SimpleSDMDatasets.months(RasterData(CHELSA, BioClim)) |> isnothing
@test SimpleSDMDatasets.layers(RasterData(CHELSA, BioClim)) |> !isnothing

begin
    out = slurp(RasterData(CHELSA, BioClim); layer = "BIO12")
    @test isfile(first(out))
    @test out[2] == SimpleSDMDatasets.filetype(RasterData(CHELSA, BioClim))
end

end