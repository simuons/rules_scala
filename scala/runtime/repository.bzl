def _scala_runtime(repository_ctx):
    build = """
load("@io_bazel_rules_scala//scala/runtime:bootstrap.bzl", "worker")

worker("scalac", "{version}", ["{compiler}", {library}])

load("@io_bazel_rules_scala//scala/runtime:toolchain.bzl", "runtime")

runtime(
    name = "_runtime",
    version = "{version}",
    compiler = ":scalac",
    library = [{library}],
    visibility = ["//visibility:public"],
)

toolchain(
    name = "runtime",
    toolchain = ":_runtime",
    toolchain_type = "@io_bazel_rules_scala//scala/runtime:toolchain_type",
    visibility = ["//visibility:public"],
)
""".format(
        version = repository_ctx.attr.version,
        compiler = str(repository_ctx.attr.compiler),
        library = _comma_separated_strings(repository_ctx.attr.library),
    )

    repository_ctx.file("BUILD", build)

scala_runtime = repository_rule(
    _scala_runtime,
    attrs = {
        "version": attr.string(),
        "compiler": attr.label(providers = [JavaInfo]),
        "library": attr.label_list(providers = [JavaInfo]),
    },
)

def _comma_separated_strings(values):
    return ", ".join(["\"%s\"" % v for v in values])
