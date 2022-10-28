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

# Types for datasets and providers
include(joinpath(@__DIR__, "types", "datasets.jl"))
export RasterDataset
export BioClim, Elevation, MinimumTemperature, MaximumTemperature, AverageTemperature,
    Precipitation, SolarRadiation, WindSpeed, WaterVaporPressure, LandCover,
    HabitatHeterogeneity, Topography

include(joinpath(@__DIR__, "types", "providers.jl"))
export RasterProvider
export WorldClim2, EarthEnv, CHELSA1, CHELSA2

include(joinpath(@__DIR__, "types", "futures.jl"))
export FutureScenario, FutureModel

# CMIP6 exports
export CMIP6Scenario, CMIP6Model
export SSP126, SSP245, SSP370, SSP585
export ACCESS_CM2, ACCESS_ESM1_5, BCC_CSM2_MR, CanESM5, CanESM5_CanOE, CMCC_ESM2,
    CNRM_CM6_1, CNRM_CM6_1_HR, CNRM_ESM2_1, EC_Earth3_Veg, EC_Earth3_Veg_LR, FIO_ESM_2_0,
    GFDL_ESM4, GISS_E2_1_G, GISS_E2_1_H, HadGEM3_GC31_LL, INM_CM4_8, INM_CM5_0,
    IPSL_CM6A_LR, MIROC_ES2L, MIROC6, MPI_ESM1_2_LR, MPI_ESM1_2_HR, MPI_ESM2_0, UKESM1_0_LL

# Specifier types
include(joinpath(@__DIR__, "types", "specifiers.jl"))
export RasterData, Future

# Common interface
include(joinpath(@__DIR__, "types", "interface.jl"))

# Providers
include(joinpath(@__DIR__, "providers", "chelsa_v1.jl"))
include(joinpath(@__DIR__, "providers", "chelsa_v2.jl"))
include(joinpath(@__DIR__, "providers", "earthenv.jl"))
include(joinpath(@__DIR__, "providers", "worldclim_v2.jl"))

# Key checker function
function vibecheck(data::R; kwargs...) where {R <: RasterData}

    # Check for month
    if :month in keys(kwargs)
        if isnothing(months(data))
            error("The $(R) dataset does not allow for month as a keyword argument")
        end
        if ~(values(kwargs).month in months(data))
            error("The month $(values(kwargs).month) is not supported by the $(R) dataset")
        end
    end

    # Check for layer
    if :layer in keys(kwargs)
        if isnothing(layers(data))
            error("The $(R) dataset does not allow for layer as a keyword argument")
        end
        if values(kwargs).layer isa Integer
            if ~(1 <= values(kwargs).layer <= length(layers(data)))
                error("The $(R) dataset only has $(length(layers(data))) layers")
            end
        elseif ~(values(kwargs).layer in layers(data))
            error("The layer $(values(kwargs).layer) is not supported by the $(R) dataset")
        end
    end

    # Check for resolution
    if :resolution in keys(kwargs)
        if isnothing(resolutions(data))
            error("The $(R) dataset does not support multiple resolutions")
        end
        if ~(values(kwargs).resolution in keys(resolutions(data)))
            error(
                "The resolution $(values(kwargs).resolution) is not supported by the $(R) dataset",
            )
        end
    end

    # Check for allowed extra keys
    for k in keys(kwargs)
        if ~(k in [:month, :layer, :resolution])
            if k in keys(extrakeys(data))
                if ~(values(kwargs)[k] in extrakeys(data)[k])
                    error(
                        "The value $(values(kwargs)[k]) is not supported for the keyword argument $(k) to $(R)",
                    )
                end
            end
        end
    end
    return nothing
end

# Downloader function
function slurp(
    data::RasterData{P, D};
    kwargs...,
) where {P <: RasterProvider, D <: RasterDataset}
    vibecheck(data; kwargs...)

    url, fnm, dir = SimpleSDMDatasets.source(data; kwargs...)

    # Check for path existence
    isdir(dir) || mkpath(dir)

    # Check for file existence, download if not
    if ~isfile(joinpath(dir, fnm))
        Downloads.download(url, joinpath(dir, fnm))
    end

    # Check for the fileinfo
    if isequal(:zip)(SimpleSDMDatasets.downloadtype(data))
        # Extract only the layername
        r = ZipFile.Reader(joinpath(dir, fnm))
        for f in r.files
            if isequal(layername(data; kwargs...))(f.name)
                fnm = layername(data; kwargs...)
                write(joinpath(dir, f.name), read(f, String))
            end
        end
        close(r)
    end

    # Return everything as a tuple
    return (joinpath(dir, fnm), SimpleSDMDatasets.filetype(data), 1)
end
export slurp

end # module SimpleSDMDatasets
