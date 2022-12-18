defmodule Issues.CLI do
  @default_count 4

  @moduledoc """
  Handle the command line parsing and the dispatch to other functions
  """

  def run(argv) do
    parse_args argv
  end

  @doc """
  `argv` can be -h or --help

  Otherwise it is a github username, project name and a count (optionally)

  It will return `{user, project, count}` or `:help`
  """
  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [help: :boolean], aliases: [h: :help])

    case parse do
      {[help: true], _, _} -> :help
      {_, [user, project], _} -> {user, project, @default_count}
      {_, [user, project, count], _} -> {user, project, count}
      _ -> :help
    end
  end
end
