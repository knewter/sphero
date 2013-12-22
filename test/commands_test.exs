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

defmodule Sphero.Command.SetDataStreaming do
  def new([seq: seq, n: n, m: m, mask: mask, pcnt: pcnt, mask2: mask2]) do
    data = <<n :: [unsigned, size(16)], m :: [unsigned, size(16)], mask :: [unsigned, size(32)], pcnt, mask2 :: [unsigned, size(32)]>>
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

  test "SetDataStreaming" do
    request = Sphero.Command.SetDataStreaming.new seq: 0, n: 1, m: 2, mask: 3, pcnt: 4, mask2: 5
    expected_bytes = <<255, 255, 2, 12, 0, 14, 0, 1, 0, 2, 0, 0, 0, 3, 4, 0, 0, 0, 5, 212>>
    assert expected_bytes == Sphero.Request.to_string(request)
  end
end
