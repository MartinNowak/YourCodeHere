import std.json, std.net.curl, std.stdio, std.string;

pragma(lib, "curl");
pragma(lib, "phobos2");

void main()
{
    enum ip_address_url = "https://api.ipify.org/?format=json";
    enum city_name_url_stem = "http://getcitydetails.geobytes.com/GetCityDetails?fqcn=";
    enum weather_url_stem = "http://api.openweathermap.org/data/2.5/weather?q=";

    auto ip_addr = parseJSON(get(ip_address_url))["ip"].str;

    auto city = parseJSON(get(city_name_url_stem ~ ip_addr))["geobytescity"].str;

    auto weather_json = parseJSON(get(weather_url_stem ~ city));

    if (weather_json["cod"].integer == 200)
    {
        auto city_and_country = weather_json["name"].str ~ ", " ~ weather_json["sys"]["country"].str;

        writefln("    +-----------------------------------------+");
        writefln("    |%s|", center(city_and_country, 41));
        writefln("    +-----------------------------------------+");
        writefln("    |  weather      |  %s|", leftJustify(weather_json["weather"][0]["main"].str, 23));
        writefln("    +-----------------------------------------+");
        writefln("    |  temperature  |  %.2f°C (%.2f°F)      |",
                 weather_json["main"]["temp"].floating - 273.15,
                 weather_json["main"]["temp"].floating / 5 * 9 - 459.67 );
        writefln("    +-----------------------------------------+");
    }
    else
    {
        writeln("There was a problem getting the weather information for your city");
    }
}

