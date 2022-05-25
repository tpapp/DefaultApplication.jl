using Test
import DefaultApplication

CI = get(ENV, "CI", "false") == "true"

if Sys.islinux()
    if CI
        # ensure clean slate
        sentinel = "/tmp/saved-argument"
        rm(sentinel; force = true)
        # set up test file
        testfile = "/tmp/test.txt"
        write(testfile, "test text")
        ## uncomment lines below for debug information
        @info("environment",
              XDGMIMETYPE = chomp(read(`xdg-mime query filetype $(testfile)`, String)),
              XDGMIMEDEFAULT = chomp(read(`xdg-mime query default text/plain`, String)))
        @info "opening $(testfile)"
        DefaultApplication.open(testfile)
        sleep(1)
        @info "test that file was opened"
        @test chomp(read(sentinel, String)) == testfile
    else
        @warn "Tests are only ran in CI."
    end
end
