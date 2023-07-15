module SSMPlots

    using Interpolations
    using KernelDensity
    using Plots 

    using KernelDensity: Epanechnikov
    using SequentialSamplingModels
    using SequentialSamplingModels: Approximate
    using SequentialSamplingModels: Exact
    using SequentialSamplingModels: get_pdf_type

    import Plots: histogram
    import Plots: histogram!
    import Plots: plot
    import Plots: plot! 

    export histogram
    export histogram!
    export plot
    export plot! 

    include("kde.jl")
    include("plot.jl")
    include("histogram.jl")

end
