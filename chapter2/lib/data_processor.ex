defmodule DataProcessor do
  def process(data) do
    with {:ok, step1_result} <- step1(data),
         {:ok, step2_result} <- step2(step1_result),
         {:ok, final_result} <- step3(step2_result) do
      {:ok, final_result}
    else
      {:error, reason} -> handle_error(reason)
    end
  end

  # Stub implementations (replace with your actual logic)
  defp step1(data), do: {:ok, data + 1}
  defp step2(data), do: {:ok, data * 2}
  defp step3(data), do: {:ok, data - 3}

  defp handle_error(reason), do: IO.puts("Error occurred: #{reason}")
end
# iex> DataProcessor.process(5)
# {:ok, 9}
