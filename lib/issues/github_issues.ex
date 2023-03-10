defmodule Issues.GithubIssues do
  @user_agent [{"User-agent", "mariogmarq"}]
  @github_url Application.compile_env(:issues, :github_url)

  def fetch(user, project) do
    issues_url(user, project)
    |> HTTPoison.get(@user_agent)
    |> handle_response()
  end

  def issues_url(user, project) do
    "#{@github_url}/#{user}/#{project}/issues"
  end

  def handle_response({:ok, %{status_code: status, body: body}}) do
    {
      status |> check_for_error(),
      body |> Poison.Parser.parse!()
    }
  end

  defp check_for_error(200), do: :ok
  defp check_for_error(_), do: :error

end
