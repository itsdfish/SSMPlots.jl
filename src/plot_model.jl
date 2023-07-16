"""
    plot_model(model::LCA; n_sim=1, kwargs...)

Plot the evidence accumulation process of the leaky competing accumulator model.

# Arguments

- `model::LCA`: leaky competing accumulator model object 

# Keywords 

- `n_sim=1`: the number of simulated decision processes per option
- `kwargs...`: optional keyword arguments for configuring plot options
"""
function plot_model(model::LCA; 
    add_density=false, density_kwargs=(), n_sim=1, kwargs...)
    n_subplots = n_options(model)
    defaults = get_model_plot_defaults(model, n_subplots)
    model_plot = plot(;defaults..., kwargs...)
    for i ∈ 1:n_sim
        time_range,evidence = simulate(model)
        time_range .+= model.τ
        plot!(model_plot, time_range, evidence; defaults..., kwargs...)
    end
    hline!(model_plot, fill(model.α, 1, n_subplots), linestyle=:dash, color=:black)
    if add_density 
        plot!(model_plot, model; density_offset=model.α * 1.1, density_kwargs...)
    end
    plot!(model_plot; defaults...)
    return model_plot
end

function get_model_plot_defaults(d::LCA, n_subplots)
    title = ["choice $i" for _ ∈ 1:1,  i ∈ 1:n_subplots]
    #ymax = d.α * 1.1
    return (xaxis=("RT [s]"), yaxis = "evidence", grid=false,
        linewidth = 1.5, color = :grey, leg=false, title,
         layout=(n_subplots,1))#, ylims = (0, ymax))
end