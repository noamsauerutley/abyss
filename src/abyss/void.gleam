import abyss/void/echoes
import gleam/bit_builder
import gleam/bit_string
import gleam/http.{Post}
import gleam/http/request
import gleam/http/response
import gleam/http/service
import gleam/result

fn being(request) {
  let content_type =
    request
    |> request.get_header("content-type")
    |> result.unwrap("application/octet-stream")

  200
  |> response.new()
  |> response.set_body(request.body)
  |> response.prepend_header("content-type", content_type)
}

fn nothingness() {
  let body =
    "nothing, nothing, nothing..."
    |> bit_string.from_string

  404
  |> response.new()
  |> response.set_body(body)
  |> response.prepend_header("content-type", "text/plain")
}

pub fn being_or_nothingness(request) {
  let path = request.path_segments(request)

  case request.method, path {
    Post, ["abyss"] -> being(request)
    _, _ -> nothingness()
  }
}

pub fn scream() {
  being_or_nothingness
  |> service.map_response_body(bit_builder.from_bit_string)
  |> echoes.whisper
}
