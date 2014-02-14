defmodule SpheroTest do
  use ExUnit.Case

  test "creating a new sphero client for a given device" do
    {:ok, pid} = Sphero.Client.start("/dev/pts/10")
    assert is_pid(pid)
  end
end
