***Under Construction***
The model components, including the evidence accumulation process, can be plotted with the function `plot_model`. The code block below shows the evidence accumulation process for the leaky competing accumulator.
```@example mode_plot 
using SequentialSamplingModels
using SSMPlots
using Random 
Random.seed!(74)

dist = LCA()
plot_model(dist)
```
As shown below, the density can be overlayed on the threshold (dashed line) to show the implied probability density of the model.
```@example mode_plot 
using SequentialSamplingModels
using SSMPlots
using Random 
Random.seed!(74)

dist = LCA()
plot_model(dist; 
    n_sim = 10, 
    add_density = true, 
    density_kwargs = (;t_range=range(.3, 1.5, length=100),)
)
```