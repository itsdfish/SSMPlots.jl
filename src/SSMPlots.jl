module SSMPlots
    using SequentialSamplingModels
    using SequentialSamplingModels: Approximate
    using SequentialSamplingModels: Exact
    using SequentialSamplingModels: get_pdf_type
    using KernelDensity
    using Plots 

    import Plots: histogram
    import Plots: histogram!
    import Plots: plot
    import Plots: plot! 

    export histogram
    export histogram!
    export plot
    export plot! 

    include("kde.jl")
    include("functions.jl")

end
