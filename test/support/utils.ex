defmodule TinyEVMT.Utils do
  def hex_to_int(string) do
    string
    |> hex_to_binary()
    |> :binary.decode_unsigned()
  end

  def hex_to_binary(string) do
    string
    |> String.slice(2..-1)
    |> Base.decode16!(case: :mixed)
  end
end
