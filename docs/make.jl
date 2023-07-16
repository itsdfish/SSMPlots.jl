using Documenter
using SSMPlots

makedocs(
    sitename="SSMPlots",
    format=Documenter.HTML(
        assets=[
            asset(
                "https://fonts.googleapis.com/css?family=Montserrat|Source+Code+Pro&display=swap",
                class=:css,
            ),
        ],
        collapselevel=1,
    ),
    modules=[SSMPlots],
    pages=[
        "Home" => "index.md",
        "Examples" => [
            "Basic Example" => "basic_example.md",
            "Custom Layout" => "layout.md",
            "Plot Model" => "plot_model.md",
        ],
        "API" => "api.md",
    ]
)

deploydocs(
    repo="github.com/itsdfish/SSMPlots.jl.git",
)