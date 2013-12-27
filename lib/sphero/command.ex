defmodule Sphero.Command do
  def new([seq: seq, data: data, cid: cid]) do
    Sphero.Request.new(seq: seq, data: data, cid: cid, did: <<2>>)
  end
end

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
    Sphero.Command.new(seq: seq, data: data, cid: <<32>>)
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
