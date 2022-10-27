# Download interface

What I want to write is:

~~~julia
SimpleSDMPredictor(WorldClim{BioClim}, SSP126{ACCESSCM2}; resolution=0.5, year=Year(2050))
~~~

In order to get to that, we need

1. A type system for data sets and data providers (here `WorldClim` is a data provider, and the dataset is `BioClim`)
2. A way to ensure that the `eltype` of a provider is a valid dataset
3. A type system for future scenarios under models (here the future is `SSP000` and the scenario is `CanESM12`)
4. A way to ensure that the `eltype` of a future is a valid scenario
5. A way to link these types together, which is simple for data sets/providers, but can be more nested for futures
