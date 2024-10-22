%%%-------------------------------------------------------------------
%% @doc test notify validator
%% @end
%%%-------------------------------------------------------------------

-module(notify_validator_tests).

-include_lib("eunit/include/eunit.hrl").
-include("core_record.hrl").


validate_notify_http_message_test_() ->
  {ok, PublicKey} = core_utils:read_key_from_file("./test/key/public_key.pem"),
  Params = #verify_param{
    timestamp = "1725519185",
    nonce = "NONCE1234567890",
    body = "{\"id\":\"WEBHOOK240929CBXLYDCHMKXXE\",\"create_time\":\"2024-09-18T14:40:09+08:00\",\"update_time\":\"2024-09-18T14:40:09+08:00\",\"resource\":{\"app_id\":\"145000000\",\"user_id\":\"user_id1\",\"server_id\":\"1\"},\"resource_type\":\"RESOURCE_TYPE_USER\",\"resource_version\":\"1.0\",\"event_version\":\"1.0\",\"event_type\":\"USER_VALIDATE\"}",
    signature = "nSbn5D/8NOhby7hoxDp7Ma+VnqSQm6K7/Pe6hXhjGV+NcmYkunJiovF+c87oaFua+W2tAuquyH6SZxLZ/FjKcG6GhhrlpuJnyb0dUfQ6UiehwSKs0omy1/wEb/ygwj4AFJZts1z5B0s95ErX4rk6H51FTy4akOjmr6XSgeLvz1tYzcKV6aZk1N66fbRJAozNn148T32JrWY2I5RYR7byLX9c/sHxiBD+6L93/Zj+KLE5ub95iBc9M+V7zsvs/MplME30Ks+JDyg29HCkZ7tSS25VzeCDxovGNMZ5MmDq4xQSYC6fH9qO41GP9E1iakKdt1V+6zyI52Z6/7h3FPjeeA==",
    public_key = PublicKey
  },
  [
    ?_assertEqual({ok, "Signature is valid"}, core_notify_validator:validate_notify_http_message(Params)),
    ?_assertEqual({error, "Invalid signature"}, core_notify_validator:validate_notify_http_message(Params#verify_param{signature = base64:encode("InvalidSignature")}))
  ].




