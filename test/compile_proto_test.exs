defmodule CompileProtoTest do
  use ExUnit.Case

  alias Mix.Tasks.Compile.Proto

  setup do
    # Get Mix output sent to the current process to avoid polluting tests.
    Mix.shell(Mix.Shell.Process)

    on_exit fn -> Mix.shell(Mix.Shell.IO) end

    :ok
  end

  test "use default options" do
    result = Proto.run([])

    assert result == :ok
  end

  test "accepts options" do
    options = [
      paths: ["test"],
      dest: Path.expand("test/output"),
      gen_descriptors: true
    ]

    result = Proto.run(options)
    _ = Proto.clean()

    assert result == :ok
  end

  describe ".do_protoc_args/3" do
    test "destdir" do
      s = %Proto.State{opts: %Proto.Options{}}
      args = Proto.do_protoc_args(s, [], "/destdir")

      assert ["--elixir_out=/destdir"] == args
    end
  end
end
