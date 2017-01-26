module structures.model;

struct Model_0 {
	Model_1* model_1;
	Model_0* nextTwin; // NOT SURE
}

struct Model_1 {
	void* unknown0;
	void* unknown1;
	void* unknown2;
	Model_2* model_2;
}

struct Model_2 {
	Model_3* model_3;
}

struct Model_3 {
	void* unknown0;
	void* unknown1;
	void* unknown2;
	void* unknown3;
	void* unknown4;
	Model_4* model_4;
}

struct Model_4 {

}

struct Vertex {
	float x, y, z;
}

struct VertexFace {
	ushort xIndex, yIndex, zIndex;
}

struct UV {
	float u, v;
}

struct UVFace {
	ushort xIndex, yIndex, zIndex;
}

/*
	Texture info
*/

struct TextureInfo_0 {
	TextureInfo_1* textureInfo_1;
}

struct TextureInfo_1 {
	ubyte[72] unknown;
	TextureInfo_2* textureInfo_2;
}

struct TextureInfo_2
{
	ubyte[8] something1_2;
	uint something3;
	ubyte[8] something4_5;
	uint something6;
	ushort h;
	ushort w;
	ushort h2;
	ushort w2;
	ubyte[12] gap20;
	uint dword2C; 
	ubyte[21] gap30;
	ubyte byte45;
	char[130] textureFilename;
};