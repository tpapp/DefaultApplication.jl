
# Tests for WSL and Windows issues #20 and #22
# (https://github.com/tpapp/DefaultApplication.jl/pull/21)
#
# Not run automatically, yet

cd(dirname(@__DIR__))

using DefaultApplication

link = "https://google.com/#" * ("x"^8200)
DefaultApplication.open(link)
DefaultApplication.open("README.md")
