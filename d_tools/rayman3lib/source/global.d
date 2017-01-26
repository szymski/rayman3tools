module global;

import formats.lvl;
import consoled;
import std.conv;

LvlFormat[] loadedLevels;
LvlFormat[16] levelsById; // More shouldn't be needed

/**
	Translates a memory pointer into SNA file relative pointer.
*/
auto pointerToLvlLocation(T)(T* pointer) {
	struct toReturn_t {
		bool valid;
		string name;
		uint address;
	}
	
	toReturn_t toReturn;

	foreach(lvl; loadedLevels) {
		if(pointer >= lvl.lvlData.ptr && pointer < lvl.lvlData.ptr + lvl.lvlData.length) {
			toReturn.valid = true;
			toReturn.name = lvl.name;
			toReturn.address = pointer - lvl.lvlData.ptr;
			break;
		}
	}
	
	return toReturn;
}

/**
	Print address information
*/
auto printAddressInformation(void* address) {
	auto lvlLocation = pointerToLvlLocation(address);
	
	if(lvlLocation.valid)
		writecln(Fg.cyan, "\t", lvlLocation.name, ": ", Fg.white, "0x", lvlLocation.address.to!string(16));
	else
		writecln("Not a valid LVL address");
}