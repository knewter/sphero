defrecord Sphero.Request.Ping, seq: nil, data: "", did: <<0>>, cid: <<1>>

defmodule Sphero.Request do
  use Bitwise, only_operators: true

  def to_string(request) do
    bytes(request)
  end

  defp bytes(request) do
    packet_header(request) <> packet_body(request) <> checksum(request)
  end

  defp packet_header(request) do
    header(request)
  end

  defp packet_body(request) do
    ""
  end

  defp checksum(request) do
    csum = packet_header(request) <> packet_body(request)
             |> :binary.bin_to_list
             |> Enum.drop(2)
             |> sum
             |> rem(256)
    csumval = ~~~csum &&& 255
    <<csumval>>
  end

  defp sum(list), do: sum(list, 0)
  defp sum([head|rest], accum), do: sum(rest, accum + head)
  defp sum([], accum), do: accum

  defp header(request) do
    sop1 <>
    sop2 <>
    request.did <>
    request.cid <>
    request.seq <>
    :erlang.list_to_binary([dlen(request.data)])
  end

  defp sop1, do: <<255>>
  defp sop2, do: <<255>>

  defp dlen(data) do
    byte_size(data) + 1
  end
end

defmodule RequestsTest do
  use ExUnit.Case

  test "ping checksum" do
    ping = Sphero.Request.Ping.new seq: <<0>>
    expected_bytes = <<255, 255, 0, 1, 0, 1, 253>>
    assert expected_bytes == Sphero.Request.to_string(ping)
  end
end
