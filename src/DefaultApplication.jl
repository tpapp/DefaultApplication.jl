module DefaultApplication

"""
    DefaultApplication.open(filename)

Open a file with the default application determined by the OS.
"""
function open(filename)
    @static if Sys.isapple()
        run(`open $(filename)`)
    elseif Sys.islinux() || Sys.isbsd()
        run(`xdg-open $(filename)`)
    elseif Sys.iswindows()
        cmd = get(ENV, "COMSPEC", "cmd")
        run(`$(ENV["COMSPEC"]) /c start $(filename)`)
    else
        @warn("Opening files the default application is not supported on this OS.",
              KERNEL = Sys.KERNEL)
    end
end

end # module
