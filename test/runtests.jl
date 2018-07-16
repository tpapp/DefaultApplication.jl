using Test
import DefaultApplication

TRAVIS = get(ENV, "TRAVIS", "false") == "true"

# Test that a text file is opened by Emacs, the default editor. This is
# accomplished by checking the output of `ps`.

function isemacsrunning(; details = false)
    processes = read(`ps axco command`, String)
    if occursin("emacs", processes)
        true
    else
        if details
            @info("process not found, processes")
            for p in sort(split(processes, "\n"))
                @info p
            end
        end
        false
    end
end

if Sys.islinux()
    if TRAVIS
        @test !isemacsrunning() # check that it is not running accidentally
        testfile = "/tmp/test.txt"
        write(testfile, "test text")
        @info("environment",
              EDITOR = get(ENV, "EDITOR", "(undefined)"),
              EMACSPATH = chomp(read(`which emacs`, String)),
              XDGMIME = chomp(read(`xdg-mime query default text/plain`, String)))
        @info "opening $(testfile)"
        DefaultApplication.open(testfile)
        @info "emacs should now be running"
        # @test isemacsrunning(; details = true)
        @info "open test" output = read(`xdg-open --debug=1 /tmp/test.txt`, String)
    else
        @warn "Tests are only ran in Travis VM."
    end
end
