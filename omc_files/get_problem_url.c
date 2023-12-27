#include<iostream>
#include<string>
#include<fstream>
#include<map>
#include<cstring>
using namespace std;

string return_contest_url(int);
map<char, string> search_problem_url(int, string);

int main(){
	string contest_url = return_contest_url(135);
	map<char, string> omc135 = search_problem_url(135, contest_url);
	//cout << omc135[A] << endl;
	return 0;



}


string return_contest_url(int contest_n) {
	if(contest_n<10){
		string url = "https://onlinemathcontest.com/contests/omc00" + to_string(contest_n) + "/tasks/";
		return url;
	}else if(contest_n<100){
		string url = "https://onlinemathcontest.com/contests/omc0" + to_string(contest_n) + "/tasks/";
		return url;
	}else{
		string url = "https://onlinemathcontest.com/contests/omc" + to_string(contest_n) + "/tasks/";
		return url;
	}
}

map<char, string> search_problem_url(int contest_n, string url) {
	map<char, string> problem_url;
	int count = 0;
	string contest_name;

	if(contest_n<10){
		contest_name = "omc00" + to_string(contest_n) + ".html";
	}else if(contest_n<100){
		contest_name = "omc0" + to_string(contest_n) + ".html";
	}else{
		contest_name = "omc" + to_string(contest_n) + ".html";
	}
	ifstream ifs(contest_name);
	if (ifs.is_open()) {
		string line;
		while (getline(ifs, line)) {
			if(line.find(url)!=string::npos){
				string str = line.substr(line.find(url));
				str.pop_back();
				str.pop_back();
				char alphabet = 65 + count;
					/*if(contest_n<10){
						string problem_name = "OMC00" + to_string(contest_n) + alphabet;
				  }else if(contest_n<100){
						string problem_name = "OMC0" + to_string(contest_n) + alphabet;
				  }else{
						string problem_name = "OMC" + to_string(contest_n) + alphabet;
				  }*/
				problem_url[alphabet] = str;
				cout << alphabet << endl;
				count++;
			}
		}
	}
	return problem_url;
}
