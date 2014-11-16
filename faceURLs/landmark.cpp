#include <iostream>
#include <fstream>
#include <sstream>
#include <cstring>

using namespace std;

int main(int argc, char *argv[]){
	ifstream DetectionDataStream(argv[1]);
	string line;
	while(getline(DetectionDataStream, line)) {
		stringstream ss;
		ss << line;
		string pitch, roll, yaw, smiling, face_id, tag;
		ss >> pitch >> roll >> yaw >> smiling >> face_id >> tag;
		cout << "tag:" << tag[0] << " " << tag[1] << " " << pitch << " " << roll << " " << yaw << " " << smiling << endl;
		string cmd = "curl \"http://apius.faceplusplus.com/v2/detection/landmark?api_key=2b330a1611e4780dee14b2666c2e6ef7&api_secret=TOMk3pSLwtrBut3S7VDER6PxrxauYABl&face_id=" + face_id + "&type=83p\"";
		system(cmd.c_str());
		cout << endl;
	}




	return 0;
}
