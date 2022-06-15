import abyss/void
import gleam/http.{Get, Post}
import gleam/http/request
import gleam/http/response

pub fn nothingness_test() {
  let corpus =
    request.new()
    |> request.set_method(Get)
    |> request.set_path("/")
    |> request.set_body(<<>>)
    |> void.being_or_nothingness()

  assert 404 = corpus.status
  assert <<"nothing, nothing, nothing...":utf8>> = corpus.body
}

pub fn abyss_1_test() {
  let corpus =
    request.new()
    |> request.set_method(Post)
    |> request.set_path("/abyss")
    |> request.set_body(<<1, 2, 3, 4>>)
    |> request.prepend_header("content-type", "application/octet-stream")
    |> void.being_or_nothingness()

  assert 200 = corpus.status
  assert <<1, 2, 3, 4>> = corpus.body
  assert Ok("application/octet-stream") =
    response.get_header(corpus, "content-type")
}

pub fn abyss_2_test() {
  let corpus =
    request.new()
    |> request.set_method(Post)
    |> request.set_path("/abyss")
    |> request.set_body(<<"AAAAAAAAUUUUUGGGGGGGHHHHHHHH":utf8>>)
    |> request.prepend_header("content-type", "text/plain")
    |> void.being_or_nothingness()

  assert 200 = corpus.status
  assert <<"AAAAAAAAUUUUUGGGGGGGHHHHHHHH":utf8>> = corpus.body
  assert Ok("text/plain") = response.get_header(corpus, "content-type")
}

pub fn abyss_3_test() {
  let corpus =
    request.new()
    |> request.set_method(Post)
    |> request.set_path("/abyss")
    |> request.set_body(<<"angels singing, bass is tight":utf8>>)
    |> void.being_or_nothingness()

  assert 200 = corpus.status
  assert <<"angels singing, bass is tight":utf8>> = corpus.body
  assert Ok("application/octet-stream") =
    response.get_header(corpus, "content-type")
}
