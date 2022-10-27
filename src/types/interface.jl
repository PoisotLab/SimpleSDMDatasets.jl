# Is the dataset in the provider?
provides(::Type{P}) where {P <: RasterProvider} = []
provides(::Type{P}, ::Type{D}) where {P <: RasterProvider, D <: RasterDataset} = false

# What file type is returned from each provider/set?
downloadtype(::Type{P}) where {P <: RasterProvider} = :file
downloadtype(::Type{P}, ::Type{D}) where {P <: RasterProvider, D <: RasterDataset} =
    downloadtype(P)

# What file type is returned from each provider/set?
filetype(::Type{P}) where {P <: RasterProvider} = :tiff
filetype(::Type{P}, ::Type{D}) where {P <: RasterProvider, D <: RasterDataset} =
    filetype(P)

# Is there a resolution for the dataset?
resolutions(::Type{P}) where {P <: RasterProvider} = nothing
resolutions(::Type{P}, ::Type{D}) where {P <: RasterProvider, D <: RasterDataset} =
    resolutions(P)

# Is there a monthly indexing for the dataset?
months(::Type{P}) where {P <: RasterProvider} = nothing
months(::Type{P}, ::Type{D}) where {P <: RasterProvider, D <: RasterDataset} =
    months(P)

# Are there layers we can access?
layers(::Type{P}) where {P <: RasterProvider} = nothing
layers(::Type{P}, ::Type{D}) where {P <: RasterProvider, D <: RasterDataset} =
    layers(P)

# What is the destination of a dataset?
destination(
    ::Type{P},
    ::Type{D};
    kwargs...,
) where {P <: RasterProvider, D <: RasterDataset} =
    joinpath(SimpleSDMDatasets._LAYER_PATH, string(P), string(D))

# What is the source of a dataset?
source(::Type{P}, ::Type{D}; kwargs...) where {P <: RasterProvider, D <: RasterDataset} =
    nothing
