"""
    RasterProvider

This is an *abstract* type to label something as a provider of `RasterDataset`s.
For example, WorldClim and CHELSA are `RasterProvider`s.
"""
abstract type RasterProvider end

struct WorldClim <: RasterProvider end
struct EarthEnv <: RasterProvider end
struct CHELSA <: RasterProvider end