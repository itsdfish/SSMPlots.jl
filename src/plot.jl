"""
    plot(d::SSM2D; t_range=default_range(d), kwargs...)

Plots the probability density of a multi-alternative sequential sampling model.

# Arguments

- `d::SSM2D`: a model object for a mult-alternative sequential sampling model 

# Keywords 

- `t_range`: the range of time points over which the probability density is plotted 
- `m_args=()`: optional positional arguments passed to `rand` if applicable
- `kwargs...`: optional keyword arguments for configuring  plot options
"""
function plot(d::SSM2D; t_range=default_range(d), kwargs...)
    return ssm_plot(get_pdf_type(d), d; t_range, kwargs...)
end

"""
    plot(d::SSM1D; t_range=default_range(d), kwargs...)

Plots the probability density of a single alternative sequential sampling model.

# Arguments

- `d::SSM1D`: a model object for a single alternative sequential sampling model 

# Keywords 

- `t_range`: the range of time points over which the probability density is plotted 
- `m_args=()`: optional positional arguments passed to `rand` if applicable
- `kwargs...`: optional keyword arguments for configuring plot options
"""
function plot(d::SSM1D; t_range=default_range(d), kwargs...)
    return ssm_plot(get_pdf_type(d), d; t_range, kwargs...)
end

function ssm_plot(::Type{<:Exact}, d; 
        density_offset = 0, t_range, kwargs...)
    n_subplots = n_options(d)
    pds = gen_pds(d, t_range, n_subplots) 
    map!(x -> x .+ density_offset, pds, pds)
    ymax = maximum(vcat(pds...)) * 1.2
    defaults = get_plot_defaults(n_subplots)
    return plot(t_range, pds; ylims = (0,ymax), defaults..., kwargs...)
end

function ssm_plot(::Type{<:Approximate}, d;
        density_offset = 0, m_args = (), n_sim = 2000, t_range, kwargs...)
    n_subplots = n_options(d)
    choices, rts = rand(d, n_sim, m_args...)
    choice_probs = map(c -> mean(choices .== c), 1:n_subplots)
    kdes = [kernel(rts[choices .== c]) for c ∈ 1:n_subplots]
    pds = gen_pds(kdes, t_range, choice_probs)
    map!(x -> x .+ density_offset, pds, pds)
    ymax = maximum(vcat(pds...)) * 1.2
    defaults = get_plot_defaults(n_subplots)
    return plot(t_range, pds; ylims = (0,ymax), defaults..., kwargs...)
end

plot!(d::SSM2D; t_range=default_range(d), kwargs...) = plot!(Plots.current(), d; t_range, kwargs...)

plot!(d::SSM1D; t_range=default_range(d), kwargs...) = plot!(Plots.current(), d; t_range, kwargs...)

"""
    plot!([cur_plot], d::SSM1D; t_range=default_range(d), kwargs...)

Adds the probability density of a single alternative sequential sampling model to an existing plot

# Arguments

- `cur_plot`: optional current plot
- `d::SSM1D`: a model object for a single alternative sequential sampling model 

# Keywords 

- `t_range`: the range of time points over which the probability density is plotted 
- `m_args=()`: optional positional arguments passed to `rand` if applicable
- `kwargs...`: optional keyword arguments for configuring plot options
"""
function plot!(cur_plot::Plots.Plot, d::SSM1D; t_range=default_range(d), kwargs...)
    return ssm_plot!(get_pdf_type(d), d, cur_plot; t_range, kwargs...)
end

"""
    plot!([cur_plot], d::SSM2D; t_range=default_range(d), kwargs...)

Adds the probability density of a mult-alternative sequential sampling model to an existing plot

# Arguments
- `cur_plot`: optional current plot
- `d::SSM2D`: a model object for a mult-alternative sequential sampling model 

# Keywords 

- `t_range`: the range of time points over which the probability density is plotted 
- `m_args=()`: optional positional arguments passed to `rand` if applicable
- `kwargs...`: optional keyword arguments for configuring plot options
"""
function plot!(cur_plot::Plots.Plot, d::SSM2D; t_range=default_range(d), kwargs...)
    return ssm_plot!(get_pdf_type(d), d, cur_plot; t_range, kwargs...)
end

function ssm_plot!(::Type{<:Exact}, d, cur_plot; 
        density_offset = 0, t_range, kwargs...)
    n_subplots = n_options(d)
    pds = gen_pds(d, t_range, n_subplots)
    map!(x -> x .+ density_offset, pds, pds)
    ymax = maximum(vcat(pds...)) * 1.2
    defaults = get_plot_defaults(n_subplots)
    return plot!(cur_plot, t_range, pds; ylims = (0,ymax), defaults..., kwargs...)
end

function ssm_plot!(::Type{<:Approximate}, d, cur_plot; 
    density_offset=0, n_sim = 2000, m_args=(), t_range, kwargs...)
    n_subplots = n_options(d)
    choices, rts = rand(d, n_sim, m_args...)
    choice_probs = map(c -> mean(choices .== c), 1:n_subplots)
    kdes = [kernel(rts[choices .== c]) for c ∈ 1:n_subplots]
    pds = gen_pds(kdes, t_range, choice_probs)

    map!(x -> x .+ density_offset, pds, pds)
    ymax = maximum(vcat(pds...)) * 1.2
    defaults = get_plot_defaults(n_subplots)
    return plot!(cur_plot, t_range, pds; ylims = (0,ymax), defaults..., kwargs...)
end

function gen_pds(d::SSM2D, t_range, n_subplots)
    return [pdf.(d, (i,), t_range) for i ∈ 1:n_subplots]
end

function gen_pds(d::SSM1D, t_range, n_subplots)
    return [pdf.(d, t_range) for i ∈ 1:n_subplots]
end

function gen_pds(kdes, t_range, probs)
    return [pdf(kdes[i], t_range) .* probs[i] for i ∈ 1:length(kdes)]
end

function default_range(d)
    n = n_options(d)
    return range(d.τ + eps(), d.τ+ .25 * log(n + 1), length=100)
end

function get_plot_defaults(n_subplots)
    title = ["choice $i" for _ ∈ 1:1,  i ∈ 1:n_subplots]
    return (xlabel=("RT [s]"), ylabel = "density", grid=false,
        linewidth = 1.5, color = :black, leg=false, title,
         layout=(n_subplots,1))
end