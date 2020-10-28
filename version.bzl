
def _store_bazel_version(repository_ctx):
    bazel_version = native.bazel_version
    repository_ctx.file("BUILD", "exports_files(['def.bzl'])")
    repository_ctx.file("def.bzl", "BAZEL_VERSION='" + bazel_version + "'")

bazel_version = repository_rule(
    implementation = _store_bazel_version,
)
