module SSMPlots

    using Interpolations
    using KernelDensity
    using LinearAlgebra
    using Plots 

    using KernelDensity: Epanechnikov
    using SequentialSamplingModels
    using SequentialSamplingModels: Approximate
    using SequentialSamplingModels: Exact
    using SequentialSamplingModels: get_pdf_type
    using SequentialSamplingModels: simulate

    import Plots: histogram
    import Plots: histogram!
    import Plots: plot
    import Plots: plot! 

    export histogram
    export histogram!
    export plot
    export plot! 
    export plot_model
    export plot_model!

    const SSMs = SequentialSamplingModels

    include("kde.jl")
    include("plot.jl")
    include("histogram.jl")
    include("plot_model.jl")

end
