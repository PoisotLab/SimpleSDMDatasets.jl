CHELSA2Scenario = Union{SSP126, SSP370, SSP585}
CHELSA2Model = Union{GFDL_ESM4, IPSL_CM6A_LR, MPI_ESM1_2_HR, MRI_ESM2_0, UKESM1_0_LL}

provides(
    ::RasterData{CHELSA2, T},
    ::Future{S, M},
) where {T <: CHELSA2Dataset, S <: CHELSA2Scenario, M <: CHELSA2Model} = true

timespans(
    ::RasterData{CHELSA2, T},
    ::Future{S, M},
) where {T <: CHELSA2Dataset, S <: CHELSA2Scenario, M <: CHELSA2Model} = [
    Year(2011) => Year(2040),
    Year(2041) => Year(2070),
    Year(2071) => Year(2100),
]

# Get the dataset source
function source(
    data::RasterData{CHELSA2, T},
    future::Future{S, M};
    layer = first(layers(data)),
    timespan = first(timespans(data, future))
) where {T <: BioClim, S <: CHELSA2Scenario, M <: CHELSA2Model}
    var_code = (layer isa Integer) ? layer : findfirst(isequal(layer), layers(data))
    year_sep = string(timespan.first.value) * "-" * string(timespan.second.value)
    model_sep = replace(uppercase(string(M)) * "/" * lowercase(string(S)), "_" => "-")
    root = "https://envicloud.wsl.ch/envicloud/chelsa/chelsa_V2/GLOBAL/climatologies/$(year_sep)/$(model_sep)/bio/"
    stem = "CHELSA_bio$(var_code)_$(year_sep)_$(lowercase(replace(string(M), "_" => "-")))_$(lowercase(string(S)))_V.2.1.tif"
    return (
        url = root * stem,
        filename = lowercase(stem),
        outdir = destination(data, future),
    )
end