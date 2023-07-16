# Changing the Layout 

As the example below demonstrates, the SSMPlots.jl panels density plots by choice:


```@example layout 
using SequentialSamplingModels
using SSMPlots
using Random 
Random.seed!(85)

ν = [1.0,0.50]
k = 0.50
A = 1.0
τ = 0.30

dist = RDM(;ν, k, A, τ)
plot(dist; t_range=range(.301, 2.5, length=100))
```
In some cases, one might prefer combining both density lines in the same plot. The code block below demonstrates how this can be achieved:

```@example layout 
using SequentialSamplingModels
using SSMPlots
using Random 
Random.seed!(85)

ν = [1.0,0.50]
k = 0.50
A = 1.0
τ = 0.30

dist = RDM(;ν, k, A, τ)
t_range=range(.301, 2.5, length=100)
plot(dist; 
    t_range, 
    layout=(1,1), 
    leg=true, 
    label=["1" "2"], 
    color=[:blue :red], 
    title="", 
    labeltitle="choice"
)
```
