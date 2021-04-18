switch (async_load[?"event_type"]) {
    case "lobby_list":
        if (steam_lobby_list_get_count() > 0) {
            trace("Oh, connecting!");
            trace(steam_lobby_list_get_data(0, "title"));
            steam_lobby_list_join(0);
        } else {
            trace("No lobbies found. Retrying.");
            request_lobbies = room_speed * 3;
        }
        break;
    case "lobby_created":
        steam_lobby_set_data("game", "steamworks.gml");
        steam_lobby_set_data("title", "steamworks.gml");
        break;
    case "lobby_joined":
        var b = buffer_create(16, buffer_fixed, 1);
        buffer_write(b, buffer_u8, 10);
        var owner = steam_lobby_get_owner_id();
        trace("Initial ping: " + string(steam_net_packet_send(owner, b, 4, 0)));
        buffer_delete(b);
        break;
}