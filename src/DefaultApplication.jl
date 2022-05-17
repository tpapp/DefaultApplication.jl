module DefaultApplication

import InteractiveUtils

# based on https://stackoverflow.com/questions/38086185/
const _is_wsl = Sys.islinux() &&
    let osrelease = "/proc/sys/kernel/osrelease"
        isfile(osrelease) && occursin(r"microsoft|wsl"i, read(osrelease, String))
    end

"""
    DefaultApplication.open(filename; wait = false)

Open a file with the default application determined by the OS.

The argument `wait` is passed to `run`.
"""
function open(filename; wait = false)
    @static if Sys.isapple()
        run(`open $(filename)`; wait = wait)
    elseif _is_wsl
        # Powershell can open *relative* paths in WSL, hence basename/dirname here.
        # Could use wslview instead, but powershell is more universally available.
        # Could use cmd + wslpath instead, but cmd complains about the working directory.
        # Quotes around the filename are to deal with spaces.
        realfile = realpath(filename)
        dir = dirname(realfile)
        base = basename(realfile)
        cmd = `powershell.exe -NoProfile -NonInteractive -Command start \"$(base)\"`
        run(Cmd(cmd; dir = dir); wait = wait)
    elseif Sys.islinux() || Sys.isbsd()
        run(`xdg-open $(filename)`; wait = wait)
    elseif Sys.iswindows()
        cmd = get(ENV, "COMSPEC", "cmd.exe")
        run(`$(cmd) /c start $(filename)`; wait = wait)
    else
        @warn("Opening files the default application is not supported on this OS.",
              KERNEL = Sys.KERNEL)
    end
end

"""
    DefaultApplication.test()

Helper function that creates text file, attempts to open it with the OS-specific
default application, and prints information that helps with debugging.
"""
function test()
    path = tempname() * ".txt"
    write(path, "some text, should be opened in a text editor")
    @info("opening text file with the default application",
          path = path)
    @info("""
        If the file was not opened, please copy the output and open an issue at
        https://github.com/tpapp/DefaultApplication.jl/issues
        """)
    InteractiveUtils.versioninfo(stdout; verbose = true)
    if Sys.iswindows()
        @info("Version information for windows",
              windows_version = Sys.windows_version())
    end
    DefaultApplication.open(path)
end

end # module
