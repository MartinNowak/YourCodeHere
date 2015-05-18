#!/usr/bin/env rdmd

pragma(lib, "curl");
// Might be needed because of http://d.puremagic.com/issues/show_bug.cgi?id=7044
// (phobos2 depends on curl)
//pragma(lib, "phobos2");

import std.stdio;
import std.net.curl;
import std.json;

void main()
{
    auto json = parseJSON(get("http://itsthisforthat.com/api.php?json"));
    writeln("So, basically D is like a ", json["this"].str, " for ", json["that"].str);
}
