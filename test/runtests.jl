using Test
import DefaultApplication

TRAVIS = get(ENV, "TRAVIS", "false") == "true"

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
        # Test that a text file is opened by jmacs (setup in .travis.yml).
        @test !isrunning("jmacs") # check that it is not running accidentally
        testfile = "/tmp/test.txt"
        write(testfile, "test text")
        ## uncomment lines below for debug information
        # @info("environment",
        #       XDGMIMETYPE = chomp(read(`xdg-mime query filetype $(testfile)`, String)),
        #       XDGMIMEDEFAULT = chomp(read(`xdg-mime query default text/plain`, String)))
        @info "opening $(testfile)"
        DefaultApplication.open(testfile)
        sleep(1)
        @info "jmacs should now be running"
        @test isrunning("jmacs"; details = true)
    else
        @warn "Tests are only ran in Travis VM."
    end
end
