load("@rules_java//java:defs.bzl", "java_library", "java_test")

java_library(
    name = "compileoptions",
    srcs = ["CompileOptions.java"],
    visibility = ["//visibility:public"],
)

java_test(
    name = "CompileOptionsTest",
    srcs = ["CompileOptionsTest.java"],
    test_class = "io.bazel.rulesscala.scalac.compileoptions.CompileOptionsTest",
    deps = [":compileoptions"],
)
