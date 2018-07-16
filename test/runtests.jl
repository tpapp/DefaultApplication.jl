using Test
import DefaultApplication

TRAVIS = get(ENV, "TRAVIS", "false") == "true"

# Test that a text file is opened by Emacs, the default editor. This is
# accomplished by checking the output of `ps`.

if Sys.islinux()
    if TRAVIS
        testfile = "/tmp/test.txt"
        write(testfile, "test text")
        @info("environment", EDITOR = get(ENV, "EDITOR", "(undefined)"))
        @test !isfile(sentinelfile)
        @info "opening $(testfile)"
        DefaultApplication.open(testfile)
        @info "emacs should now be running"
        @test occursin("emacs", read(`ps -e`, String))
    else
        @warn "Tests are only ran in Travis VM."
    end
end
