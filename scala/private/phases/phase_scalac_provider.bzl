#
# PHASE: scalac provider
#
# DOCUMENT THIS
#
load(
    "@io_bazel_rules_scala//scala:providers.bzl",
    _ScalacProvider = "ScalacProvider",
)

def phase_scalac_provider(ctx, p):
    tc = ctx.toolchains["@io_bazel_rules_scala//scala/runtime:toolchain_type"]

    library_classpath = tc.library
    compile_classpath = []
    macro_classpath = tc.library

    return _ScalacProvider(
        default_classpath = library_classpath,
        default_repl_classpath = compile_classpath,
        default_macro_classpath = macro_classpath,
    )
