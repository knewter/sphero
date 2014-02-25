defrecord Sphero.Client.State, device: nil, seq: nil

defmodule Sphero.Client do
  use ExActor.GenServer

  defcall ping, state: state do
    do_request(Sphero.Request.Ping.new(seq: state.seq), state)
  end

  defcall set_rgb(red, green, blue), state: state do
    persistent = 0
    do_request(Sphero.Command.SetRGB.new(seq: state.seq, data: <<red, green, blue, persistent>>), state)
  end

  defcall roll(speed, heading), state: state do
    do_request(Sphero.Command.Roll.new(seq: state.seq, speed: speed, heading: heading, delay: 1), state)
  end

  defcall stop, state: state do
    do_request(Sphero.Command.Roll.new(seq: state.seq, speed: 0, heading: 0, delay: 1), state)
  end

  definit device do
    device = :serial.start([speed: 115200, open: bitstring_to_list(device)])
    initial_state(Sphero.Client.State.new(device: device, seq: 0))
  end

  defp do_request(request, state) do
    request_bytes = Sphero.Request.to_string(request)
    IO.inspect request_bytes
    send(state.device, {:send, request_bytes})
    # receive 5 integers FIXME: Only doing 1 right now
    _response = receive do
      {:data, data} -> IO.inspect data
    after
      1 -> :timeout
    end
    # update the seq
    state = state.seq(state.seq + 1)
    set_and_reply(state, :ok)
  end
end
