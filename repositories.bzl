load("@bazel_gazelle//:deps.bzl", "go_repository")

def go_repositories():
    go_repository(
        name = "co_honnef_go_tools",
        importpath = "honnef.co/go/tools",
        sum = "h1:LyX67rVB0kBUFoROrQfzKwdrYLH1cRzHibxdJW85J1c=",
        version = "v0.0.0-20180920025451-e3ad64cb4ed3",
    )
    go_repository(
        name = "com_github_99designs_gqlgen",
        importpath = "github.com/99designs/gqlgen",
        sum = "h1:ddDBXpyQAA0mhSdIC9kQ1xI/fHPuPyJfl1Sd1lTtQZg=",
        version = "v0.7.2",
    )
    go_repository(
        name = "com_github_agnivade_levenshtein",
        importpath = "github.com/agnivade/levenshtein",
        sum = "h1:3oJU7J3FGFmyhn8KHjmVaZCN5hxTr7GxgRue+sxIXdQ=",
        version = "v1.0.1",
    )
    go_repository(
        name = "com_github_andreyvit_diff",
        importpath = "github.com/andreyvit/diff",
        sum = "h1:bvNMNQO63//z+xNgfBlViaCIJKLlCJ6/fmUseuG0wVQ=",
        version = "v0.0.0-20170406064948-c7f18ee00883",
    )
    go_repository(
        name = "com_github_beorn7_perks",
        importpath = "github.com/beorn7/perks",
        sum = "h1:xJ4a3vCFaGF/jqvzLMYoU8P317H5OQ+Via4RmuPwCS0=",
        version = "v0.0.0-20180321164747-3a771d992973",
    )
    go_repository(
        name = "com_github_client9_misspell",
        importpath = "github.com/client9/misspell",
        sum = "h1:ta993UF76GwbvJcIo3Y68y/M3WxlpEHPWIGDkJYwzJI=",
        version = "v0.3.4",
    )
    go_repository(
        name = "com_github_davecgh_go_spew",
        importpath = "github.com/davecgh/go-spew",
        sum = "h1:ZDRjVQ15GmhC3fiQ8ni8+OwkZQO4DARzQgrnXU1Liz8=",
        version = "v1.1.0",
    )
    go_repository(
        name = "com_github_ghodss_yaml",
        importpath = "github.com/ghodss/yaml",
        sum = "h1:wQHKEahhL6wmXdzwWG11gIVCkOv05bNOh+Rxn0yngAk=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_go_kit_kit",
        importpath = "github.com/go-kit/kit",
        sum = "h1:Wz+5lgoB0kkuqLEc6NVmwRknTKP6dTGbSqvhZtBI/j0=",
        version = "v0.8.0",
    )
    go_repository(
        name = "com_github_golang_glog",
        importpath = "github.com/golang/glog",
        sum = "h1:VKtxabqXZkF25pY9ekfRL6a582T4P37/31XEstQ5p58=",
        version = "v0.0.0-20160126235308-23def4e6c14b",
    )
    go_repository(
        name = "com_github_golang_lint",
        importpath = "github.com/golang/lint",
        sum = "h1:2hRPrmiwPrp3fQX967rNJIhQPtiGXdlQWAxKbKw3VHA=",
        version = "v0.0.0-20180702182130-06c8688daad7",
    )
    go_repository(
        name = "com_github_golang_mock",
        importpath = "github.com/golang/mock",
        sum = "h1:28o5sBqPkBsMGnC6b4MvE2TzSr5/AT4c/1fLqVGIwlk=",
        version = "v1.2.0",
    )
    go_repository(
        name = "com_github_golang_protobuf",
        importpath = "github.com/golang/protobuf",
        sum = "h1:P3YflyNX/ehuJFLhxviNdFxQPkGK5cDcApsge1SqnvM=",
        version = "v1.2.0",
    )
    go_repository(
        name = "com_github_google_go_cmp",
        importpath = "github.com/google/go-cmp",
        sum = "h1:+dTQ8DZQJz0Mb/HjFlkptS1FeQ4cWSnN941F8aEG4SQ=",
        version = "v0.2.0",
    )
    go_repository(
        name = "com_github_gorilla_websocket",
        importpath = "github.com/gorilla/websocket",
        sum = "h1:WDFjx/TMzVgy9VdMMQi2K2Emtwi2QcUQsztZ/zLaH/Q=",
        version = "v1.4.0",
    )
    go_repository(
        name = "com_github_grpc_ecosystem_grpc_gateway",
        importpath = "github.com/grpc-ecosystem/grpc-gateway",
        sum = "h1:8KyC64BiO8ndiGHY5DlFWWdangUPC9QHPakFRre/Ud0=",
        version = "v1.6.2",
    )
    go_repository(
        name = "com_github_hashicorp_golang_lru",
        importpath = "github.com/hashicorp/golang-lru",
        sum = "h1:CL2msUPvZTLb5O648aiLNJw3hnBxN2+1Jq8rCOH9wdo=",
        version = "v0.5.0",
    )
    go_repository(
        name = "com_github_kisielk_gotool",
        importpath = "github.com/kisielk/gotool",
        sum = "h1:AV2c/EiW3KqPNT9ZKl07ehoAGi4C5/01Cfbblndcapg=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_kr_pretty",
        importpath = "github.com/kr/pretty",
        sum = "h1:L/CwN0zerZDmRFUapSPitk6f+Q3+0za1rQkzVuMiMFI=",
        version = "v0.1.0",
    )
    go_repository(
        name = "com_github_kr_pty",
        importpath = "github.com/kr/pty",
        sum = "h1:VkoXIwSboBpnk99O/KFauAEILuNHv5DVFKZMBN/gUgw=",
        version = "v1.1.1",
    )
    go_repository(
        name = "com_github_kr_text",
        importpath = "github.com/kr/text",
        sum = "h1:45sCR5RtlFHMR4UwH9sdQ5TC8v0qDQCHnXt+kaKSTVE=",
        version = "v0.1.0",
    )
    go_repository(
        name = "com_github_matttproud_golang_protobuf_extensions",
        importpath = "github.com/matttproud/golang_protobuf_extensions",
        sum = "h1:4hp9jkHxhMHkqkrB3Ix0jegS5sx/RkqARlsWZ6pIwiU=",
        version = "v1.0.1",
    )
    go_repository(
        name = "com_github_mishudark_errors",
        importpath = "github.com/mishudark/errors",
        sum = "h1:GrgbFS8KSGgSqsMbLod+cg9b/rHhaIvp/LFayLtDtio=",
        version = "v0.0.0-20190221111348-b16f7e94bb58",
    )
    go_repository(
        name = "com_github_openzipkin_zipkin_go",
        importpath = "github.com/openzipkin/zipkin-go",
        sum = "h1:36hTtUTQR/vPX7YVJo2PYexSbHdAJiAkDrjuXw/YlYQ=",
        version = "v0.1.3",
    )
    go_repository(
        name = "com_github_pmezard_go_difflib",
        importpath = "github.com/pmezard/go-difflib",
        sum = "h1:4DBwDE0NGyQoBHbLQYPwSUPoCMWR5BEzIk/f1lZbAQM=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_prometheus_client_golang",
        importpath = "github.com/prometheus/client_golang",
        sum = "h1:awm861/B8OKDd2I/6o1dy3ra4BamzKhYOiGItCeZ740=",
        version = "v0.9.2",
    )
    go_repository(
        name = "com_github_prometheus_client_model",
        importpath = "github.com/prometheus/client_model",
        sum = "h1:idejC8f05m9MGOsuEi1ATq9shN03HrxNkD/luQvxCv8=",
        version = "v0.0.0-20180712105110-5c3871d89910",
    )
    go_repository(
        name = "com_github_prometheus_common",
        importpath = "github.com/prometheus/common",
        sum = "h1:z6tvbDJ5OLJ48FFmnksv04a78maSTRBUIhkdHYV5Y98=",
        version = "v0.0.0-20181218105931-67670fe90761",
    )
    go_repository(
        name = "com_github_prometheus_procfs",
        importpath = "github.com/prometheus/procfs",
        sum = "h1:9a8MnZMP0X2nLJdBg+pBmGgkJlSaKC2KaQmTCk1XDtE=",
        version = "v0.0.0-20181204211112-1dc9a6cbc91a",
    )
    go_repository(
        name = "com_github_sergi_go_diff",
        importpath = "github.com/sergi/go-diff",
        sum = "h1:Kpca3qRNrduNnOQeazBd0ysaKrUJiIuISHxogkT9RPQ=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_stretchr_objx",
        importpath = "github.com/stretchr/objx",
        sum = "h1:4G4v2dO3VZwixGIRoQ5Lfboy6nUhCyYzaqnIAPPhYs4=",
        version = "v0.1.0",
    )
    go_repository(
        name = "com_github_stretchr_testify",
        importpath = "github.com/stretchr/testify",
        sum = "h1:TivCn/peBQ7UY8ooIcPgZFpTNSz0Q2U6UrFlUfqbe0Q=",
        version = "v1.3.0",
    )
    go_repository(
        name = "com_github_vektah_gqlparser",
        importpath = "github.com/vektah/gqlparser",
        sum = "h1:0bZ+joDoDD429K9vTZntnLQZ8gjEdKlmiuuNpyewLfI=",
        version = "v1.1.1",
    )
    go_repository(
        name = "com_google_cloud_go",
        importpath = "cloud.google.com/go",
        sum = "h1:eOI3/cP2VTU6uZLDYAoic+eyzzB9YyGmJ7eIjl8rOPg=",
        version = "v0.34.0",
    )
    go_repository(
        name = "in_gopkg_check_v1",
        importpath = "gopkg.in/check.v1",
        sum = "h1:qIbj1fsPNlZgppZ+VLlY7N33q108Sa+fhmuc+sWQYwY=",
        version = "v1.0.0-20180628173108-788fd7840127",
    )
    go_repository(
        name = "in_gopkg_yaml_v2",
        importpath = "gopkg.in/yaml.v2",
        sum = "h1:ZCJp+EgiOT7lHqUV2J862kp8Qj64Jo6az82+3Td9dZw=",
        version = "v2.2.2",
    )
    go_repository(
        name = "io_opencensus_go",
        importpath = "go.opencensus.io",
        sum = "h1:+jrnNy8MR4GZXvwF9PEuSyHxA4NaTf6601oNRwCSXq0=",
        version = "v0.19.0",
    )
    go_repository(
        name = "org_apache_git_thrift_git",
        importpath = "git.apache.org/thrift.git",
        sum = "h1:GnKpWvJXysBGdcWMEibN//UeRRJeLDUgsXjKXjagFLg=",
        version = "v0.0.0-20181218151757-9b75e4fe745a",
    )
    go_repository(
        name = "org_golang_google_api",
        importpath = "google.golang.org/api",
        sum = "h1:iQMS7JKv/0w/iiWf1M49Cg3dmOkBoBZT5KheqPDpaac=",
        version = "v0.0.0-20181220000619-583d854617af",
    )
    go_repository(
        name = "org_golang_google_appengine",
        importpath = "google.golang.org/appengine",
        sum = "h1:FBSsiFRMz3LBeXIomRnVzrQwSDj4ibvcRexLG0LZGQk=",
        version = "v1.3.0",
    )
    go_repository(
        name = "org_golang_google_genproto",
        importpath = "google.golang.org/genproto",
        sum = "h1:dQshZyyJ5W/Xk8myF4GKBak1pZW6EywJuQ8+44EQhGA=",
        version = "v0.0.0-20181219182458-5a97ab628bfb",
    )
    go_repository(
        name = "org_golang_google_grpc",
        importpath = "google.golang.org/grpc",
        sum = "h1:TRJYBgMclJvGYn2rIMjj+h9KtMt5r1Ij7ODVRIZkwhk=",
        version = "v1.17.0",
    )
    go_repository(
        name = "org_golang_x_lint",
        importpath = "golang.org/x/lint",
        sum = "h1:rJm0LuqUjoDhSk2zO9ISMSToQxGz7Os2jRiOL8AWu4c=",
        version = "v0.0.0-20181217174547-8f45f776aaf1",
    )
    go_repository(
        name = "org_golang_x_net",
        importpath = "golang.org/x/net",
        sum = "h1:iCzOf0xz39Tstp+Tu/WwyGjUXCk34QhQORRxBeXXTA4=",
        version = "v0.0.0-20181217023233-e147a9138326",
    )
    go_repository(
        name = "org_golang_x_oauth2",
        importpath = "golang.org/x/oauth2",
        sum = "h1:uESlIz09WIHT2I+pasSXcpLYqYK8wHcdCetU3VuMBJE=",
        version = "v0.0.0-20181203162652-d668ce993890",
    )
    go_repository(
        name = "org_golang_x_sync",
        importpath = "golang.org/x/sync",
        sum = "h1:Bl/8QSvNqXvPGPGXa2z5xUTmV7VDcZyvRZ+QQXkXTZQ=",
        version = "v0.0.0-20181108010431-42b317875d0f",
    )
    go_repository(
        name = "org_golang_x_sys",
        importpath = "golang.org/x/sys",
        sum = "h1:MXtOG7w2ND9qNCUZSDBGll/SpVIq7ftozR9I8/JGBHY=",
        version = "v0.0.0-20181218192612-074acd46bca6",
    )
    go_repository(
        name = "org_golang_x_text",
        importpath = "golang.org/x/text",
        sum = "h1:g61tztE5qeGQ89tm6NTjjM9VPIm088od1l6aSorWRWg=",
        version = "v0.3.0",
    )
    go_repository(
        name = "org_golang_x_tools",
        importpath = "golang.org/x/tools",
        sum = "h1:iZgcI2DDp6zW5v9Z/5+f0NuqoxNdmzg4hivjk2WLXpY=",
        version = "v0.0.0-20190125232054-d66bd3c5d5a6",
    )
