using Test
import DefaultApplication

TRAVIS = get(ENV, "TRAVIS", "false") == "true"

# Test that a text file is opened by Emacs, the default editor. This is
# accomplished by making emacs write a sentinel value to a file.

if Sys.islinux()
    if TRAVIS
        sentinel = "emacs ran"
        sentinelfile = "/tmp/emacs.ran"
        testfile = "/tmp/test.txt"
        emacsel = expanduser("~/.emacs.el")
        write(emacsel,
              "(append-to-file \"$(sentinel)\" nil \"$(sentinelfile)\")\n")
        write(testfile, "test text")
        @info("environment",
              EDITOR = get(ENV, "EDITOR", "(undefined)"),
              EMACSEL_PATH = emacsel,
              EMACSEL_CONTENTS = read(emacsel, String))
        @test !isfile(sentinelfile)
        @info "opening $(testfile)"
        DefaultApplication.open(testfile)
        @test isfile(sentinelfile)
        got_sentinel = read(sentinel, String)
        @info "Sentinel" expected = sentinel got = got_sentinel
        @test sentinel == got_sentinel
    else
        @warn "Tests are only ran in Travis VM."
    end
end
