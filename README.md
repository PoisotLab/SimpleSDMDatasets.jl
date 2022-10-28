# SimpleSDMDatasets

This *will* serve as a replacement for the data system in *SimpleSDMLayers.jl*.
This package has a smaller mission statement, namely:

1. provide a simple interface to get access to raster data
2. implement this interface for commonly used data
3. ensure that the raster data are downloaded as needed and stored in a central location
4. provide enough checks that users can build on top of it rapidly (for example,
   the wrapper for CHELSA2.1 data is only about 15 loc)

For now this is a *work in progress*