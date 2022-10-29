using Documenter
using SimpleSDMDatasets

makedocs(;
    sitename = "SimpleSDMDatasets.jl",
    format = Documenter.HTML(;
        prettyurls = get(ENV, "CI", nothing) == true,
    ),
    pages = [
        "Index" => "index.md",
        "Interface" => "interface.md",
    ],
)