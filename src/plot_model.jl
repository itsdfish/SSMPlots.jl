"""
    plot_model(model::AbstractLCA; 
        add_density=false, density_kwargs=(), n_sim=1, kwargs...)

Plot the evidence accumulation process of the leaky competing accumulator model.

# Arguments

- `model::AbstractLCA`: leaky competing accumulator model object 

# Keywords 

- `add_density=false`: add density plot above threshold line if true 
- `density_kwargs=()`: pass optional keyword arguments to density plot 
- `labels = default_labels(model)`: a vector of parameter label options 
- `density_scale = model.α`: scale the maximum height of the density
- `n_sim=1`: the number of simulated decision processes per option
- `kwargs...`: optional keyword arguments for configuring plot options
"""
function plot_model(model::AbstractLCA; 
            add_density=false, 
            density_kwargs=(), 
            labels = default_labels(model), 
            density_scale = model.α,
            n_sim=1, 
            kwargs...)
    n_subplots = n_options(model)
    defaults = get_model_plot_defaults(model, n_subplots)
    model_plot = plot(;defaults..., kwargs...)
    for i ∈ 1:n_sim
        time_range,evidence = simulate(model)
        time_range .+= model.τ
        plot!(model_plot, time_range, evidence; defaults..., kwargs...)
    end
    add_threashold!(model, model_plot)
    for s ∈ 1:n_subplots
        annotate!(labels, subplot=s)
    end
    if add_density 
        plot!(model_plot, model; 
            density_offset = model.α + .05, 
            density_scale,
            xlabel = "",
            ylabel = "", 
            xticks = nothing,
            yticks = nothing, 
            density_kwargs...)
    end
    plot!(model_plot; defaults...)
    return model_plot
end

"""
    plot_model(model::AbstractLBA; 
        add_density=false, density_kwargs=(), n_sim=1, kwargs...)

Plot the evidence accumulation process of the leaky competing accumulator model.

# Arguments

- `model::AbstractLBA`: linear ballistic accumulator model object 

# Keywords 

- `add_density=false`: add density plot above threshold line if true 
- `density_kwargs=()`: pass optional keyword arguments to density plot
- `labels = default_labels(model),`: a vector of parameter label options 
- `density_scale = model.A + model.k`: scale the maximum height of the density
- `n_sim=1`: the number of simulated decision processes per option
- `kwargs...`: optional keyword arguments for configuring plot options
"""
function plot_model(model::AbstractLBA; 
            add_density=false, 
            density_kwargs=(),
            labels = default_labels(model), 
            density_scale = model.A + model.k,
            n_sim=1, 
            kwargs...)
    n_subplots = n_options(model)
    defaults = get_model_plot_defaults(model, n_subplots)
    model_plot = plot(;defaults..., kwargs...)
    add_starting_point!(model, model_plot)
    α = model.A + model.k
    for i ∈ 1:n_sim
        time_range,evidence = simulate(model)
        plot!(model_plot, time_range .+ model.τ, evidence; 
            ylims=(0, α), defaults..., kwargs...)
    end
    add_threashold!(model, model_plot)
    for s ∈ 1:n_subplots
        annotate!(labels, subplot=s)
    end
    if add_density 
        plot!(model_plot, model; 
            density_scale,
            density_offset = α + 0.05,
            xlabel = "",
            ylabel = "", 
            xticks = nothing,
            yticks = nothing, 
            density_kwargs...)
    end
    return model_plot
end

"""
    plot_model(model::AbstractRDM; 
        add_density=false, density_kwargs=(), n_sim=1, kwargs...)

Plot the evidence accumulation process of the racing diffusion model.

# Arguments

- `model::AbstractRDM`: racing diffusion model object 

# Keywords 

- `add_density=false`: add density plot above threshold line if true 
- `density_kwargs=()`: pass optional keyword arguments to density plot 
- `labels = default_labels(model)`: a vector of parameter label options 
- `density_scale = model.A + model.k`: scale the maximum height of the density
- `n_sim=1`: the number of simulated decision processes per option
- `kwargs...`: optional keyword arguments for configuring plot options
"""
function plot_model(model::AbstractRDM; 
            add_density = false, 
            density_kwargs = (), 
            labels = default_labels(model), 
            density_scale = model.A + model.k,
            n_sim = 1, 
            kwargs...)
    n_subplots = n_options(model)
    defaults = get_model_plot_defaults(model, n_subplots)
    model_plot = plot(;defaults..., kwargs...)
    add_starting_point!(model, model_plot)
    α = model.A + model.k
    zs = Vector{Vector{Float64}}(undef,n_sim)
    for i ∈ 1:n_sim
        time_range,evidence = simulate(model)
        plot!(model_plot, time_range .+ model.τ, evidence; 
            ylims=(0, α), defaults..., kwargs...)
        zs[i] = evidence[1,:][:] 
    end
    add_threashold!(model, model_plot)
    #add_mean_drift_rate(model, model_plot, zs)
    for s ∈ 1:n_subplots
        annotate!(labels, subplot=s)
    end
    if add_density 
        plot!(model_plot, model; 
            density_scale,
            density_offset = α  + .05,
            xlabel = "",
            ylabel = "", 
            xticks = nothing,
            yticks = nothing, 
            density_kwargs...)
    end
    return model_plot
