%%%-------------------------------------------------------------------
%% @doc core record
%% @end
%%%-------------------------------------------------------------------

-record(sign_param, {
  nonce = "" :: string(),
  timestamp = 0 :: integer(),
  method :: string(),
  path :: string(),
  body :: string(),
  private_key :: string(),
  app_id :: string(),
  serial_no = "1" :: string()
}).

-record(verify_param, {
  timestamp = "" :: string(),
  nonce :: string(),
  body :: string(),
  signature :: string(),
  public_key :: string()
}).