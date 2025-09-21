defmodule Chapter4.AgentExamplesTest do
  use ExUnit.Case

  alias Chapter4.AgentExamples.KV

  test "agent kv store" do
    {:ok, _} = KV.start_link()
    assert :ok == KV.put(:x, 9)
    assert 9 == KV.get(:x)
    assert %{x: 9} == KV.all()
  end
end
