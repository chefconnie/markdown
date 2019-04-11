defmodule Mix.Tasks.Compile.Hoedown do
  def run(_) do
    shell = Mix.shell()

    case match?({:win32, _}, :os.type()) do
      true -> "nmake /F Makefile.win priv\\markdown.dll"
      _ -> "make priv/markdown.so"
    end
    |> shell.cmd(stderr_to_stdout: true)

    :ok
  end
end

defmodule Markdown.Mixfile do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :markdown,
      version: @version,
      elixir: ">= 0.14.3 and < 2.0.0",
      compilers: [:hoedown] ++ Mix.compilers(),
      deps: deps()
    ]
  end

  def application do
    []
  end

  defp deps do
    [{:hoedown, github: "hoedown/hoedown", app: false}]
  end
end
