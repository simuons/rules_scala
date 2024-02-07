load("@rules_java//java:defs.bzl", "java_binary")
load(
    "@io_bazel_rules_scala_config//:config.bzl",
    "ENABLE_COMPILER_DEPENDENCY_TRACKING",
    "SCALA_MAJOR_VERSION",
)

SCALAC_DEPS = [
    "//scala/private/toolchain_deps:scala_compile_classpath",
    "//src/java/io/bazel/rulesscala/io_utils",
    "@bazel_tools//src/main/protobuf:worker_protocol_java_proto",
    "@io_bazel_rules_scala//src/java/io/bazel/rulesscala/jar",
    "@io_bazel_rules_scala//src/java/io/bazel/rulesscala/worker",
    "@io_bazel_rules_scala//src/protobuf/io/bazel/rules_scala:diagnostics_java_proto",
    "//src/java/io/bazel/rulesscala/scalac/compileoptions",
    "//src/java/io/bazel/rulesscala/scalac/reporter",
]

DEP_REPORTING_DEPS = ["//third_party/dependency_analyzer/src/main/io/bazel/rulesscala/dependencyanalyzer/compiler:dep_reporting_compiler"] if ENABLE_COMPILER_DEPENDENCY_TRACKING and SCALA_MAJOR_VERSION.startswith("2") else []

java_binary(
    name = "scalac",
    srcs = [
        ":scalac_files",
    ],
    javacopts = [
        "-source 1.8",
        "-target 1.8",
    ],
    main_class = "io.bazel.rulesscala.scalac.ScalacWorker",
    visibility = ["//visibility:public"],
    deps = DEP_REPORTING_DEPS + SCALAC_DEPS,
)

java_binary(
    name = "scalac_bootstrap",
    srcs = [
        ":scalac_files",
    ],
    javacopts = [
        "-source 1.8",
        "-target 1.8",
    ],
    main_class = "io.bazel.rulesscala.scalac.ScalacWorker",
    visibility = ["//visibility:public"],
    deps = SCALAC_DEPS,
)

filegroup(
    name = "scalac_files",
    srcs = [
        "ScalacWorker.java",
        "ScalacInvokerResults.java",
    ] + (
        [
            "ScalacInvoker.java",
            "ReportableMainClass.java",
        ] if SCALA_MAJOR_VERSION.startswith("2") else ["ScalacInvoker3.java"]
    ),
    visibility = ["//visibility:public"],
)

# filegroup or export_files doesn't work because java_binary emits warning about misplaced sources
# packaging sources to srcjar does solve this issue
load("//scala/runtime:bootstrap.bzl", "source_jar")

source_jar(
    name = "scalac_2",
    srcs = [
        "ReportableMainClass.java",
        "ScalacInvoker.java",
        "ScalacInvokerResults.java",
        "ScalacWorker.java",
    ],
    outs = "scalac_2.srcjar",
    visibility = ["//visibility:public"],
)

source_jar(
    name = "scalac_3",
    srcs = [
        "ReportableMainClass.java",
        "ScalacInvoker.java",
        "ScalacInvoker3.java",
    ],
    outs = "scalac_3.srcjar",
    visibility = ["//visibility:public"],
)
