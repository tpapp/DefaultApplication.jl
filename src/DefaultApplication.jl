module DefaultApplication

import InteractiveUtils

# based on https://stackoverflow.com/questions/38086185/
const _is_wsl = Sys.islinux() && isfile("/proc/sys/kernel/osrelease") &&
    occursin(r"microsoft|wsl"i, read("/proc/sys/kernel/osrelease", String))

"""
    DefaultApplication.open(filename; wait = false)

Open a file with the default application determined by the OS.

The argument `wait` is passed to `run`.
"""
function open(filename; wait = false)
    @static if Sys.isapple()
        run(`open $(filename)`; wait = wait)
    elseif _is_wsl
        # wslview doesn't like absolute paths for some reason, hence basename/dirname here
        absfile = abspath(filename)
        run(Cmd(`wslview $(basename(absfile))`; dir = dirname(absfile)); wait = wait)
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
