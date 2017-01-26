module handlers.relocation;

import app, utils, formats.lvl;
import std.stdio, std.file;

mixin registerHandlers;

@handler
void relocation(string[] args) {
	string lvlFilename = r"E:\GOG Games\Rayman 3\Copy\fix.lvl";
	string ptrFilename = r"E:\GOG Games\Rayman 3\Copy\fix.ptr";

	LvlFormat lvl = new LvlFormat(0, lvlFilename, ptrFilename);
}

@handler lvlrelocation(string[] args) {
	if(args.length < 2) {
		writeln("Usage: lvlrelocation lvlfilename ptrfilename");
		return;
	}

	string lvlFilename = args[0];
	string ptrFilename = args[1];

	LvlFormat lvl = new LvlFormat(0, lvlFilename, ptrFilename);
	lvl.printRelocation();
}