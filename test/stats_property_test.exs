
# property-based testing:
# The sum of a list containing a single value should be that value.

# The count function should never return a negative number.

# If we multiply the results returned by count and average, it should equal the result returned by sum (allowing for a little rounding)


defmodule StatsPropertyTest do
  use ExUnit.Case
  use ExUnitProperties

  describe "Stats on lists of ints" do

    property "single element lists are their own sum" do
      check all number <- integer() do
        assert Stats.sum([number]) == number
      end
    end

    property "count not negative" do
      check all l <- list_of(integer()) do
        assert Stats.count(l) >= 0
      end
    end

    # below test fails when l is []
    property "sum equals average times count " do
      check all l <- list_of(integer()) do
        assert_in_delta(
          Stats.sum(l),
          Stats.count(l) * Stats.average(l),
          1.0e-6
        )
      end
    end

    # it is a bug in our Stats module, but if we want to treat it
    # as boundary condition thats the tests should avoid.
    # Below way tell the test to SKIP generated values that fail to meet a condition.
    property "sum equals average times count (non-empty)" do
      check all l <- list_of(integer()) |> nonempty do
        assert_in_delta(
          Stats.sum(l),
          Stats.count(l) * Stats.average(l),
          1.0e-6
        )
      end
    end

    # A second approach is to prevent the generator from creating empty lists in the first place.
    # This uses the min_length option.
    property "sum equals average times count (min_length)" do
      check all l <- list_of(integer(), min_length: 1) do
        assert_in_delta(
          Stats.sum(l),
          Stats.count(l)*Stats.average(l),
          1.0e-6
        )
      end
    end

  end
end
