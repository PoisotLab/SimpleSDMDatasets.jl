# Is the dataset in the provider?
provides(::Type{P}, ::Type{D}) where {P <: RasterProvider, D <: RasterDataset} = false
provides(::R, ::F) where {R <: RasterData, F <: Future} = false

# What file type is returned from each provider/set?
downloadtype(::R) where {R <: RasterData} = :file
downloadtype(::R, ::F) where {R <: RasterData, F <: Future} = :file

# What file type is returned from each provider/set?
filetype(::R) where {R <: RasterData} = :tiff
filetype(::R, ::F) where {R <: RasterData, F <: Future} = :tiff

# Is there a resolution for the dataset?
resolutions(::R) where {R <: RasterData} = nothing
resolutions(::R, ::F) where {R <: RasterData, F <: Future} = nothing

# Is there a monthly indexing for the dataset?
months(::R) where {R <: RasterData} = nothing
months(::R, ::F) where {R <: RasterData, F <: Future} = nothing

# Are there layers we can access?
layers(::R) where {R <: RasterData} = nothing
layers(::R, ::F) where {R <: RasterData, F <: Future} = nothing

# Are there extra allowed keys for the search?
extrakeys(::R) where {R <: RasterData} = nothing
extrakeys(::R, ::F) where {R <: RasterData, F <: Future} = nothing

# What is the destination/source of a dataset?
destination(::RasterData{P, D}; kwargs...) where {P <: RasterProvider, D <: RasterDataset} =
    joinpath(SimpleSDMDatasets._LAYER_PATH, string(P), string(D))

destination(
    ::RasterData{P, D},
    ::Future{S, M};
    kwargs...,
) where {P <: RasterProvider, D <: RasterDataset, S <: FutureScenario, M <: FutureModel} =
    joinpath(
        SimpleSDMDatasets._LAYER_PATH,
        string(P),
        string(D),
        replace(string(S), "_" => "-"),
        replace(string(M), "_" => "-"),
    )

source(::RasterData{P, D}; kwargs...) where {P <: RasterProvider, D <: RasterDataset} =
    nothing

source(
    ::RasterData{P, D},
    ::Future{S, M};
    kwargs...,
) where {P <: RasterProvider, D <: RasterDataset, S <: FutureScenario, M <: FutureModel} =
    nothing