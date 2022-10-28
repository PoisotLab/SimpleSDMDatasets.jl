module TestSSDTypes

using SimpleSDMDatasets
using Test

@test_throws "does not allow for month" slurp(RasterData(EarthEnv, LandCover); month = true)

@test_throws "no thank you is not supported for the keyword argument full" slurp(
    RasterData(EarthEnv, LandCover);
    full = "no thank you",
)

@test_throws "does not support multiple resolutions" slurp(
    RasterData(EarthEnv, LandCover);
    resolution = π,
)

@test_throws "does not support multiple resolutions" slurp(
    RasterData(EarthEnv, LandCover);
    resolution = π,
)

@test_throws ["The layer", "not supported by the"] slurp(
    RasterData(EarthEnv, LandCover);
    layer = "LMFAO",
)

end