module TestSSDCHELSA

using SimpleSDMDatasets
using Test

@test CHELSA <: RasterProvider

# Test the interface
for T in Base.uniontypes(SimpleSDMDatasets.CHELSADataset)
    @test SimpleSDMDatasets.provides(CHELSA, T)
    @test T in SimpleSDMDatasets.provides(CHELSA)
    @test SimpleSDMDatasets.resolutions(CHELSA, T) |> isnothing
end

@test SimpleSDMDatasets.months(CHELSA, BioClim) |> isnothing
@test SimpleSDMDatasets.layers(CHELSA, BioClim) |> !isnothing

@info slurp(CHELSA, BioClim; layer = "BIO8")
@info SimpleSDMDatasets.layers(CHELSA, BioClim)

end