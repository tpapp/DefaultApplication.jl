using Test
import DefaultApplication

CI = get(ENV, "CI", "false") == "true"

if Sys.islinux()
    if CI
        # Test that a text file is opened by jmacs (setup in Github Actions).
        @test !isrunning("jmacs") # check that it is not running accidentally
        testfile = "/tmp/test.txt"
        write(testfile, "test text")
        ## uncomment lines below for debug information
        @info("environment",
              XDGMIMETYPE = chomp(read(`xdg-mime query filetype $(testfile)`, String)),
              XDGMIMEDEFAULT = chomp(read(`xdg-mime query default text/plain`, String)))
        @info "opening $(testfile)"
        DefaultApplication.open(testfile)
        sleep(1)
        @info "test that file was opened running"
        @test read("/tmp/saved-argument", String) == testfile
    else
        @warn "Tests are only ran in CI."
    end
end
