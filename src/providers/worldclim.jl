# Define the datasets that worldclim can provide - all of the entries in this array are `RasterDatasets`
wcdat = [
    BioClim,
    Elevation,
    MinimumTemperature,
    MaximumTemperature,
    AverageTemperature,
    Precipitation,
    SolarRadiation,
    WindSpeed,
    WaterVaporPressure,
]
WorldClimDataset = Union{wcdat...}

# Update provisioning
provides(::Type{WorldClim}, ::Type{T}) where {T <: WorldClimDataset} = true

# Update downloadtype
downloadtype(::RasterData{WorldClim, T}) where {T <: WorldClimDataset} = :zip

# Update the resolution
resolutions(::RasterData{WorldClim, T}) where {T <: WorldClimDataset} =
    Dict([0.5 => "30s", 2.5 => "2.5m", 5.0 => "5m", 10.0 => "10m"])

# Update the months
months(::RasterData{WorldClim, T}) where {T <: WorldClimDataset} = Month.(1:12)
months(::RasterData{WorldClim, BioClim}) = nothing
months(::RasterData{WorldClim, Elevation}) = nothing

# Update the layers
layers(::RasterData{WorldClim, BioClim}) = "BIO" .* string.(1:19)

# The following functions are the list of URL codes for the datasets. Note that
# they dispatch on the dataset within the context of worldclim
_var_slug(::RasterData{WorldClim, MinimumTemperature}) = "tmin"
_var_slug(::RasterData{WorldClim, MaximumTemperature}) = "tmax"
_var_slug(::RasterData{WorldClim, AverageTemperature}) = "tavg"
_var_slug(::RasterData{WorldClim, Precipitation}) = "prec"
_var_slug(::RasterData{WorldClim, SolarRadiation}) = "srad"
_var_slug(::RasterData{WorldClim, WindSpeed}) = "wind"
_var_slug(::RasterData{WorldClim, WaterVaporPressure}) = "vapr"
_var_slug(::RasterData{WorldClim, BioClim}) = "bio"
_var_slug(::RasterData{WorldClim, Elevation}) = "elev"

# Get the dataset source
function source(
    data::RasterData{WorldClim, D};
    resolution = 10.0,
    args...,
) where {D <: WorldClimDataset}
    res_code = get(resolutions(data), resolution, "10m")
    var_code = _var_slug(data)
    root = "https://geodata.ucdavis.edu/climate/worldclim/2_1/base/"
    stem = "wc2.1_$(res_code)_$(var_code).zip"
    return (
        url = root * stem,
        filename = lowercase(stem),
        outdir = destination(data),
    )
end

function layername(
    data::RasterData{WorldClim, D};
    resolution = 10.0,
    month = Month(1),
) where {D <: WorldClimDataset}
    res_code = get(resolutions(data), resolution, "10m")
    var_code = _var_slug(data)
    layer_code = lpad(string(month.value), 2, '0')
    return "wc2.1_$(res_code)_$(var_code)_$(layer_code).tif"
end

function layername(
    data::RasterData{WorldClim, BioClim};
    resolution = 10.0,
    layer = "BIO1",
)
    res_code = get(resolutions(data), resolution, "10m")
    var_code = _var_slug(data)
    layer_code = (layer isa Integer) ? layer : findfirst(isequal(layer), layers(data))
    return "wc2.1_$(res_code)_$(var_code)_$(layer_code).tif"
end

function layername(
    data::RasterData{WorldClim, Elevation};
    resolution = 10.0,
)
    res_code = get(resolutions(data), resolution, "10m")
    var_code = _var_slug(data)
    return "wc2.1_$(res_code)_$(var_code).tif"
end