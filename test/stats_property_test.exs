
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
  end
end
