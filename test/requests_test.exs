defmodule RequestsTest do
  use ExUnit.Case

  test "Ping" do
    request = Sphero.Request.Ping.new seq: 0
    expected_bytes = <<255, 255, 0, 1, 0, 1, 253>>
    assert expected_bytes == Sphero.Request.to_string(request)
  end

  test "Sleep" do
    request = Sphero.Request.Sleep.new seq: 0, wakeup: 0, macro: 0
    expected_bytes = <<255, 255, 0, 0, 0, 4, 0, 0, 0, 251>>
    assert 0x04 == Sphero.Request.dlen(request.data)
    assert expected_bytes == Sphero.Request.to_string(request)
  end

  test "GetVersioning" do
    request = Sphero.Request.GetVersioning.new seq: 0
    expected_bytes = <<255, 255, 0, 2, 0, 1, 252>>
    assert expected_bytes == Sphero.Request.to_string(request)
  end

  test "GetBluetoothInfo" do
    request = Sphero.Request.GetBluetoothInfo.new seq: 0
    expected_bytes = <<255, 255, 0, 11, 0, 1, 243>>
    assert expected_bytes == Sphero.Request.to_string(request)
  end

  test "SetAutoReconnect" do
    request = Sphero.Request.SetAutoReconnect.new seq: 0
    expected_bytes = <<255, 255, 0, 12, 0, 1, 242>>
    assert expected_bytes == Sphero.Request.to_string(request)
  end

  test "GetAutoReconnect" do
    request = Sphero.Request.GetAutoReconnect.new seq: 0
    expected_bytes = <<255, 255, 0, 13, 0, 1, 241>>
    assert expected_bytes == Sphero.Request.to_string(request)
  end

  test "GetPowerState" do
    request = Sphero.Request.GetPowerState.new seq: 0
    expected_bytes = <<255, 255, 0, 20, 0, 1, 234>>
    assert expected_bytes == Sphero.Request.to_string(request)
  end
end