end

"""
    plot_model(model::AbstractWald; 
        add_density=false, density_kwargs=(), n_sim=1, kwargs...)

Plot the evidence accumulation process of the leaky competing accumulator model.

# Arguments

- `model::AbstractWald`: Wald model object 

# Keywords 

- `add_density=false`: add density plot above threshold line if true 
- `density_kwargs=()`: pass optional keyword arguments to density plot 
- `labels = default_labels(model)`: a vector of parameter label options 
- `density_scale = model.α`: scale the maximum height of the density
- `n_sim=1`: the number of simulated decision processes per option
- `kwargs...`: optional keyword arguments for configuring plot options
"""
function plot_model(model::AbstractWald; 
            add_density=false, 
            density_kwargs=(), 
            labels = default_labels(model), 
            density_scale = model.α,
            n_sim=1, 
            kwargs...)
    n_subplots = n_options(model)
    defaults = get_model_plot_defaults(model, n_subplots)
    model_plot = plot(;defaults..., kwargs...)
    for i ∈ 1:n_sim
        time_range,evidence = simulate(model)
        time_range .+= model.τ
        plot!(model_plot, time_range, evidence; defaults..., kwargs...)
    end
    add_threashold!(model, model_plot)
    for s ∈ 1:n_subplots
        annotate!(labels, subplot=s)
    end
    if add_density 
        plot!(model_plot, model; 
            density_scale,
            density_offset = model.α + .05, 
            xlabel = "",
            ylabel = "", 
            xticks = nothing,
            yticks = nothing, 
            density_kwargs...)
    end
    plot!(model_plot; defaults...)
    return model_plot
end

"""
    default_labels(model::AbstractRDM)

Generates default parameter labels and locations for threshold and non-decision time 

# Arguments

- `model`: a generic model object
"""
function default_labels(model)
    (;τ,α) = model
    return [
        (0,α,text("α", 10, :right)),
        (τ/2,0,text("τ",10, :bottom)),
    ]
end

"""
    default_labels(model::AbstractLBA)

Generates default parameter labels and locations 

# Arguments

- `model::AbstractLBA`: an object for the linear ballistic accumulator
"""
function default_labels(model::AbstractLBA)
    (;τ,A,k) = model
    α = A + k
    return [
        (τ,A,text("A", 10, :right, :top)),
        (0,α,text("α", 10, :right)),
        (τ/2,0,text("τ",10, :bottom)),
    ]
end

"""
    default_labels(model::AbstractRDM)

Generates default parameter labels and locations 

# Arguments

- `model::AbstractRDM`: an object for the racing diffusion model
"""
function default_labels(model::AbstractRDM)
    (;τ,A,k) = model
    α = A + k
    return [
        (τ,A,text("A", 10, :right, :top)),
        (0,α,text("α", 10, :right)),
        (τ/2,0,text("τ",10, :bottom)),
    ]
end

"""
    add_starting_point!(model::AbstractLBA, cur_plot; kwargs...)

Adds a rectangle representing the starting point and non-decision time

# Arguments

- `model::AbstractLBA`: an object representing the linear ballistic accumulator model 
- `model_plot`: a plot object 

# Keywords 

- `kwargs...`: optional keyword arguments for configuring the plot 
"""
function add_starting_point!(model::AbstractLBA, cur_plot; kwargs...)
    (;τ,A) = model 
    for s ∈ 1:n_options(model)
        plot!(cur_plot, [τ, τ],[0, A], subplot=s, color=:black; kwargs...)
        plot!(cur_plot, [0, τ],[A, A], subplot=s, color=:black; kwargs...)
        plot!(cur_plot, [0, 0],[0, A], subplot=s, color=:black; kwargs...)
    end
    return nothing 
end

"""
    add_starting_point!(model::AbstractRDM, cur_plot; kwargs...)

Adds a rectangle representing the starting point and non-decision time

# Arguments

- `model::AbstractRDM`: an object representing the racing diffusion model 
- `model_plot`: a plot object 

# Keywords 

- `kwargs...`: optional keyword arguments for configuring the plot 
"""
function add_starting_point!(model::AbstractRDM, cur_plot; kwargs...)
    (;τ,A) = model 
    for s ∈ 1:n_options(model)
        plot!(cur_plot, [τ, τ],[0, A], subplot=s, color=:black; kwargs...)
        plot!(cur_plot, [0, τ],[A, A], subplot=s, color=:black; kwargs...)
        plot!(cur_plot, [0, 0],[0, A], subplot=s, color=:black; kwargs...)
    end
    return nothing 
