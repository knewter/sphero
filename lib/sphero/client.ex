defrecord Sphero.Client.State, device: nil, seq: nil

defmodule Sphero.Client do
  use ExActor
  @ping_message 1

  defcall ping, state: state do
    # send the command
    :ok = :serctl.write(state.device, message(state, @ping_message))
    # receive 5 integers
    response = :serctl.read(state.device, 5)
    # update the seq
    state.update_seq(state.seq + 1)
  end

  definit device do
    {:ok, fd} = :serctl.open(bitstring_to_list(device))
    IO.inspect fd
    Sphero.Client.State.new(device: fd, seq: 0)
  end

  defp message(state, message) do
    :erlang.iolist_to_binary([message, state.seq])
  end
end
