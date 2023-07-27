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
        plot!(model_plot, model; 
            density_offset = model.α + .05, 
            density_kwargs...)
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
            density_scale = α,
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
    plot_model(model::RDM; 
        add_density=false, density_kwargs=(), n_sim=1, kwargs...)

Plot the evidence accumulation process of the racing diffusion model.

# Arguments

- `model::RDM`: racing diffusion model object 

# Keywords 
- `add_density=false`: add density plot above threshold line if true 
- `density_kwargs=()`: pass optional keyword arguments to density plot 
- `n_sim=1`: the number of simulated decision processes per option
- `kwargs...`: optional keyword arguments for configuring plot options
"""
function plot_model(model::RDM; 
            add_density = false, 
            density_kwargs = (), 
            labels = default_labels(model), 
            density_scale = model.A + model.k,
            n_sim = 1, 
            kwargs...)
    n_subplots = n_options(model)
    defaults = get_model_plot_defaults(model, n_subplots)
    model_plot = plot(;defaults..., kwargs...)
    add_starting_point!(model, model_plot, n_subplots)
    α = model.A + model.k
    zs = Vector{Vector{Float64}}(undef,n_sim)
    for i ∈ 1:n_sim
        time_range,evidence = simulate(model)
        plot!(model_plot, time_range .+ model.τ, evidence; 
            ylims=(0, α), defaults..., kwargs...)
        zs[i] = evidence[1,:][:] 
    end
    hline!(model_plot, fill(α, 1, n_subplots), linestyle=:dash, color=:black)
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

function default_labels(dist::RDM)
    (;τ,A,k) = dist
    α = A + k
    return [
        (τ,A,text("A", 10, :right, :top)),
        (0,α,text("α", 10, :right)),
        (τ/2,0,text("τ",10, :bottom)),
    ]
end

function add_starting_point!(dist::AbstractLBA, cur_plot, n_subplots)
    (;τ,A) = dist 
    for s ∈ 1:n_subplots
        plot!(cur_plot, [τ, τ],[0, A], subplot=s, color=:black)
        plot!(cur_plot, [0, τ],[A, A], subplot=s, color=:black)
        plot!(cur_plot, [0, 0],[0, A], subplot=s, color=:black)
    end
    return nothing 
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

function get_model_plot_defaults(d::LCA, n_subplots)
    title = ["choice $i" for _ ∈ 1:1,  i ∈ 1:n_subplots]
    return (xaxis=nothing, yaxis=nothing, xticks=nothing, yticks=nothing,
         grid=false, linewidth = .75, color = :black, leg=false, title, layout=(n_subplots,1))
end

function get_model_plot_defaults(d::RDM, n_subplots)
    title = ["choice $i" for _ ∈ 1:1,  i ∈ 1:n_subplots]
    return (xaxis=nothing, yaxis=nothing, xticks=nothing, yticks=nothing, 
        linewidth = .75, color = :black, leg=false, title, layout=(n_subplots,1))
end

function get_model_plot_defaults(d::LBA, n_subplots)
    title = ["choice $i" for _ ∈ 1:1,  i ∈ 1:n_subplots]
    return (xaxis=nothing, yaxis=nothing, xticks=nothing, yticks=nothing, grid=false, 
        linewidth = .75, color = :black, leg=false, title, layout=(n_subplots,1), arrow=:closed)
end