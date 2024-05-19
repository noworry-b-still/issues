defmodule Issues.GithubIssues do
  @user_agent [{"User-agent", "Elixir dave@pragprog.com"}]

  # Use a module attribute to fetch the value at compile time
  # @github_url Application.get_env(:issues, :github_url)

  def fetch(user, project) do
    issues_url(user, project)
    |> HTTPoison.get()
    |> handle_response()
  end

  def issues_url(user, project) do
    "https://api.github.com/repos/#{user}/#{project}/issues"
  end

  def handle_response({:ok, %HTTPoison.Response{status_code: 200, body: body}}) do
    {:ok, Poison.Parser.parse!(body)}
  end

  def handle_response({:ok, %HTTPoison.Response{status_code: status_code, body: body}}) do
    {:error, "HTTP Error #{status_code}: #{body}"}
  end

  def handle_response({:error, %HTTPoison.Error{reason: reason}}) do
    {:error, "HTTPoison Error: #{reason}"}
  end
end
