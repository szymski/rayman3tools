module formats.lvl;

import global;
import std.stdio, std.file, std.path;

class LvlFormat {
	private {
		string _lvlFilename, _ptrFilename;
	}

	/// Fix.lvl is 0, others are 1
	uint levelId;

	string name;

	ubyte[] lvlData;
	uint[] ptrData;

	this(uint levelId, string lvlFilename, string ptrFilename) {
		this.levelId = levelId;
		loadedLevels ~= this;
		levelsById[levelId] = this;

		_lvlFilename = lvlFilename;
		_ptrFilename = ptrFilename;

		name = baseName(lvlFilename);

		readFiles();
		relocate();
	}

	private void readFiles() {
		lvlData = new ubyte[](cast(uint)getSize(_lvlFilename) - 4);
		File f = File(_lvlFilename, "r");
		f.seek(4); // First 4 bytes are ignored
		f.rawRead(lvlData);
		f.close();

		ptrData = cast(uint[])std.file.read(_ptrFilename);
	}

	private void relocate() {
		uint entryCount = ptrData[0];

		// We start at index 1, because we want to skip entry count
		for(int i = 1; i < entryCount * 2 + 1; i += 2) {
			int levelId = ptrData[i];
			int address = ptrData[i + 1];
			
			if(levelId != 2 && levelId != 3) {
				uint* rawAddress = cast(uint*)(lvlData.ptr + address);
				*rawAddress += cast(uint)levelsById[levelId].lvlData.ptr;
			}
		}
	}

	void printRelocation() {
		uint entryCount = ptrData[0];
		
		// We start at index 1, because we want to skip entry count
		for(int i = 1; i < entryCount * 2 + 1; i += 2) {
			int levelId = ptrData[i];
			int address = ptrData[i + 1];

			// TODO: Make level id settable
			//if(levelId == 0) {
				uint* rawAddress = cast(uint*)(lvlData.ptr + address);
				writeln(address, " ", *rawAddress);
			//}
		}
	}
}