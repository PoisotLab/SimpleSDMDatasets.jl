CHELSADataset = Union{BioClim}

# Update provisioning
provides(::Type{CHELSA}, ::Type{T}) where {T <: CHELSADataset} = true
provides(
    ::Type{CHELSA},
    ::Type{BioClim},
    ::Type{SSP},
    ::Type{CMOD},
) where {
    SSP <: Union{SSP126, SSP370, SSP585},
    CMOD <: Union{GFDL_ESM4, IPSL_CM6A_LR, MPI_ESM1_2_HR, MRI_ESM2_0, UKESM1_0_LL},
} = true

# Update the layers
layers(::Type{CHELSA}, ::Type{BioClim}) = "BIO" .* string.(1:19)

# Get the dataset source
function source(
    ::Type{CHELSA},
    ::Type{BioClim};
    layer = "BIO1",
)
    var_code =
        (layer isa Integer) ? layer : findfirst(isequal(layer), layers(CHELSA, BioClim))
    root = "https://envicloud.wsl.ch/envicloud/chelsa/chelsa_V2/GLOBAL/climatologies/1981-2010/bio/"
    stem = "CHELSA_bio$(var_code)_1981-2010_V.2.1.tif"
    return (
        url = root * stem,
        filename = lowercase(stem),
        outdir = destination(CHELSA, BioClim),
    )
end