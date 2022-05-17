using Test
import DefaultApplication

CI = get(ENV, "CI", "false") == "true"

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
        @info "jmacs should now be running"
        @test isrunning("jmacs"; details = true)
    else
        @warn "Tests are only ran in CI."
    end
end
