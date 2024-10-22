%%%-------------------------------------------------------------------
%% @doc core utils
%% @end
%%%-------------------------------------------------------------------

-module(core_utils).

-export([timestamp/0]).
-export([generate_nonce/1]).
-export([read_key_from_file/1]).

%% @doc Returns the current Unix timestamp in microseconds.
-spec timestamp() -> integer().
timestamp() ->
  {M, S, _} = os:timestamp(),
  M * 1000000 + S.

-define(LETTERS, "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ").

%% @doc Generates a random nonce of length N consisting of uppercase and lowercase letters.
-spec generate_nonce(non_neg_integer()) -> list(char()).
generate_nonce(N) ->
  lists:map(fun(_) -> lists:nth(rand:uniform(length(?LETTERS)), ?LETTERS) end, lists:seq(1, N)).

%% @doc Reads a key from a file. Returns the key as binary if successful, or an error tuple if failed.
-spec read_key_from_file(file:filename()) -> {ok, binary()} | {error, {file_read_error, term()}}.
read_key_from_file(File) ->
  case file:read_file(File) of
    {ok, Binary} ->
      {ok, Binary};
    {error, Reason} ->
      {error, {file_read_error, Reason}}
  end.

