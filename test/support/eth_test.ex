defmodule TinyEVM.EthTest do
  defstruct [:input, :output]

  alias TinyEVM.EthTest.{Input, Output}

  defmodule Input do
    import TinyEVMT.Utils

    defstruct [:gas, :code, :address]

    def new(json_test) do
      %__MODULE__{
        gas: hex_to_int(json_test["exec"]["gas"]),
        code: hex_to_binary(json_test["exec"]["code"]),
        address: json_test["exec"]["address"]
      }
    end
  end

  defmodule Output do
    import TinyEVMT.Utils

    defstruct [:gas, :storage]

    def new(json_test) do
      storage =
        json_test["post"]
        |> Enum.map(fn {address, data} ->
          formatted_storage = format_storage(data["storage"])

          {address, formatted_storage}
        end)
        |> Enum.into(%{})

      %__MODULE__{
        gas: hex_to_int(json_test["gas"]),
        storage: storage
      }
    end

    defp format_storage(storage) do
      for {key, value} <- storage, into: %{} do
        {hex_to_int(key), hex_to_int(value)}
      end
    end
  end

  def new(json_test) do
    json_test
    |> Enum.map(fn {_key, value} ->
      input = Input.new(value)
      output = Output.new(value)

      %__MODULE__{
        input: input,
        output: output
      }
    end)
    |> List.first()
  end

  def read(path) do
    path
    |> File.open!()
    |> IO.read(:all)
    |> Poison.decode!()
    |> new()
  end
end
