defmodule Sphero.Command.Roll do
  def new([seq: seq, speed: speed, heading: heading, delay: delay]) do
    data = <<speed, heading :: [unsigned, size(16)], delay>>
    Sphero.Command.new(seq: seq, data: data, cid: <<30>>)
  end
end

defmodule Sphero.Command.Heading do
  def new([seq: seq, heading: heading]) do
    data = <<heading :: [unsigned, size(16)]>>
    Sphero.Command.new(seq: seq, data: data, cid: <<1>>)
  end
end

defmodule Sphero.Command.SetBackLEDOutput do
  def new([seq: seq, data: data]) do
    Sphero.Command.new(seq: seq, data: data, cid: <<21>>)
  end
end

defmodule Sphero.Command.SetRotationRate do
  def new([seq: seq, data: data]) do
    Sphero.Command.new(seq: seq, data: data, cid: <<3>>)
  end
end

defmodule Sphero.Command.SetRGB do
  def new([seq: seq, data: data]) do
    Sphero.Command.new(seq: seq, data: data, cid: <<20>>)
  end
end

defmodule Sphero.Command.GetRGB do
  def new([seq: seq, data: data]) do
    Sphero.Command.new(seq: seq, data: data, cid: <<22>>)
  end
end

defmodule Sphero.Command.SetDataStreaming do
  def new([seq: seq, n: n, m: m, mask: mask, pcnt: pcnt, mask2: mask2]) do
    data = <<n :: [unsigned, size(16)], m :: [unsigned, size(16)], mask :: [unsigned, size(32)], pcnt, mask2 :: [unsigned, size(32)]>>
    Sphero.Command.new(seq: seq, data: data, cid: <<12>>)
  end
end

defmodule Sphero.Command.ConfigureCollisionDetection do
  def new([seq: seq, meth: meth, x_t: x_t, y_t: y_t, x_spd: x_spd, y_spd: y_spd, dead: dead]) do
    data = <<meth, x_t, y_t, x_spd, y_spd, dead>>
    Sphero.Command.new(seq: seq, data: data, cid: <<12>>)
  end
end

defmodule Sphero.Command do
  def new([seq: seq, data: data, cid: cid]) do
    Sphero.Request.new(seq: seq, data: data, cid: cid, did: <<2>>)
  end
end

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
    request = Sphero.Command.SetRGB.new seq: 0, data: <<1,2,3>>
    expected_bytes = <<255, 255, 2, 20, 0, 4, 1, 2, 3, 223>>
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
