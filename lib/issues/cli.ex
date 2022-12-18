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
    OptionParser.parse(argv, switches: [help: :boolean], aliases: [h: :help])
    |> elem(1)
    |> args_to_internal_representation()
  end

  defp args_to_internal_representation([user, project]), do: {user, project, @default_count}
  defp args_to_internal_representation([user, project, count]), do: {user, project, String.to_integer count}
  defp args_to_internal_representation(_), do: :help
end
