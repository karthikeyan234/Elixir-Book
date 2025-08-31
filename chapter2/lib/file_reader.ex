defmodule FileReader do
  def read_file(file_path) do
    with {:ok, file} <- File.open(file_path),
         contents <- File.read(file) do
      File.close(file)
      {:ok, contents}
    else
      {:error, reason} -> {:error, reason}
    end
  end
end
