module SimpleSDMDatasets

import Downloads
using Dates
using ZipFile

# Set the potential paths for downloads
const _data_storage_folders = first([
    Base.DEPOT_PATH...,
    homedir(),
])

# Look for a path in the ENV, otherwise use the defaultest path from above
const _LAYER_PATH =
    get(ENV, "SDMLAYERS_PATH", joinpath(_data_storage_folders, "SimpleSDMDatasets"))
isdir(_LAYER_PATH) || mkpath(_LAYER_PATH)

# Types for datasets
include(joinpath(@__DIR__, "types", "datasets.jl"))
include(joinpath(@__DIR__, "types", "providers.jl"))
export RasterProvider, RasterDataset
export BioClim, Elevation, MinimumTemperature, MaximumTemperature, AverageTemperature,
    Precipitation, SolarRadiation, WindSpeed, WaterVaporPressure, LandCover
export WorldClim, EarthEnv

# Common interface
include(joinpath(@__DIR__, "types", "interface.jl"))

# Providers
include(joinpath(@__DIR__, "providers", "worldclim.jl"))
include(joinpath(@__DIR__, "providers", "earthenv.jl"))

# Downloader function
function slurp(
    ::Type{P},
    ::Type{D};
    kwargs...,
) where {P <: RasterProvider, D <: RasterDataset}
    url, fnm, dir = SimpleSDMDatasets.source(P, D; kwargs...)
    # Check for path existence
    isdir(dir) || mkpath(dir)
    # Check for file existence, download if not
    if ~isfile(joinpath(dir, fnm))
        Downloads.download(url, joinpath(dir, fnm))
    end
    # Check for the fileinfo
    if isequal(:zip)(SimpleSDMDatasets.downloadtype(P, D))
        # Extract only the layername
        r = ZipFile.Reader(joinpath(dir, fnm))
        for f in r.files
            if isequal(layername(P, D; kwargs...))(f.name)
                fnm = layername(P, D; kwargs...)
                write(joinpath(dir, f.name), read(f, String))
            end
        end
        close(r)
    end
    return (joinpath(dir, fnm), SimpleSDMDatasets.filetype(P, D), 1)
end
export slurp

end # module SimpleSDMDatasets
