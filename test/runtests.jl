using SimpleSDMDatasets
using Test

global anyerrors = false

tests = [
    "Type basics        " => "01_type_construction.jl",
    #"WorldClim2 provider" => "02_worldclim_v2.jl",
    "EarthEnv provider  " => "03_earthenv.jl",
    "CHELSA2 provider   " => "04_chelsa_v2.jl",
]

for test in tests
   try
      include(test.second)
      println("\033[1m\033[32m✓\033[0m\t$(test.first)")
   catch e
      global anyerrors = true
      println("\033[1m\033[31m×\033[0m\t$(test.first)")
      println("\033[1m\033[38m→\033[0m\ttest/$(test.second)")
      showerror(stdout, e, backtrace())
      println()
      break
   end
end

if anyerrors
   throw("Tests failed")
end
