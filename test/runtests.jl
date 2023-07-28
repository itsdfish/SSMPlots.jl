using SafeTestsets
@safetestset "run plots" begin
    using SSMPlots
    using Test
    using SequentialSamplingModels
    dist = RDM(;ν=[1,2,3], k=.30, A=.70, τ=.20)
    h = histogram(dist)
    plot!(h, dist)
    
    histogram(dist)
    plot!(dist)
    
    plot(dist)
    histogram!(dist)
    
    p = plot(dist)
    histogram!(p, dist)
    
    dist = LCA()
    p = plot(dist; t_range=range(.3, 1.2, length=100))
    histogram!(p, dist)
    
    plot(dist; t_range=range(.3, 1.2, length=100))
    histogram!(dist)
    
    h = histogram(dist)
    plot!(h, dist; t_range=range(.3, 1.2, length=100))
    
    histogram(dist)
    plot!(dist; t_range=range(.3, 1.2, length=100))
    
    dist = Wald(ν=3.0, α=.5, τ=.130)
    h = histogram(dist)
    plot!(h, dist; t_range=range(.130, 1.0, length=100))
    
    histogram(dist)
    plot!(dist; t_range=range(.130, 1.0, length=100))
    
    p = plot(dist; t_range=range(.130, 1.0, length=100))
    histogram!(p, dist)
    
    plot(dist; t_range=range(.130, 1.0, length=100))
    histogram!(dist)

    dist = LBA()
    density_kwargs=(;t_range=range(.3,1.2, length=100),)
    plot_model(dist; add_density=true, n_sim=2, density_kwargs, xlims=(0,1.2))

    dist = LCA()
    density_kwargs=(;t_range=range(.20, 1.50, length=100),)
    plot_model(dist; n_sim=10, add_density=true, density_kwargs, xlims=(0,1.50))
    
    dist = RDM()
    density_kwargs=(;t_range=range(.20, 0.80, length=100),)
    plot_model(dist; n_sim=10, add_density=true, density_kwargs, xlims=(0,0.80))
    
    dist = Wald()
    density_kwargs=(;t_range=range(.2,1.2, length=100),)
    plot_model(dist; add_density=true, n_sim=2, density_kwargs, xlims=(0,1.2))
end
