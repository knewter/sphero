# Sphero

A library for interacting with a Sphero device that's connected via bluetooth.

## Usage

```elixir
{:ok, s} = Sphero.Client.start(device)
Sphero.Client.ping(s) #=> Sends an 0x01 0x00
```

## Development

To get some sockets to play with without worrying about the sphero, use socat:

```sh
socat -d -d pty,raw,echo=0,nonblock=1 pty,raw,echo=0,nonblock=1
```

Then connect to one of those sockets in screen with:

```sh
screen /dev/pts/7 115200,8,N,1
```

And open the other with the sphero client.  Send it commands.  See them come
through...
