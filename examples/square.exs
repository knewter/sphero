defmodule Examples.Square do
  alias Sphero.Client, as: C
  def roll device do
    {:ok, s} = C.start device
    :timer.sleep 4000
    for _ <- 1..5, do: roll_square(s)
    C.stop s
    Process.exit s, :kill
  end
  def roll_square s do
    for x <- [0, 90, 180, 270], do: roll_and_sleep(s, x)
  end
  def roll_and_sleep s, angle do
    C.roll s, 80, angle
    :timer.sleep 1000
  end
end

Examples.Square.roll "/dev/rfcomm0"
