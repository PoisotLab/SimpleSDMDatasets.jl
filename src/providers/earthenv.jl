EarthEnvDataset = Union{LandCover}

# Update provisioning
provides(::Type{EarthEnv}, ::Type{T}) where {T <: EarthEnvDataset} = true

# Update the layers
layers(::RasterData{EarthEnv, LandCover}) = [
    "Evergreen/Deciduous Needleleaf Trees",
    "Evergreen Broadleaf Trees",
    "Deciduous Broadleaf Trees",
    "Mixed/Other Trees",
    "Shrubs",
    "Herbaceous Vegetation",
    "Cultivated and Managed Vegetation",
    "Regularly Flooded Vegetation",
    "Urban/Built-up",
    "Snow/Ice",
    "Barren",
    "Open Water",
]

# Get the dataset source
function source(
    data::RasterData{EarthEnv, LandCover};
    layer = "Urban/Built-up",
    full = true,
)
    var_code =
        (layer isa Integer) ? layer : findfirst(isequal(layer), layers(data))
    root = if full
        "https://data.earthenv.org/consensus_landcover/with_DISCover/"
    else
        "https://data.earthenv.org/consensus_landcover/without_DISCover/"
    end
    stem = if full
        "consensus_full_class_$(var_code).tif"
    else
        "Consensus_reduced_class_$(var_code).tif"
    end
    return (
        url = root * stem,
        filename = lowercase(stem),
        outdir = destination(data),
    )
end