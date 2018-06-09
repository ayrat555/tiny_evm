defmodule TinyEVMTest do
  use ExUnit.Case
  doctest TinyEVM

  alias TinyEVM.EthTest

  @common_tests_path "./test/support/ethereum_common_tests/VMTests/"

  @tests [
    "vmArithmeticTest/mulmod1_overflow4.json",
    "vmPushDupSwapTest/swap14.json",
    "vmBitwiseLogicOperation/xor2.json"
  ]

  test "runs common test" do
    @tests
    |> Enum.map(&read_test_file/1)
    |> Enum.each(fn test ->
      {remaining_gas, storage} = TinyEVM.execute(test.input.address, test.input.gas, test.input.code)

      assert remaining_gas == test.output.gas
      assert test.output.storage[test.input.address] == storage[test.input.address]
    end)
  end

  defp read_test_file(file_name) do
    file_path = @common_tests_path <> file_name

    EthTest.read(file_path)
  end
end
