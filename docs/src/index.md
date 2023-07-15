# Overview

**Documentation Under Construction**

SSMPlots.jl provides convience functions for generating plots related to sequential sampling models (SSMs). SSMs are models of human decision making in which evidence for each option accumulates dynamically until the evidence for one option hits a decision threshold. For more information, see the references below. Please visit [SequentialSamplingModels.jl](https://itsdfish.github.io/SequentialSamplingModels.jl/dev/) to find information about a Julia package for using SSMs. 
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
Random.seed!(819)
```

```@example 
using SequentialSamplingModels
using SSMPlots

dist = RDM(;ν = [2.0,1.50], k = 0.50, A = 1.0, τ = 0.30)
histogram(dist; xlims=(0,1.5))
```

# References
Evans, N. J. & Wagenmakers, E.-J. Evidence accumulation models: Current limitations and future directions. Quantitative Methods for Psychololgy 16, 73–90 (2020).

Forstmann, B. U., Ratcliff, R., & Wagenmakers, E. J. (2016). Sequential sampling models in cognitive neuroscience: Advantages, applications, and extensions. Annual Review of Psychology, 67, 641-666.

Jones, M., & Dzhafarov, E. N. (2014). Unfalsifiability and mutual translatability of major modeling schemes for choice reaction time. Psychological Review, 121(1), 1.