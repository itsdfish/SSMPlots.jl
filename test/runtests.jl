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
end
