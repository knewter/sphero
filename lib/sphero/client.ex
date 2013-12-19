defrecord Sphero.Client.State, device: nil, seq: nil

defmodule Sphero.Client do
  use ExActor
  @ping_message 1

  defcall ping, state: state do
    # send the command
    state.device <- {:send, message(state, @ping_message)}
    # receive 5 integers
    response = receive do
      {:data, data} -> IO.inspect data
    end
    # update the seq
    state = state.seq(state.seq + 1)
    set_and_reply(state, :ok)
  end

  definit device do
    device = :serial.start([speed: 115200, open: bitstring_to_list(device)])
    Sphero.Client.State.new(device: device, seq: 0)
  end

  defp message(state, message) do
    :erlang.iolist_to_binary([message, state.seq])
  end
end
