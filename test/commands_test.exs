defmodule CommandsTest do
  use ExUnit.Case

  test "Roll" do
    request = Sphero.Command.Roll.new seq: 0, speed: 1, heading: 2, delay: 3
    expected_bytes = <<255, 255, 2, 30, 0, 5, 1, 0, 2, 3, 212>>
    assert expected_bytes == Sphero.Request.to_string(request)
  end

  test "Heading" do
    request = Sphero.Command.Heading.new seq: 0, heading: 2
    expected_bytes = <<255, 255, 2, 1, 0, 3, 0, 2, 247>>
    assert expected_bytes == Sphero.Request.to_string(request)
  end

  test "SetBackLEDOutput" do
    request = Sphero.Command.SetBackLEDOutput.new seq: 0, data: <<1,2,3>>
    expected_bytes = <<255, 255, 2, 21, 0, 4, 1, 2, 3, 222>>
    assert expected_bytes == Sphero.Request.to_string(request)
  end

  test "SetRotationRate" do
    request = Sphero.Command.SetRotationRate.new seq: 0, data: <<1,2,3>>
    expected_bytes = <<255, 255, 2, 3, 0, 4, 1, 2, 3, 240>>
    assert expected_bytes == Sphero.Request.to_string(request)
  end

  test "SetRGB" do
    request = Sphero.Command.SetRGB.new seq: 0, data: <<1,1,1>>
    expected_bytes = <<255, 255, 2, 20, 0, 4, 1, 1, 1, 226>>
    assert expected_bytes == Sphero.Request.to_string(request)
  end

  test "GetRGB" do
    request = Sphero.Command.GetRGB.new seq: 0, data: <<1,2,3>>
    expected_bytes = <<255, 255, 2, 22, 0, 4, 1, 2, 3, 221>>
    assert expected_bytes == Sphero.Request.to_string(request)
  end

  test "SetDataStreaming" do
    request = Sphero.Command.SetDataStreaming.new seq: 0, n: 1, m: 2, mask: 3, pcnt: 4, mask2: 5
    expected_bytes = <<255, 255, 2, 12, 0, 14, 0, 1, 0, 2, 0, 0, 0, 3, 4, 0, 0, 0, 5, 212>>
    assert expected_bytes == Sphero.Request.to_string(request)
  end

  test "ConfigureCollisionDetection" do
    request = Sphero.Command.ConfigureCollisionDetection.new seq: 0, meth: 1, x_t: 2, y_t: 3, x_spd: 4, y_spd: 5, dead: 6
    expected_bytes = <<255, 255, 2, 12, 0, 7, 1, 2, 3, 4, 5, 6, 213>>
    assert expected_bytes == Sphero.Request.to_string(request)
  end
end
