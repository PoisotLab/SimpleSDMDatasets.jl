# Is the dataset in the provider?
provides(::Type{P}, ::Type{D}) where {P <: RasterProvider, D <: RasterDataset} = false

provides(
    ::Type{P},
    ::Type{D},
    ::Type{S},
    ::Type{M},
) where {P <: RasterProvider, D <: RasterDataset, S <: FutureScenario, M <: FutureModel} =
    false

# What file type is returned from each provider/set?
downloadtype(::Type{P}) where {P <: RasterProvider} = :file

downloadtype(::Type{P}, ::Type{D}) where {P <: RasterProvider, D <: RasterDataset} =
    downloadtype(P)

downloadtype(
    ::Type{P},
    ::Type{D},
    ::Type{S},
    ::Type{M},
) where {P <: RasterProvider, D <: RasterDataset, S <: FutureScenario, M <: FutureModel} =
    downloadtype(P, D)

# What file type is returned from each provider/set?
filetype(::Type{P}) where {P <: RasterProvider} = :tiff

filetype(::Type{P}, ::Type{D}) where {P <: RasterProvider, D <: RasterDataset} =
    filetype(P, D)

filetype(
    ::Type{P},
    ::Type{D},
    ::Type{S},
    ::Type{M},
) where {P <: RasterProvider, D <: RasterDataset, S <: FutureScenario, M <: FutureModel} =
    filetype(P, D)

# Is there a resolution for the dataset?
resolutions(::Type{P}) where {P <: RasterProvider} = nothing

resolutions(::Type{P}, ::Type{D}) where {P <: RasterProvider, D <: RasterDataset} =
    resolutions(P)

resolutions(
    ::Type{P},
    ::Type{D},
    ::Type{S},
    ::Type{M},
) where {P <: RasterProvider, D <: RasterDataset, S <: FutureScenario, M <: FutureModel} =
    resolutions(P, D)

# Is there a monthly indexing for the dataset?
months(::Type{P}) where {P <: RasterProvider} = nothing

months(::Type{P}, ::Type{D}) where {P <: RasterProvider, D <: RasterDataset} =
    months(P)

months(
    ::Type{P},
    ::Type{D},
    ::Type{S},
    ::Type{M},
) where {P <: RasterProvider, D <: RasterDataset, S <: FutureScenario, M <: FutureModel} =
    months(P, D)

# Are there layers we can access?
layers(::Type{P}) where {P <: RasterProvider} = nothing

layers(::Type{P}, ::Type{D}) where {P <: RasterProvider, D <: RasterDataset} =
    layers(P)

layers(
    ::Type{P},
    ::Type{D},
    ::Type{S},
    ::Type{M},
) where {P <: RasterProvider, D <: RasterDataset, S <: FutureScenario, M <: FutureModel} =
    layers(P, D)

# What is the destination of a dataset?
destination(
    ::Type{P},
    ::Type{D};
    kwargs...,
) where {P <: RasterProvider, D <: RasterDataset} =
    joinpath(SimpleSDMDatasets._LAYER_PATH, string(P), string(D))

destination(
    ::Type{P},
    ::Type{D},
    ::Type{S},
    ::Type{M};
    kwargs...,
) where {P <: RasterProvider, D <: RasterDataset, S <: FutureScenario, M <: FutureModel} =
    joinpath(
        SimpleSDMDatasets._LAYER_PATH,
        string(P),
        string(D),
        replace(string(S), "_" => "-"),
        replace(string(M), "_" => "-"),
    )

# What is the source of a dataset?
source(::Type{P}, ::Type{D}; kwargs...) where {P <: RasterProvider, D <: RasterDataset} =
    nothing

source(
    ::Type{P},
    ::Type{D},
    ::Type{S},
    ::Type{M};
    kwargs...,
) where {P <: RasterProvider, D <: RasterDataset, S <: FutureScenario, M <: FutureModel} =
    nothing