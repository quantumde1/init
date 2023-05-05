import std.stdio;
import std.json;
import std.file;
import std.utf;
import std.process;
import std.conv;
import parse;
import services.enable;
import services.start;
import services.disable;
import services.logging;
import services.autorun;
import services.stop;
import services.status;
import configure;

class NotEnoughException : Exception {
	this(string msg, string file = __FILE__, size_t line = __LINE__) {
		super(msg,file,line);
	}
}

void help() @safe {
	writeln("SystemDJ Init");
	writeln("For add service to autostart, run init enable <service>");
	writeln("For start service, run init start <service>");
	writeln("For remove service from autostart, run init disable <service>");
	writeln("For journal run init journal");
	writeln("For clear journal, run clearjr");
}

void main(string[] args) {
	if (args.length <= 1) {
		throw new NotEnoughException("Not enough arguments, run help for available commands");
	}
	if (args[1] == "start") {
		start(args[2]);
	}
	if (args[1] == "enable") {
		enable(args[2]);
	}
	if (args[1] == "help") {
		help();
	}
	if (args[1] == "stop") {
		kill_process(args[2]);
	}
	if (args[1] == "disable") {
		disable(args[2]);
	}
	if (args[1] == "journal") {
		read_log();
	}
	if (args[1] == "clearjr") {
		clear_log();
	}
	if (args[1] == "autorun") {
		pid_check();
		write_services();
		exec_all("*.json");
	}
	if (args[1] == "status") {
		get_process_status(args[2]);
	}
	if (args[1] == "conf") {
		reconfigure_init;
	}
}