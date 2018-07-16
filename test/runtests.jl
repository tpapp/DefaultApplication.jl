using Test
import DefaultApplication

TRAVIS = get(ENV, "TRAVIS", "false") == "true"

# Test that a text file is opened by Emacs, the default editor. This is
# accomplished by making emacs write a sentinel value to a file.

if Sys.islinux()
    if TRAVIS
        file = "/tmp/emacs.ran"
        emacsel = expanduser("~/.emacs.el")
        sentinel = "emacs ran"
        write(emacsel, "(append-to-file \"$(sentinel)\" nil \"$(file)\")\n")
        write("/tmp/test.txt", "test text")
        @info("environment",
              EDITOR = get(ENV, "EDITOR", "(undefined)"),
              EMACSEL_PATH = emacsel,
              EMACSEL_CONTENTS = read(emacsel, String))
        @test !isfile(file)
        DefaultApplication.open("/tmp/test.txt")
        @test isfile(file)
        got_sentinel = read(sentinel, String)
        @info "Sentinel" expected = sentinel got = got_sentinel
        @test sentinel == got_sentinel
    else
        @warn "Tests are only ran in Travis VM."
    end
end
