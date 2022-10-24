# Define the datasets that worldclim can provide
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

# Create the valid WorldClim parametric types
struct WorldClim{D <: WorldClimDataset} <: RasterProvider end

"""
    datasets(::Type{WorldClim})

When called with `datasets(WorldClim)`, this function will return all datasets
that the `WorldClim` provider implements. These can then be passed to the
`WorldClim{T}` parametric constructor, where `T` is one of the types returned by
`dataset`.

In practice, there is very little reason to do this as all internal functions
dispatch on `WorldClim{T}` with the constraint that `T <: WorldClimDataset`,
where `WorldClimDataset` is a union type. The point of this function is to allow
users to *list* the accessible datasets.
"""
datasets(::Type{WorldClim}) = Base.uniontypes(WorldClimDataset)

"""
    resolutions(::Type{WorldClim{T}})

Lists the resolutions that are offered by `WorldClim` for *any* generic dataset
(the resolutins and their codes are standardized for the entire provider). This
function is used internally to convert the numerical resolution to a string,
which is used to form the correct url.
"""
resolutions(::Type{WorldClim{T}}) where {T <: WorldClimDataset} =
    Dict([0.5 => "30s", 2.5 => "2.5m", 5.0 => "5m", 10.0 => "10m"])

# The following functions are the list of URL codes for the datasets. Note that
# they dispatch on the dataset within the context of worldclim
_varname(::Type{WorldClim{MinimumTemperature}}) = "tmin"
_varname(::Type{WorldClim{MaximumTemperature}}) = "tmax"
_varname(::Type{WorldClim{AverageTemperature}}) = "tavg"
_varname(::Type{WorldClim{Precipitation}}) = "prec"
_varname(::Type{WorldClim{SolarRadiation}}) = "srad"
_varname(::Type{WorldClim{WindSpeed}}) = "wind"
_varname(::Type{WorldClim{WaterVaporPressure}}) = "vapr"
_varname(::Type{WorldClim{BioClim}}) = "bio"
_varname(::Type{WorldClim{Elevation}}) = "elev"

function url(ref::Type{WorldClim{T}}; resolution = 5.0) where {T <: WorldClimDataset}
    res_code = get(resolutions(ref), resolution, "10m")
    var_code = _varname(ref)
    return "https://geodata.ucdavis.edu/climate/worldclim/2_1/base/wc2.1_$(res_code)_$(var_code)_.zip"
end