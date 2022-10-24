module SimpleSDMDatasets

using Downloads

# Types for datasets
include(joinpath(@__DIR__, "types", "datasets.jl"))
export RasterProvider, RasterDataset
export BioClim, Elevation, MinimumTemperature, MaximumTemperature, AverageTemperature,
    Precipitation, SolarRadiation, WindSpeed, WaterVaporPressure

# Common interface
include(joinpath(@__DIR__, "types", "interface.jl"))

# WorldClim
include(joinpath(@__DIR__, "providers", "worldclim.jl"))
export WorldClim, WorldClimDataset

end # module SimpleSDMDatasets
