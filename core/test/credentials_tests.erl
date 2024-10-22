%%%-------------------------------------------------------------------
%% @doc test credentials
%% @end
%%%-------------------------------------------------------------------

-module(credentials_tests).

-include_lib("eunit/include/eunit.hrl").
-include("core_record.hrl").

generate_authorization_header_test() ->
  {ok, PrivateKey} = core_utils:read_key_from_file("./test/key/private_key.pem"),
  SignParams = #sign_param{
    method = "POST",
    path = "/midasbuy/v1/orders",
    body = "{\"id\":\"SG241018Y1V0T44VLXXX1E\"}",
    app_id = "test_app_id",
    serial_no = "1",
    private_key = PrivateKey,
    nonce = "593BEC0C930BF1AFEB40B4A08C8FB242",
    timestamp = 1554208460
  },

  Authorization = core_credentials:generate_authorization_header(SignParams),
  ExpectedAuthorization = "TXGW-SHA256-RSA2048 auth_id=test_app_id,auth_id_type=app_id,nonce_str=593BEC0C930BF1AFEB40B4A08C8FB242,timestamp=1554208460,signature=HuDyh8qybAyG9cyDNtQ6emLwpsLbaIt6o5TNIdgEkGFhGRbIbSr/YteP8ESOoH8nMqMoDWWlSPu+apUebih/RHK3EpjF0L7TlcGR5LqRqLbaCwWrSWbRehgsUyU1eZkjSAFpFgKCQrTxopkKfODmj2MiERf2PcVXE1BNBUoJcD0t0dEhD3jlqpduDoj5Xw7Yoh355CrO6tLFeXfHrMWKFageOPZltppC6Km8T63/TE03QWTICt8T/+xik00djkCD/6iWxszal8kl0ewWJXa8DCmvS/ZZIDkUIf5VNeNU9LDE29SUc1X5CRtHBXhpf3qOl6GVhQv+rNQf5eOrX/E7NA==,serial_no=1",
  ?assertEqual(ExpectedAuthorization, Authorization).
