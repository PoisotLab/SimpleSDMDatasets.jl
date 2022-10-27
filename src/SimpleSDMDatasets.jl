module SimpleSDMDatasets

import Downloads

# Set the potential paths for downloads
const _data_storage_folders = first([
    Base.DEPOT_PATH...,
    homedir(),
])

# Look for a path in the ENV, otherwise use the defaultest path from above
const _LAYER_PATH =
    get(ENV, "SDMLAYERS_PATH", joinpath(_data_storage_folders, "SimpleSDMDatasets"))
isdir(_LAYER_PATH) || mkdir(_LAYER_PATH)

# Types for datasets
include(joinpath(@__DIR__, "types", "datasets.jl"))
export RasterProvider, RasterDataset
export BioClim, Elevation, MinimumTemperature, MaximumTemperature, AverageTemperature,
    Precipitation, SolarRadiation, WindSpeed, WaterVaporPressure

# Common interface
include(joinpath(@__DIR__, "types", "interface.jl"))

# Downloader function
function egress(dtype::Type{T}; kwargs...) where {T <: RasterProvider}
    spec = SimpleSDMDatasets.dataset_spec(dtype; kwargs...)
    @info spec
    Downloads.download(spec...)
end

# WorldClim
include(joinpath(@__DIR__, "providers", "worldclim.jl"))
export WorldClim, WorldClimDataset

end # module SimpleSDMDatasets
