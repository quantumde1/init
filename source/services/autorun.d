module services.autorun;

import std.process;
import std.file;
import std.array;
import std.stdio;

void exec_all() {
    auto files = dirEntries("/etc/init/enabled/", SpanMode.shallow);
    //execute([files]);
    writeln(files);
}