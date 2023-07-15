# SSMPlots

[![](docs/logo/logo.png)](https://itsdfish.github.io/SSMPlots.jl/dev/)

[![](https://img.shields.io/badge/docs-latest-blue.svg)](https://itsdfish.github.io/SSMPlots.jl/dev/) [![CI](https://github.com/itsdfish/SSMPlots.jl/actions/workflows/CI.yml/badge.svg)](https://github.com/itsdfish/SSMPlots.jl/actions/workflows/CI.yml)


This package provides plotting functionality for sequential sampling models. The code block below provides an example:

```julia 
using SequentialSamplingModels
using SSMPlots
using Random 
Random.seed!(85)

ν = [1.0,0.50]
k = 0.50
A = 1.0
τ = 0.30

dist = RDM(;ν, k, A, τ)
histogram(dist; xlims=(0,2.5))
plot!(dist; t_range=range(.301, 2.5, length=100))
```
<img src="resources/example.png" />

For more information, please see the documentation link above. Additional examples can be found at [SequentialSamplingModels.jl](https://itsdfish.github.io/SequentialSamplingModels.jl/dev/).