defrecord Sphero.Request.Ping, seq: nil, data: "", did: "\x00", cid: "\x01"

defmodule Sphero.Request do
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
    ""
  end

  defp header(request) do
    IO.inspect request.seq
    sop1 <>
    sop2 <>
    request.did <>
    request.cid <>
    request.seq <>
    :erlang.list_to_binary([dlen(request.data)])
  end

  defp sop1, do: "\xFF"
  defp sop2, do: "\xFF"

  defp dlen(data) do
    byte_size(data) + 1
  end
end

defmodule RequestsTest do
  use ExUnit.Case

  test "ping checksum" do
    ping = Sphero.Request.Ping.new seq: "\x00"
    expected_bytes = "\xFF\xFF\x00\x01\x00\x01\xFD"
    assert expected_bytes == Sphero.Request.to_string(ping)
  end
end
