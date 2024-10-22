echo -n -e \
"POST\n/midasbuy/v1/orders\n1554208460\n593BEC0C930BF1AFEB40B4A08C8FB242\n{\"id\":\"SG241018Y1V0T44VLXXX1E\"}\n" \
| openssl dgst -sha256 -sign private_key.pem \
| openssl base64 -A

echo -n -e \
"1725519185\nNONCE1234567890\n{\"id\":\"WEBHOOK240929CBXLYDCHMKXXE\",\"create_time\":\"2024-09-18T14:40:09+08:00\",\"update_time\":\"2024-09-18T14:40:09+08:00\",\"resource\":{\"app_id\":\"145000000\",\"user_id\":\"user_id1\",\"server_id\":\"1\"},\"resource_type\":\"RESOURCE_TYPE_USER\",\"resource_version\":\"1.0\",\"event_version\":\"1.0\",\"event_type\":\"USER_VALIDATE\"}\n" \
| openssl dgst -sha256 -sign private_key.pem \
| openssl base64 -A