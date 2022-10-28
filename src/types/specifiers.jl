
struct RasterData{P <: RasterProvider, D <: RasterDataset}
    provider::Type{P}
    dataset::Type{D}
    RasterData(P, D) =
        ~SimpleSDMDatasets.provides(P, D) ? error("No combination") : new{P, D}(P, D)
end

struct Future{S <: FutureScenario, M <: FutureModel}
    scenario::Type{S}
    model::Type{M}
end