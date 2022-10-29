using Documenter
using SimpleSDMDatasets

makedocs(;
    sitename = "SimpleSDMDatasets.jl",
    format = Documenter.HTML(;
        prettyurls = get(ENV, "CI", nothing) == true,
    ),
    pages = [
        "Index" => "index.md",
        "Guide for users" => [
            "Retrieving data" => "usr/getdata.md",
        ],
        "Guide for contributors" => [
            "Interface" => "dev/interface.md",
            "Type system" => "dev/types.md",
        ],
    ],
)

deploydocs(; repo = "github.com/PoisotLab/SimpleSDMDatasets.jl.git")