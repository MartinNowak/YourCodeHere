// Get your local weather report
pragma(lib, "curl");
import std.functional, std.json, std.net.curl,
    std.stdio, std.string;

alias getJSON = pipe!(get, parseJSON);
auto K2C = (float f) => f - 273.15;
auto K2F = (float f) => f / 5 * 9 - 459.67;

void main()
{
    auto loc = getJSON("ipinfo.io/")["loc"]
        .str.split(",");
    auto resp = getJSON(
        "api.openweathermap.org/data/2.5/weather" ~
        "?lat=" ~ loc[0] ~ "&lon=" ~ loc[1]);

    auto city = resp["name"].str;
    auto country = resp["sys"]["country"].str;
    auto desc = resp["weather"][0]["description"].str;
    auto temp = resp["main"]["temp"].floating;

    writefln(`
        +-----------------------------------------+
        |%s|
        +-----------------------------------------+
        |  weather      |  %-23s|
        +-----------------------------------------+
        |  temperature  |  %.2f°C (%.2f°F)      |
        +-----------------------------------------+
        `.outdent,
        centerJustifier(city ~ ", " ~ country, 41),
        desc, temp.K2C, temp.K2F);
}
