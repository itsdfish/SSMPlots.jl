"""
    plot_model(model::LCA; 
        add_density=false, density_kwargs=(), n_sim=1, kwargs...)

Plot the evidence accumulation process of the leaky competing accumulator model.

# Arguments

- `model::LCA`: leaky competing accumulator model object 

# Keywords 
- `add_density=false`: add density plot above threshold line if true 
- `density_kwargs=()`: pass optional keyword arguments to density plot 
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

"""
    plot_model(model::LBA; 
        add_density=false, density_kwargs=(), n_sim=1, kwargs...)

Plot the evidence accumulation process of the leaky competing accumulator model.

# Arguments

- `model::LBA`: linear ballistic accumulator model object 

# Keywords 
- `add_density=false`: add density plot above threshold line if true 
- `density_kwargs=()`: pass optional keyword arguments to density plot 
- `n_sim=1`: the number of simulated decision processes per option
- `kwargs...`: optional keyword arguments for configuring plot options
"""
function plot_model(model::LBA; 
            add_density=false, density_kwargs=(), n_sim=1, kwargs...)
    n_subplots = n_options(model)
    defaults = get_model_plot_defaults(model, n_subplots)
    model_plot = plot(;defaults..., kwargs...)
    add_starting_point!(model, model_plot, n_subplots)
    α = model.A + model.k
    for i ∈ 1:n_sim
        time_range,evidence = simulate(model)
        plot!(model_plot, time_range .+ model.τ, evidence; 
            ylims=(0, α), defaults..., kwargs...)
    end
    hline!(model_plot, fill(α, 1, n_subplots), linestyle=:dash, color=:black)
    if add_density 
        plot!(model_plot, model; 
            density_offset=α * 1.1, ylabel="", yticks=nothing, density_kwargs...)
    end
    #plot!(model_plot; defaults...)
    return model_plot
end

function add_starting_point!(dist, cur_plot, n_subplots)
    (;τ,A) = dist 
    for s ∈ 1:n_subplots
        plot!(cur_plot, [τ, τ],[0, A], subplot=s, color=:black)
        plot!(cur_plot, [0, τ],[A, A], subplot=s, color=:black)
        plot!(cur_plot, [0, 0],[0, A], subplot=s, color=:black)
    end
    return nothing 
end

function get_model_plot_defaults(d::LCA, n_subplots)
    title = ["choice $i" for _ ∈ 1:1,  i ∈ 1:n_subplots]
    #ymax = d.α * 1.1
    return (xaxis=("RT [s]"), grid=false, #yaxis = "evidence",
        linewidth = .75, color = :grey, leg=false, title,
         layout=(n_subplots,1))
end

function get_model_plot_defaults(d::LBA, n_subplots)
    title = ["choice $i" for _ ∈ 1:1,  i ∈ 1:n_subplots]
    return (xaxis=("RT [s]"), grid=false, #yaxis = "evidence", 
        linewidth = .75, color = :grey, leg=false, title,
         layout=(n_subplots,1), arrow=:closed, yticks=nothing)
end