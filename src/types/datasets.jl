"""
    RasterDataset

This is an *abstract* type to label something as being a dataset. Datasets are
given by `RasterProvider`s, and the same dataset can have multiple providers.
"""
abstract type RasterDataset end

"""
    RasterProvider

This is an *abstract* type to label something as a provider of `RasterDataset`s.
For example, WorldClim and CHELSA are `RasterProvider`s.
"""
abstract type RasterProvider end

# List of datasets
struct BioClim <: RasterDataset end
struct Elevation <: RasterDataset end
struct MinimumTemperature <: RasterDataset end
struct MaximumTemperature <: RasterDataset end
struct AverageTemperature <: RasterDataset end
struct Precipitation <: RasterDataset end
struct SolarRadiation <: RasterDataset end
struct WindSpeed <: RasterDataset end
struct WaterVaporPressure <: RasterDataset end
