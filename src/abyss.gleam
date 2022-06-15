import abyss/void
import gleam/erlang
import gleam/erlang/os
import gleam/http/elli
import gleam/int
import gleam/io
import gleam/result
import gleam/string

pub fn main() {
  let port =
    "PORT"
    |> os.get_env()
    |> result.then(int.parse)
    |> result.unwrap(3000)

  assert Ok(_) = elli.start(void.scream(), on_port: port)

  io.println(string.concat([
    "The void listens on localhost:",
    int.to_string(port),
  ]))

  erlang.sleep_forever()
}
