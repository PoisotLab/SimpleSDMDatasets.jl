module TestSSDWorldClim

using SimpleSDMDatasets
using Test

@test WorldClim <: RasterProvider

# Test all
for T in Base.uniontypes(WorldClimDataset)
    @test typeof(WorldClim{T}) == DataType
    @test T <: RasterDataset
end

end