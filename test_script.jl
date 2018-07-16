using Pkg
Pkg.activate(".")
Pkg.build()
Pkg.test(; coverage=true)
