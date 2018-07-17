module DefaultApplication

"""
    DefaultApplication.open(filename; wait = false)

Open a file with the default application determined by the OS.

The argument `wait` is passed to `run`.
"""
function open(filename; wait = false)
    @static if Sys.isapple()
        run(`open $(filename)`; wait = wait)
    elseif Sys.islinux() || Sys.isbsd()
        run(`xdg-open $(filename)`; wait = wait)
    elseif Sys.iswindows()
        cmd = get(ENV, "COMSPEC", "cmd")
        run(`$(ENV["COMSPEC"]) /c start $(filename)`; wait = wait)
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
    versioninfo()
    if Sys.iswindows()
        @info("Version information for windows",
              windows_version = Sys.windows_version())
    end
    DefaultApplication.open(path)
end

end # module
