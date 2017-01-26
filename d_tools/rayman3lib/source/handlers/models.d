module handlers.models;

import app, utils, formats.lvl, global;
import structures.model, structures.sector;
import std.stdio, std.file;

mixin registerHandlers;

@handler
void models(string[] args) {
	string lvlFilename = r"E:\GOG Games\Rayman 3\Copy\fix.lvl";
	string ptrFilename = r"E:\GOG Games\Rayman 3\Copy\fix.ptr";
	LvlFormat fixLvl = new LvlFormat(0, lvlFilename, ptrFilename);

	lvlFilename = r"E:\GOG Games\Rayman 3\Copy\menumap.lvl";
	ptrFilename = r"E:\GOG Games\Rayman 3\Copy\menumap.ptr";
	LvlFormat levelLvl = new LvlFormat(1, lvlFilename, ptrFilename);

	Sector* sector = cast(Sector*)(levelLvl.lvlData.ptr + 0x2D5744);

	printAddressInformation(sector.info0.firstModel.model_1.model_2.model_3.model_4);
}
