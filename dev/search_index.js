var documenterSearchIndex = {"docs":
[{"location":"usr/getdata.html#Getting-data","page":"Retrieving data","title":"Getting data","text":"","category":"section"},{"location":"dev/interface.html#The-dataset-interface","page":"Interface","title":"The dataset interface","text":"","category":"section"},{"location":"dev/interface.html","page":"Interface","title":"Interface","text":"This page is meant for contributors to the package, and specifically provides information on the interface, what to overload, and why.","category":"page"},{"location":"dev/interface.html","page":"Interface","title":"Interface","text":"All of the methods that form the interface have two versions: one for current data, and one for future data. The default behavior of the interface is for the version on future data to fall back to the version for current data (i.e. we assume that future data are provided with the same format as current data). This means that most of the functions will not need to be overloaded when adding a provider with support for future data.","category":"page"},{"location":"dev/interface.html#Compatibility-between-datasets-and-providers","page":"Interface","title":"Compatibility between datasets and providers","text":"","category":"section"},{"location":"dev/interface.html","page":"Interface","title":"Interface","text":"SimpleSDMDatasets.provides","category":"page"},{"location":"dev/interface.html#SimpleSDMDatasets.provides","page":"Interface","title":"SimpleSDMDatasets.provides","text":"provides(::Type{P}, ::Type{D}) where {P <: RasterProvider, D <: RasterDataset}\n\nThis is the core function upon which the entire interface is built. Its purpose is to specify whether a specific dataset is provided by a specific provider. Note that this function takes two arguments, as opposed to a RasterData argument, because it is called in the inner constructor of RasterData: you cannot instantiate a RasterData with an incompatible provider/dataset combination.\n\nThe default value of this function is false, and to allow the use of a dataset with a provider, it is required to overload it for this specific pair so that it returns true.\n\n\n\n\n\nprovides(::R, ::F) where {R <: RasterData, F <: Future}\n\nThis method for provides specifies whether a RasterData combination has support for the value of the Future (a combination of a FutureScenario and a FutureModel) given as the second argument. Note that this function is not called as part of the Future constructor (because models and scenarios are messy and dataset dependent), but is still called when requesting data.\n\nThe default value of this function is false, and to allow the use of a future dataset with a given provider, it is required to overload it so that it returns true.\n\n\n\n\n\n","category":"function"},{"location":"dev/interface.html#Type-of-object-downloaded","page":"Interface","title":"Type of object downloaded","text":"","category":"section"},{"location":"dev/interface.html","page":"Interface","title":"Interface","text":"SimpleSDMDatasets.downloadtype","category":"page"},{"location":"dev/interface.html#SimpleSDMDatasets.downloadtype","page":"Interface","title":"SimpleSDMDatasets.downloadtype","text":"downloadtype(::R) where {R <: RasterData}\n\nThis method returns a RasterDownloadType that is used internally to be more explicit about the type of object that is downloaded from the raster source. The supported values are _file (the default, which is an ascii, geotiff, NetCDF, etc. single file), and _zip (a zip archive containing files). This is a trait because we cannot trust file extensions.\n\n\n\n\n\ndownloadtype(data::R, ::F) where {R <: RasterData, F <: Future}\n\nThis method provides the type of the downloaded object for a combination of a raster source and a future scenario as a RasterDownloadType.\n\nIf no overload is given, this will default to downloadtype(data), as we can assume that the type of downloaded object is the same for both current and future scenarios.\n\n\n\n\n\n","category":"function"},{"location":"dev/interface.html#Type-of-object-stored","page":"Interface","title":"Type of object stored","text":"","category":"section"},{"location":"dev/interface.html","page":"Interface","title":"Interface","text":"SimpleSDMDatasets.filetype","category":"page"},{"location":"dev/interface.html#SimpleSDMDatasets.filetype","page":"Interface","title":"SimpleSDMDatasets.filetype","text":"filetype(::R) where {R <: RasterData}\n\nThis method returns a RasterFileType that represents the format of the raster data. RasterFileType is an enumerated type. This overload is particularly important as it will determine how the returned file path should be read.\n\nThe default value is _tiff.\n\n\n\n\n\nfiletype(data::R, ::F) where {R <: RasterData, F <: Future}\n\nThis method provides the format of the stored raster for a combination of a raster source and a future scenario as a RasterFileType.\n\nIf no overload is given, this will default to filetype(data), as we can assume that the raster format is the same for both current and future scenarios.\n\n\n\n\n\n","category":"function"},{"location":"dev/interface.html#Available-resolutions","page":"Interface","title":"Available resolutions","text":"","category":"section"},{"location":"dev/interface.html","page":"Interface","title":"Interface","text":"SimpleSDMDatasets.resolutions","category":"page"},{"location":"dev/interface.html#SimpleSDMDatasets.resolutions","page":"Interface","title":"SimpleSDMDatasets.resolutions","text":"resolutions(::R) where {R <: RasterData}\n\nThis method controls whether the dataset has a resolution, i.e. a grid size. If this is nothing (the default), it means that the dataset is only given at a set resolution.\n\nAn overload of this method is required when there are multiple resolutions available, and must return a Dict with numeric keys (for the resolution) and string values (giving the textual representation of these keys, usually in the way that is usable to build the url).\n\nAny dataset with a return value that is not nothing must accept the resolution keyword.\n\n\n\n\n\nresolutions(data::R, ::F) where {R <: RasterData, F <: Future}\n\nThis methods control the resolutions for a future dataset. Unless overloaded, it will return resolutions(data).\n\n\n\n\n\n","category":"function"},{"location":"dev/interface.html#Available-layers","page":"Interface","title":"Available layers","text":"","category":"section"},{"location":"dev/interface.html","page":"Interface","title":"Interface","text":"SimpleSDMDatasets.layers\nSimpleSDMDatasets.layerdescriptions","category":"page"},{"location":"dev/interface.html#SimpleSDMDatasets.layers","page":"Interface","title":"SimpleSDMDatasets.layers","text":"layers(::R) where {R <: RasterData}\n\nThis method controls whether the dataset has named layers. If this is nothing (the default), it means that the dataset will have a single layer.\n\nAn overload of this method is required when there are multiple layers available, and must return a Vector, usually of String. Note that by default, the layers can also be accessed by using an Integer, in which case layer=i will be the i-th entry in layers(data).\n\nAny dataset with a return value that is not nothing must accept the layer keyword.\n\n\n\n\n\n","category":"function"},{"location":"dev/interface.html#SimpleSDMDatasets.layerdescriptions","page":"Interface","title":"SimpleSDMDatasets.layerdescriptions","text":"layerdescriptions(data::R) where {R <: RasterData}\n\nHuman-readable names the layers. This will by default print the value of layers, but can be overloaded if these names are not informative.\n\n\n\n\n\n","category":"function"},{"location":"dev/interface.html#Available-months","page":"Interface","title":"Available months","text":"","category":"section"},{"location":"dev/interface.html","page":"Interface","title":"Interface","text":"SimpleSDMDatasets.months","category":"page"},{"location":"dev/interface.html#SimpleSDMDatasets.months","page":"Interface","title":"SimpleSDMDatasets.months","text":"months(::R) where {R <: RasterData}\n\nThis method controls whether the dataset has monthly layers. If this is nothing (the default), it means that the dataset is not accessible at a monthly resolution.\n\nAn overload of this method is required when there are multiple months available, and must return a Vector{Dates.Month}.\n\nAny dataset with a return value that is not nothing must accept the month keyword.\n\n\n\n\n\n","category":"function"},{"location":"dev/interface.html#Additional-keyword-arguments","page":"Interface","title":"Additional keyword arguments","text":"","category":"section"},{"location":"dev/interface.html","page":"Interface","title":"Interface","text":"SimpleSDMDatasets.extrakeys","category":"page"},{"location":"dev/interface.html#SimpleSDMDatasets.extrakeys","page":"Interface","title":"SimpleSDMDatasets.extrakeys","text":"extrakeys(::R) where {R <: RasterData}\n\nThis method controls whether the dataset has additional keys. If this is nothing (the default), it means that the dataset can be accessed using only the default keys specified in this interface.\n\nAn overload of this method is required when there are additional keywords needed to access the data (e.g. full=true for the EarthEnv land-cover data), and must return a Dict, with Symbol keys and Tuple arguments, where the key is the keyword argument passed to downloader and the tuple lists all accepted values.\n\nAny dataset with a return value that is not nothing must accept the keyword arguments specified in the return value.\n\n\n\n\n\n","category":"function"},{"location":"dev/interface.html#URL-for-the-data-to-download","page":"Interface","title":"URL for the data to download","text":"","category":"section"},{"location":"dev/interface.html","page":"Interface","title":"Interface","text":"SimpleSDMDatasets.source","category":"page"},{"location":"dev/interface.html#SimpleSDMDatasets.source","page":"Interface","title":"SimpleSDMDatasets.source","text":"source(::RasterData{P, D}; kwargs...) where {P <: RasterProvider, D <: RasterDataset}\n\nThis method specifies the URL for the data. It defaults to nothing, so this method must be overloaded.\n\n\n\n\n\n","category":"function"},{"location":"dev/interface.html#Path-to-the-data-locally","page":"Interface","title":"Path to the data locally","text":"","category":"section"},{"location":"dev/interface.html","page":"Interface","title":"Interface","text":"SimpleSDMDatasets.destination","category":"page"},{"location":"dev/interface.html#SimpleSDMDatasets.destination","page":"Interface","title":"SimpleSDMDatasets.destination","text":"destination(::RasterData{P, D}; kwargs...) where {P <: RasterProvider, D <: RasterDataset}\n\nThis method specifies where the data should be stored locally. By default, it is the _LAYER_PATH, followed by the provider name, followed by the dataset name.\n\n\n\n\n\n","category":"function"},{"location":"dev/types.html#Type-system-for-datasets","page":"Type system","title":"Type system for datasets","text":"","category":"section"},{"location":"dev/types.html#List-of-datasets","page":"Type system","title":"List of datasets","text":"","category":"section"},{"location":"dev/types.html","page":"Type system","title":"Type system","text":" ```\n\n## List of providers\n\n## List of enumerated types\n","category":"page"},{"location":"dev/types.html","page":"Type system","title":"Type system","text":"@docs SimpleSDMDatasets.RasterDownloadType SimpleSDMDatasets.RasterFileType ```","category":"page"},{"location":"index.html#SimpleSDMDatasets","page":"Index","title":"SimpleSDMDatasets","text":"","category":"section"},{"location":"index.html","page":"Index","title":"Index","text":"The purpose of this package is to get raster datasets for use in biogeography work, retrieve them from online locations, and store them in a central location to avoid data duplication. Datasets are downloaded upon request, and only the required files are downloaded.","category":"page"},{"location":"index.html","page":"Index","title":"Index","text":"The package is built around two \"pillars\":","category":"page"},{"location":"index.html","page":"Index","title":"Index","text":"An interface based on traits, which specifies where the data live (remotely and locally), what the shape of the data is, and which keyword arguments are usable to query the data.\nA type system to identify which datasets are accessible through various providers, and which future scenarios are available.","category":"page"},{"location":"index.html","page":"Index","title":"Index","text":"The combination of the interface and the type system means that adding a new dataset is relatively straightforward, and in particular that there is no need to write dataset-specific code to download the files (beyond specifying where the data live).","category":"page"},{"location":"index.html","page":"Index","title":"Index","text":"The purpose of the documentation is to (i) list the datasets that are accessible for users through the package and (ii) give a comprehensive overview of the way the inteface works, to facilitate the addition of new data sources.","category":"page"}]
}
