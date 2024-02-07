def _runtime(ctx):
    return platform_common.ToolchainInfo(
        compiler = ctx.attr.compiler.files_to_run,
        library = ctx.attr.library,
        version = ctx.attr.version,
    )

runtime = rule(
    _runtime,
    attrs = {
        "compiler": attr.label(executable = True, cfg = "exec", allow_files = True),
        "library": attr.label_list(providers = [JavaInfo]),
        "version": attr.string(),
    },
)
