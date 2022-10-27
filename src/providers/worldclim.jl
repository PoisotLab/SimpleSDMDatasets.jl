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
provides(::Type{WorldClim}) = Base.uniontypes(WorldClimDataset)
provides(::Type{WorldClim}, ::Type{T}) where {T <: WorldClimDataset} = true

# Update downloadtype
downloadtype(::Type{WorldClim}) = :zip

# Update the resolution
resolutions(::Type{WorldClim}) =
    Dict([0.5 => "30s", 2.5 => "2.5m", 5.0 => "5m", 10.0 => "10m"])

# Update the months
months(::Type{WorldClim}) = Month.(1:12)
months(::Type{WorldClim}, ::Type{BioClim}) = nothing

# Update the layers
layers(::Type{WorldClim}, ::Type{BioClim}) = "BIO" .* string.(1:19)

# The following functions are the list of URL codes for the datasets. Note that
# they dispatch on the dataset within the context of worldclim
_var_slug(::Type{WorldClim}, ::Type{MinimumTemperature}) = "tmin"
_var_slug(::Type{WorldClim}, ::Type{MaximumTemperature}) = "tmax"
_var_slug(::Type{WorldClim}, ::Type{AverageTemperature}) = "tavg"
_var_slug(::Type{WorldClim}, ::Type{Precipitation}) = "prec"
_var_slug(::Type{WorldClim}, ::Type{SolarRadiation}) = "srad"
_var_slug(::Type{WorldClim}, ::Type{WindSpeed}) = "wind"
_var_slug(::Type{WorldClim}, ::Type{WaterVaporPressure}) = "vapr"
_var_slug(::Type{WorldClim}, ::Type{BioClim}) = "bio"
_var_slug(::Type{WorldClim}, ::Type{Elevation}) = "elev"

# Get the dataset source
function source(::Type{WorldClim}, ::Type{D}; resolution=10.) where {D <: WorldClimDataset}
    res_code = get(resolutions(WorldClim, D), resolution, "10m")
    var_code = _var_slug(WorldClim, D)
    root = "https://geodata.ucdavis.edu/climate/worldclim/2_1/base/"
    stem = "wc2.1_$(res_code)_$(var_code).zip"
    return (url=root*stem, filename=stem, outdir=destination(WorldClim, D))
end