ExUnit.start()

defmodule StatsTest do
  use ExUnit.Case
  import Stats, only: [sum: 1, count: 1, average: 1]

  test "calculates sum" do
    list = [1, 3, 5, 7, 9]
    assert Stats.sum(list) == 25
  end

  test "calculates count" do
    list = [1, 3, 5, 7, 9]
    assert Stats.count(list) == 5
  end

  test "calculates average" do
    list = [1, 3, 5, 7, 9]
    assert Stats.average(list) == 5
  end
end

defmodule StatsTest2 do
  use ExUnit.Case
  import Stats, only: [sum: 1, count: 1, average: 1]
  describe "Stats on lists on ints " do

    setup do [
      list: [1,3,5,7,9,11],
      sum: 36,
      count: 6
    ]
    end

    test "calculates sum", fixture do
      assert Stats.sum(fixture.list) == fixture.sum
    end

    test "calculates count" do
      assert Stats.count(fixture.list) == fixture.count
    end

    test "calculates average" do
      assert Stats.average(fixture.list) == fixture.sum/fixture.count
    end
  end
end
