using Test
import DefaultApplication

TRAVIS = get(ENV, "TRAVIS", "false") == "true"

# Test that a text file is opened by Emacs, the default editor. This is
# accomplished by checking the output of `ps`.

isemacsrunning() = occursin("emacs", read(`ps -e`, String))

if Sys.islinux()
    if TRAVIS
        @test !isemacsrunning() # check that it is not running accidentally
        testfile = "/tmp/test.txt"
        write(testfile, "test text")
        @info("environment", EDITOR = get(ENV, "EDITOR", "(undefined)"))
        @info "opening $(testfile)"
        DefaultApplication.open(testfile)
        @info "emacs should now be running"
        @test isemacsrunning()
    else
        @warn "Tests are only ran in Travis VM."
    end
end
