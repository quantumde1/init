module services.logging;

import std.file;
import std.stdio;

void read_log() {
    auto content = readText("/var/log/init/log");
    writeln(content);
}