# The dataset interface

This page is meant for *contributors* to the package, and specifically provides
information on the interface, what to overload, and why.

All of the methods that form the interface have two versions: one for current
data, and one for future data. The default behavior of the interface is for the
version on future data to fall back to the version for current data (*i.e.* we
assume that future data are provided with the same format as current data). This
means that most of the functions will not need to be overloaded when adding a
provider with support for future data.

## Compatibility between datasets and providers

The inner constructor for `RasterData` involves a call to `provides`, which must
return `true` for the type to be constructed. The generic method for `provides`
returns `false`, so additional provider/dataset pairs *must* be overloaded to
return `true` in order for the corresponding `RasterData` type to exist.

In practice, especially when there are multiple datasets for a single provider,
the easiest way is to define a `Union` type and overload based on membership to
this union type.

```@docs
SimpleSDMDatasets.provides
```

## Type of object downloaded

```@docs
SimpleSDMDatasets.downloadtype
```

## Type of object stored

```@docs
SimpleSDMDatasets.filetype
```

## Available resolutions

```@docs
SimpleSDMDatasets.resolutions
```

## Available layers

```@docs
SimpleSDMDatasets.layers
SimpleSDMDatasets.layerdescriptions
```

## Available months

```@docs
SimpleSDMDatasets.months
```

## Available years

```@docs
SimpleSDMDatasets.timespans
```

## Additional keyword arguments

```@docs
SimpleSDMDatasets.extrakeys
```

## URL for the data to download

```@docs
SimpleSDMDatasets.source
```

## Path to the data locally

```@docs
SimpleSDMDatasets.destination
```