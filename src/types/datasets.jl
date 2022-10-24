abstract type RasterDataset end
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