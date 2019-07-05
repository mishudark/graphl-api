#!/bin/bash
bazel_external_uris="https://mirror.bazel.build/openjdk/azul-zulu11.2.3-jdk11.0.1/zulu11.2.3-jdk11.0.1-linux_x64.tar.gz
https://mirror.bazel.build/bazel_java_tools/releases/javac11/v2.0/java_tools_javac11_linux-v2.0.zip
https://mirror.bazel.build/bazel_coverage_output_generator/releases/coverage_output_generator-v1.0.zip
https://github.com/bazelbuild/bazel-gazelle/releases/download/0.17.0/bazel-gazelle-0.17.0.tar.gz
https://github.com/bazelbuild/rules_docker/archive/v0.8.1.tar.gz
https://github.com/bazelbuild/rules_go/releases/download/0.18.6/rules_go-0.18.6.tar.gz
"

load_distfiles() {
	# populate the bazel distdir to fetch from since it cannot use the network
	local uri

	while read uri; do
		[[ -z "$uri" ]] && continue
		wget $uri
	done <<< "${bazel_external_uris}"
}

load_distfiles
