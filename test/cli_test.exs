defmodule CLITest do
  use ExUnit.Case
  doctest Issues

  import Issues.CLI, only: [parse_args: 1 ]

  test ":help is returned if --help or -h is passed" do
    assert parse_args(["-h"]) == :help
    assert parse_args(["-h", "anything"]) == :help
    assert parse_args(["--help", "anything"]) == :help
  end

  test "return three options" do
    assert parse_args(["mariogmarq", "issues", "10"]) == {"mariogmarq", "issues", 10}
  end

  test "default_count is used when only have 2 options" do
    assert parse_args(["mariogmarq", "issues"]) == {"mariogmarq", "issues", 4}
  end
end
