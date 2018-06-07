defmodule TinyEvmTest do
  use ExUnit.Case
  doctest TinyEvm

  @common_tests_path "./test/support/ethereum_common_tests/VMTests/"

  test "runs common test" do
    # test = read_test_file("vmArithmeticTest/sub4.json")

    # TODO: assert test
  end

  defp read_test_file(file_name) do
    {:ok, file} = File.open(@common_tests_path <> file_name)

    file
    |> IO.read(:all)
    |> Poison.decode!()
  end
end
