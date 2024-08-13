defmodule Duper.ResultsTest do
  use ExUnit.Case
  alias Duper.Results

  test "can add entries into the results" do
    Results.add_hash_for("path1", 1)
    Results.add_hash_for("path2", 2)
    Results.add_hash_for("path3", 1)
    Results.add_hash_for("path4", 4)
    Results.add_hash_for("path5", 2)
    Results.add_hash_for("path6", 5)

    duplicates = Results.find_duplicates()
    assert length(duplicates) == 2
    assert ~w{path3 path1} in duplicates
    assert ~w{path2 path5} in duplicates
  end
end
