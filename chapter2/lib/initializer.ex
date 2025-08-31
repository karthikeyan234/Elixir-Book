defmodule Initializer do
  @on_load :init_module

  def init_module do
    IO.puts("Module loaded!")
    :ok
  end
end
