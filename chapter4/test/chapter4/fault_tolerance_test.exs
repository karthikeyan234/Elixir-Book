defmodule Chapter4.FaultToleranceTest do
  use ExUnit.Case

  alias Chapter4.FaultTolerance

  test "trap exit example" do
    assert :trapped == FaultTolerance.trap_exit_example()
  end

  test "monitor example" do
    assert :down_normal == FaultTolerance.monitor_example()
  end

  test "link example returns tuple and may crash without trap (documentation sample)" do
    # Just assert the return shape from function prior to linked crash comment
    assert {pid, :linked} = FaultTolerance.link_example()
    assert is_pid(pid)
  end
end
