defmodule Examples.Square do
  alias Sphero.Client, as: C

  def roll(device) do
    {:ok, s} = C.start(device)
    :timer.sleep(3000)
    roll_and_sleep(s, 0)
    roll_and_sleep(s, 90)
    roll_and_sleep(s, 180)
    roll_and_sleep(s, 270)
    C.stop(s)
    Process.exit(s, :kill)
  end

  def roll_and_sleep(s, angle) do
    C.roll(s, 20, angle)
    :timer.sleep(3000)
  end
end
