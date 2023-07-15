# Overview

**Documentation Under Construction**

SSMPlots.jl provides convience functions for generating plots related to sequential sampling models (SSMs). Please visit [SequentialSamplingModels.jl](https://itsdfish.github.io/SequentialSamplingModels.jl/dev/) to find information about a Julia package 
for using SSMs. 
# Installation

In the REPL, type `]` to enter package mode and type

```julia 
add SSMPlots
```
to add SSPlots.jl to your environment.

# Quick Example
In this quick example, we will plot the histogram for the Racing Diffusion Model (RDM). Note that you will need to install SequentialSamplingModels in order for the example to work.
```@setup 
using Random 
Random.seed!(89)
```

```@example 
using SequentialSamplingModels
using SSMPlots

ν = [1.0,0.50]
k = 0.50
A = 1.0
τ = 0.30

dist = RDM(;ν, k, A, τ)
histogram(dist; xlims=(0,2.5))
```