-module(core_credentials).

-export([generate_authorization_header/1]).

-include("core_consts.hrl").
-include_lib("public_key/include/public_key.hrl").
-include("core_record.hrl").

%% @doc Generate an authorization header based on provided parameters.
-spec generate_authorization_header(#sign_param{}) -> string().
generate_authorization_header(Params) ->
  Timestamp = case Params#sign_param.timestamp of
                0 -> core_utils:timestamp();
                Ts -> Ts
              end,
  Nonce = case Params#sign_param.nonce of
            "" -> core_utils:generate_nonce(32);
            N -> N
          end,

  Message = io_lib:format("~s\n~s\n~p\n~s\n~s\n", [Params#sign_param.method, Params#sign_param.path, Timestamp, Nonce, Params#sign_param.body]),

  [EncSKey] = public_key:pem_decode(Params#sign_param.private_key),
  Key = public_key:pem_entry_decode(EncSKey),

  SignatureByte = public_key:sign(Message, sha256, Key),
  Signature = base64:encode(SignatureByte),

  Authorization = io_lib:format("TXGW-SHA256-RSA2048 auth_id=~s,auth_id_type=~s,nonce_str=~s,timestamp=~p,signature=~s,serial_no=~s",
    [Params#sign_param.app_id, ?AuthIDTypeAppID, Nonce, Timestamp, Signature, Params#sign_param.serial_no]),
  lists:flatten(Authorization).
