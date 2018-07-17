using Test
import DefaultApplication

TRAVIS = get(ENV, "TRAVIS", "false") == "true"

# Test that a text file is opened by Emacs, the default editor. This is
# accomplished by checking the output of `ps`.

function isrunning(program; details = false)
    processes = read(`ps axco command`, String)
    if occursin(program, processes)
        true
    else
        if details
            @info("process $(program) not found in processes")
            for p in sort(split(processes, "\n"))
                @info p
            end
        end
        false
    end
end

if Sys.islinux()
    if TRAVIS
        @test !isrunning("links") # check that it is not running accidentally
        testfile = "/tmp/test.html"
        write(testfile, "<html><body><h1>hello world</h1></body><html>")
        @info("environment",
              XDGMIME = chomp(read(`xdg-mime query default text/html`, String)))
        @info "opening $(testfile)"
        DefaultApplication.open(testfile)
        @info "links should now be running"
        @test isrunning("links"; details = true)
    else
        @warn "Tests are only ran in Travis VM."
    end
end
