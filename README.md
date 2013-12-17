# Sphero

A library for interacting with a Sphero device that's connected via bluetooth.

## Usage

```elixir
sphero = Sphero.start(device)
Sphero.ping(sphero) #=> Sends an 0x01 0x00
```
