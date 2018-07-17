using Test
import DefaultApplication

TRAVIS = get(ENV, "TRAVIS", "false") == "true"

# Test that a text file is opened by Emacs, the default editor. This is
# accomplished by checking the output of `ps`.

function isrunning(program; details = false)
    processes = read(`ps axo command`, String)
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
        @test !isrunning("jmacs") # check that it is not running accidentally
        testfile = "/tmp/test.txt"
        write(testfile, "test text")
        @info("environment",
              XDGMIMETYPE = chomp(read(`xdg-mime query filetype $(testfile)`, String)),
              XDGMIMEDEFAULT = chomp(read(`xdg-mime query default text/plain`, String)))
        @info "opening $(testfile)"
        DefaultApplication.open(testfile)
        sleep(5)
        @info "jmacs should now be running"
        @test isrunning("jmacs"; details = true)
    else
        @warn "Tests are only ran in Travis VM."
    end
end
