%%%-------------------------------------------------------------------
%% @doc core notify validator
%% @end
%%%-------------------------------------------------------------------

-module(core_notify_validator).

-export([validate_notify_http_message/1]).

-include("core_record.hrl").

%% @doc Validates the HTTP message signature using the provided public key from the verify_param record.
-spec validate_notify_http_message(#verify_param{}) -> {ok, string()} | {error, string()}.
validate_notify_http_message(Params) ->
  Message = io_lib:format("~s\n~s\n~s\n", [Params#verify_param.timestamp,Params#verify_param.nonce, Params#verify_param.body]),

  [EncKey] = public_key:pem_decode(Params#verify_param.public_key),
  Key = public_key:pem_entry_decode(EncKey),
  SignatureByte = base64:decode(Params#verify_param.signature),

  case public_key:verify(Message, sha256, SignatureByte, Key) of
    true ->
      {ok, "Signature is valid"};
    false ->
      {error, "Invalid signature"}
  end.