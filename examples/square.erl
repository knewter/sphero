-module(square).
-export([roll/1]).

roll(Device) ->
  {ok, S} = 'Elixir.Sphero.Client':start(Device),
  timer:sleep(3000),
  roll_and_sleep(S, 0),
  roll_and_sleep(S, 90),
  roll_and_sleep(S, 180),
  roll_and_sleep(S, 270),
  'Elixir.Sphero.Client':stop(S),
  exit(S, kill).

roll_and_sleep(S, Angle) ->
  'Elixir.Sphero.Client':roll(S, 20, Angle),
  timer:sleep(3000).

