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