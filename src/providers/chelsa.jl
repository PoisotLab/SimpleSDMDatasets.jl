CHELSADataset = Union{BioClim}

# Update provisioning
provides(::Type{CHELSA}, ::Type{T}) where {T <: CHELSADataset} = true

# Update the layers
layers(::RasterData{CHELSA, BioClim}) = "BIO" .* string.(1:19)

# Get the dataset source
function source(data::RasterData{CHELSA, BioClim}; layer = "BIO1")
    var_code = (layer isa Integer) ? layer : findfirst(isequal(layer), layers(data))
    root = "https://envicloud.wsl.ch/envicloud/chelsa/chelsa_V2/GLOBAL/climatologies/1981-2010/bio/"
    stem = "CHELSA_bio$(var_code)_1981-2010_V.2.1.tif"
    return (
        url = root * stem,
        filename = lowercase(stem),
        outdir = destination(data),
    )
end