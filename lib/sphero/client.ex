defrecord Sphero.Client.State, device: nil, seq: nil

defmodule Sphero.Client do
  use ExActor

  defcall ping, state: state do
    # send the command
    do_request(Sphero.Request.Ping.new(seq: state.seq), state)
  end

  defcall set_rgb(red, green, blue), state: state do
    # send the command
    persistent = 0
    do_request(Sphero.Command.SetRGB.new(seq: state.seq, data: <<red, green, blue, persistent>>), state)
  end

  definit device do
    device = :serial.start([speed: 115200, open: bitstring_to_list(device)])
    Sphero.Client.State.new(device: device, seq: 0)
  end

  defp do_request(request, state) do
    request_bytes = Sphero.Request.to_string(request)
    IO.inspect request_bytes
    state.device <- {:send, request_bytes}
    # receive 5 integers FIXME: Only doing 1 right now
    response = receive do
      {:data, data} -> IO.inspect data
    end
    # update the seq
    state = state.seq(state.seq + 1)
    set_and_reply(state, :ok)
  end
end
