defmodule Examples.Square do
  alias Sphero.Client, as: C
  def roll device do
    {:ok, s} = C.start device
    :timer.sleep 4000
    Enum.map 1..5, fn(_) -> roll_square(s) end
    C.stop s
    Process.exit s, :kill
  end
  def roll_square s do
    roll_and_sleep s, 0
    roll_and_sleep s, 90
    roll_and_sleep s, 180
    roll_and_sleep s, 270
  end
  def roll_and_sleep s, angle do
    C.roll s, 80, angle
    :timer.sleep 1000
  end
end

Examples.Square.roll "/dev/rfcomm0"
