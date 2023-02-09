using Test
import DefaultApplication

CI = get(ENV, "CI", "false") == "true"

if CI && Sys.islinux()
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
end


path = "blah.txt"
url = "https://julialang.org#params"
path_long = "long_long_man" * "n"^8200

cmd_path = DefaultApplication._open_cmd(path)
cmd_url = DefaultApplication._open_cmd(url)
cmd_path_long = DefaultApplication._open_cmd(path_long)

if Sys.isapple()
    @test cmd_path == `open 'blah.txt'`
    @test cmd_url == `open 'https://julialang.org#params'`
    @test cmd_path_long == `open $path_long`

elseif DefaultApplication._is_wsl
    @test cmd_path == `powershell.exe -NoProfile -NonInteractive -Command start \"'blah.txt'\"`
    @test cmd_url == `powershell.exe -NoProfile -NonInteractive -Command start \"'https://julialang.org#params'\"`
    @test cmd_path_long == `powershell.exe -NoProfile -NonInteractive -Command start \"$(path_long)\"`

elseif Sys.islinux() || Sys.isbsd()
    @test cmd_path == `xdg-open 'blah.txt'`
    @test cmd_url == `xdg-open 'https://julialang.org#params'`
    @test cmd_path_long == `xdg-open $path_long`

elseif Sys.iswindows()
    cmd_exe = get(ENV, "COMSPEC", "cmd.exe")
    @test cmd_path == `$(cmd_exe) /c start 'blah.txt'`
    @test cmd_url == `$(cmd_exe) /c start 'https://julialang.org#params'`
    @test cmd_path_long == `powershell.exe -NoProfile -NonInteractive -Command start \"$(path_long)\"`

else
    @warn "OS not tested"
end