end

"""
    add_threashold!(model, model_plot; kwargs...)

Adds a horizonal line reprenting the decision threshold. 

# Arguments

- `model`: an object representing either a `SSM1D` or `SSM2D` model
- `model_plot`: a plot object 

# Keywords 

- `kwargs...`: optional keyword arguments for configuring the plot 
"""
function add_threashold!(model, model_plot; kwargs...)
    hline!(model_plot, fill(model.α, 1, n_options(model)), 
        linestyle=:dash, color=:black;  kwargs...)
    return nothing
end

"""
    add_threashold!(model::AbstractLBA, model_plot; kwargs...)

Adds a horizonal line reprenting the decision threshold. 

# Arguments

- `model::AbstractLBA`: an object representing the linear ballistic accumulator model 
- `model_plot`: a plot object 

# Keywords 

- `kwargs...`: optional keyword arguments for configuring the plot 
"""
function add_threashold!(model::AbstractLBA, model_plot; kwargs...)
    α = model.A + model.k
    hline!(model_plot, fill(α, 1, n_options(model)), linestyle=:dash,
         color=:black;  kwargs...)
    return nothing
end

"""
    add_threashold!(model::AbstractRDM, model_plot; kwargs...)

Adds a horizonal line reprenting the decision threshold. 

# Arguments

- `model::AbstractRDM`: an object representing the racing diffusion model 
- `model_plot`: a plot object 

# Keywords 

- `kwargs...`: optional keyword arguments for configuring the plot 
"""
function add_threashold!(model::AbstractRDM, model_plot; kwargs...)
    α = model.A + model.k
    hline!(model_plot, fill(α, 1, n_options(model)), linestyle=:dash,
         color=:black;  kwargs...)
    return nothing
end

"""
    get_model_plot_defaults(d::AbstractLCA, n_subplots)

Returns default plot options 

# Arguments

- `d::AbstractLCA`: an object for the leaky competing accumulator
- `n_subplots`: the number of subplots (i.e., choices)
"""
function get_model_plot_defaults(d::AbstractLCA, n_subplots)
    title = ["choice $i" for _ ∈ 1:1,  i ∈ 1:n_subplots]
    return (xaxis=nothing, yaxis=nothing, xticks=nothing, yticks=nothing,
         grid=false, linewidth = .75, color = :black, leg=false, title, layout=(n_subplots,1))
end

"""
    get_model_plot_defaults(d::AbstractWald, n_subplots)

Returns default plot options 

# Arguments

- `d::AbstractWald`: an object for the Wald model
- `n_subplots`: the number of subplots (i.e., choices)
"""
function get_model_plot_defaults(d::AbstractWald, n_subplots)
    title = ["choice $i" for _ ∈ 1:1,  i ∈ 1:n_subplots]
    return (xaxis=nothing, yaxis=nothing, xticks=nothing, yticks=nothing,
         grid=false, linewidth = .75, color = :black, leg=false, title, layout=(n_subplots,1))
end

"""
    get_model_plot_defaults(d::AbstractRDM, n_subplots)

Returns default plot options 

# Arguments

- `d::AbstractRDM`: an object for the racing diffusion model
- `n_subplots`: the number of subplots (i.e., choices)
"""
function get_model_plot_defaults(d::AbstractRDM, n_subplots)
    title = ["choice $i" for _ ∈ 1:1,  i ∈ 1:n_subplots]
    return (xaxis=nothing, yaxis=nothing, xticks=nothing, yticks=nothing, 
        linewidth = .75, color = :black, leg=false, title, layout=(n_subplots,1))
end

"""
    get_model_plot_defaults(d::AbstractLBA, n_subplots)

Returns default plot options 

# Arguments

- `d::AbstractLBA`: an object for the linear ballistic accumulator
- `n_subplots`: the number of subplots (i.e., choices)
"""
function get_model_plot_defaults(d::AbstractLBA, n_subplots)
    title = ["choice $i" for _ ∈ 1:1,  i ∈ 1:n_subplots]
    return (xaxis=nothing, yaxis=nothing, xticks=nothing, yticks=nothing, grid=false, 
        linewidth = .75, color = :black, leg=false, title, layout=(n_subplots,1), arrow=:closed)
end

# function add_mean_drift_rate(model, cur_plot, zs)
#     z = mean(zs)
#     x,y = make_mean_drift_rate_line(model, z)
#     plot!(cur_plot, x, y, color=:black)
# end

# function make_mean_drift_rate_line(model, z)
#     (;ν,k,A,τ) = model 
#     α = A + k
#     xmin = τ
#     xmax = @. (α - z) / ν + τ
#     x = collect.(range.(xmin, xmax, length=100))
#     y = map((x,ν,z) -> (x .- τ) * ν .+ z, x, ν, z)
#     return x,y
# end
