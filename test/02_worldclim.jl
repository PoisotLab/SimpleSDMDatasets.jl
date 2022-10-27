module TestSSDWorldClim

using SimpleSDMDatasets
using Test

@test WorldClim <: RasterProvider

# Test all
for T in Base.uniontypes(WorldClimDataset)
    @test typeof(WorldClim{T}) == DataType
    @test T <: RasterDataset
    @test Base.issingletontype(WorldClim{T})
end

@info SimpleSDMDatasets.dataset_folder(WorldClim{AverageTemperature})

begin
    SimpleSDMDatasets.egress(WorldClim{AverageTemperature}, resolution=10.0)
    SimpleSDMDatasets.egress(WorldClim{BioClim}, resolution=10.0)
end

end