#include <iostream>
#include <fstream>
#include <sstream>

using namespace std;

int main(){
	ofstream newstream;
	newstream.open("landmarks_matrix.txt");
	for(int i = 1; i <= 8; i++){
		string filename = to_string(i) + "_landmark_parsed.txt";
		ifstream oldstream(filename);
		string line;
		while(getline(oldstream, line)){
			stringstream ss;
			ss << line;
			string emotion, intensity, angle1, angle2, angle3;
			ss >> emotion >> intensity >> angle1 >> angle2 >> angle3;
			newstream << emotion;
			for(int j = 0; j < 167; j++){
				string word;
				ss >> word;
				newstream << " " << word;
			}
			newstream << endl;
		}
	}
	newstream.close();
	return 0;
}
