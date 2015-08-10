// D is like...
pragma(lib, "curl");
import std.functional, std.json, std.net.curl,
    std.stdio;

alias getJSON = pipe!(get, parseJSON);

void main()
{
    auto json = getJSON(
        "itsthisforthat.com/api.php?json");
    writefln("So, basically D is like a %s for %s",
        json["this"].str, json["that"].str);
}
