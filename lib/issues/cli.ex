defmodule Issues.CLI do
  @default_count 4

  @moduledoc """
  Handle the command line parsing and the dispatch to other functions
  """

  def run(argv) do
    argv
    |> parse_args
    |> process
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

  def process(:help) do
    IO.puts """
    usage: issues <user> <project> [ count ]
    """
  end

  def process({user, project, _count}) do
    Issues.GithubIssues.fetch(user, project)
    |> decode_response
  end

  defp decode_response({:error, error}) do
    IO.puts "Error fetching from Github: #{error}"
    System.halt 2
  end

  defp decode_response({:ok, body}), do: body
end
