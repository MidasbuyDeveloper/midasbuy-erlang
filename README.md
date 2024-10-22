MidasBuy Erlang SDK
=====

Midasbuy signature and verification sdk.

Introduction
-----
1. core library [core](core).
2. `core_credentials.erl` implements the signature method of https://developer.midasbuy.com/api/apis/orders-api#signature-method.
3. `core_notify_validator.erl` implements the verification signature of https://developer.midasbuy.com/api/webhooks/webhooks-api/#verifying-signatures.

You can view the usage of specific function methods in the test method.

Build
-----

    $ rebar3 compile

Test
-----

    $ rebar3 eunit

