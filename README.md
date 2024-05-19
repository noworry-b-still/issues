# Issues

**Issues** is an Elixir-based command-line tool that fetches issues from the GitHub API and presents them in a formatted way. This tool allows you to quickly see the latest issues for a given GitHub repository in a clean and organized table format.

## Installation

### Prerequisites

Ensure you have Elixir installed on your machine. You can download and install Elixir from [the official website](https://elixir-lang.org/install.html).

### Building the Executable

To build the executable, you can use the `mix escript.build` command. This will generate an executable named `issues` in the root of your project.

**Note:** The "issues" executable is already present in the root directory. You can execute it directly without the need to build it using `mix escript.build`. This executable is designed to run on any system that is based on Unix.

```sh
❯ mix escript.build


❯ ./issues eddiejaoude eddiejaoude 4
num | created_at | title
----+----------------------+-------------------------------------------------------------
143 | 2023-10-18T16:57:25Z | [BUG] blog-post-bot GitHub action workflow Triggering issue.
144 | 2023-10-18T17:15:07Z | Fixed Issue #143 Workflow Trigger Bug
145 | 2023-10-19T04:58:52Z | Add Achievements Section to README.md
146 | 2024-01-08T08:16:10Z | Update bug.yml

❯ ./issues edgurgel httpoison

num | created_at | title
----+----------------------+--------------------------------------------------------------------------------------
485 | 2024-01-19T13:36:23Z | Issue Case clause error
486 | 2024-02-13T18:30:38Z | Multipart content based post failing if the file name contains space or () characters
487 | 2024-04-09T02:24:45Z | Add validations for options
488 | 2024-05-12T19:23:43Z | fix syntax in readme multipart example

❯ ./issues edgurgel httpoison 10

num | created_at | title
----+----------------------+--------------------------------------------------------------------------------------------------
462 | 2022-09-01T15:56:53Z | Proxy option not working
467 | 2022-11-17T22:08:28Z | Overly loose typespecs
468 | 2022-12-27T12:57:30Z | HTTPoison.get! follow_redirect does not work with an async request
474 | 2023-04-07T09:30:31Z | How to contribute
475 | 2023-04-08T13:21:19Z | ipv6 localhost address is passed to hackney without square brackets
483 | 2023-11-15T07:56:20Z | Get HTTPoison.Error{reason: {:options, :dependency}} when send request with settings for tlsv1.3
485 | 2024-01-19T13:36:23Z | Issue Case clause error
486 | 2024-02-13T18:30:38Z | Multipart content based post failing if the file name contains space or () characters
487 | 2024-04-09T02:24:45Z | Add validations for options
488 | 2024-05-12T19:23:43Z | fix syntax in readme multipart example
```
