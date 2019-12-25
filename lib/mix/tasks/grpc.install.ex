defmodule Mix.Tasks.Grpc.Install do
  use Mix.Task

  def run(args) do
    grpc_path = Enum.at(args, 0)
    File.mkdir_p("./lib/grpc")

    {_, 0} =
      System.cmd(
        "/bin/sh",
        ["-c", "protoc --elixir_out=plugins=grpc:../lib/grpc *.proto"],
        cd: grpc_path
      )
  end
end
