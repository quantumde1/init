module services.autorun;

import std.process;
import std.file;
import std.array;
import std.stdio;
import std.json;
import std.conv;
import std.algorithm;
import parse;

void exec_all(string services) {
    writeln("[\033[0;36m INFO \033[0m]", " Starting services...");
    executeShell("/etc/init/enabled/autostart.sh");
}

int pid_check() @safe {
    auto pid = thisProcessID();
    auto content = readText("/etc/init/conf/main.json");
	JSONValue j = parseJSON(content);
	auto distname = j["name"].str;
    auto pid_stat = 0;
    if (pid == 1) {
        writeln("[\033[0;36m INFO \033[0m]", " Welcome to ", distname);
        pid_stat = 0;
    }
    else {
        writeln("[\033[0;36m INFO \033[0m]", " System name is ", distname);
        pid_stat = 1;
    }
    return pid_stat;
}

void write_services() {
    auto files = dirEntries("/etc/init/enabled/", SpanMode.shallow);
    writeln("[\033[0;36m INFO \033[0m]", " Services for autorun: ", files);
}