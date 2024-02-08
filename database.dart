import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;
void main() {
    var contest_url = return_contest_url("M", 135);
    print("$contest_url");
    var problem_data_set = List<ProblemDatabase>.empty();
    make_problem_data_set("M", 135, contest_url, problem_data_set);


}

String return_contest_url(String mark, int contest_n) {
		if(mark == "B"){
				if (contest_n < 10) {
        		String url = "https://onlinemathcontest.com/contests/omcb00" + contest_n.toString() + "/tasks/";
        		return url;
    		} else if (contest_n < 100) {
        		String url = "https://onlinemathcontest.com/contests/omcb0" + contest_n.toString() + "/tasks/";
        		return url;
    		} else {
        		String url = "https://onlinemathcontest.com/contests/omcb" + contest_n.toString() + "/tasks/";
        		return url;
    		}
		}else if(mark == "M"){
    		if (contest_n < 10) {
        		String url = "https://onlinemathcontest.com/contests/omc00" + contest_n.toString() + "/tasks/";
        		return url;
    		} else if (contest_n < 100) {
        		String url = "https://onlinemathcontest.com/contests/omc0" + contest_n.toString() + "/tasks/";
        		return url;
    		} else {
        		String url = "https://onlinemathcontest.com/contests/omc" + contest_n.toString() + "/tasks/";
        		return url;
    		}
		}else if(mark == "E"){
			if (contest_n < 10) {
            String url = "https://onlinemathcontest.com/contests/omce00" + contest_n.toString() + "/tasks/";
            return url;
        } else if (contest_n < 100) {
            String url = "https://onlinemathcontest.com/contests/omce0" + contest_n.toString() + "/tasks/";
            return url;
        } else {
            String url = "https://onlinemathcontest.com/contests/omce" + contest_n.toString() + "/tasks/";
            return url;
        }
    }
		return "Hello.";
}

class ProblemDatabase {
	String problem_text = "online";
	String problem_name = "math";
	String contest_category = "contest";
	String problem_url = "problems";
	int problem_point = 100;

	ProblemDatabase(this.problem_name, this.contest_category, this.problem_url);

}

void make_problem_data_set(String mark, int contest_n, String contest_url,List<ProblemDatabase> problem_data_set) async {
    int count = 0;
    String contest_name = "Hello! What are you doing here?";
		String contest_category = "M";
		if(mark == "B"){
				contest_category = "B";
    		if (contest_n < 10) {
        		contest_name = "./omc_files/omcb00" + contest_n.toString() + ".html";
   			} else if (contest_n < 100) {
        		contest_name = "./omc_files/omcb0" + contest_n.toString() + ".html";
    		} else {
        		contest_name = "./omc_files/omcb" + contest_n.toString() + ".html";
    		}
		}else if(mark == "M"){
				if (contest_n < 10) {
            contest_name = "./omc_files/omc00" + contest_n.toString() + ".html";
        } else if (contest_n < 100) {
            contest_name = "./omc_files/omc0" + contest_n.toString()  + ".html";
        } else {
            contest_name = "/home/tenho/FlutterWorkspace/practice/omc_plusplus/lib/omc" + contest_n.toString()  + ".html";
        }
		}else if(mark == "E"){
				contest_category = "E";
				if (contest_n < 10) {
            contest_name = "./omc_files/omce00" + contest_n.toString()  + ".html";
        } else if (contest_n < 100) {
            contest_name = "./omc_files/omce0" + contest_n.toString()  + ".html";
        } else {
            contest_name = "./omc_files/omce" + contest_n.toString()  + ".html";
        }
		}
    print("$contest_name");
    
		var file = File(contest_name);
		try {
			var lines = await file.readAsLines();

			print("file reading...");

			for (var line in lines) {
				int index = line.indexOf(contest_url);
				if(index != -1) {
					String substring = line.substring(index);
					String problem_url = substring.substring(0, substring.length-2);
					String end_char = problem_url[problem_url.length - 1];
					if(end_char != "\"") {
						int problem_alphabet_int = 65 + count;
						String problem_alphabet = String.fromCharCode(problem_alphabet_int);
						String problem_name = contest_n.toString() + problem_alphabet;
						var problem_data = ProblemDatabase(problem_name, contest_category, problem_url);
						String filepath = contest_name.substring(0, contest_name.length-5) + problem_alphabet + ".html";
						print('$filepath');
						//call_shellscript(filepath, problem_url);
						search_word_in_sentence(filepath, problem_data);
						problem_data_set.add(problem_data);
					}
				}
			}
		}	catch (e) {
				print('error: $e');
		}
}	

/*file_download(String filepath, String problem_url) async {
	var url = Uri.parse(problem_url);
	print('url:$url');
	try {
		final response = await http.get(url);
		print('succeed in getting http');
		if(response.statusCode == 200) {
			final file = File(filepath);
			await file.writeAsBytes(response.bodyBytes);
		} else {
			print('err0r: ${response.reasonPhrase}');
		}
	} catch (e) {
		print('error: $e');
	}
}*/

void call_shellscript(String filepath, String problem_url) async {
	var result = await Process.run('sh', ['/home/tenho/FlutterWorkspace/practice/omc_plusplus/lib/wget_omc_problem.sh', problem_url, filepath]);
	print(result.stdout);
	print(result.stderr);
}


void search_word_in_sentence(String filepath, ProblemDatabase problem_data) async {
	var file = File(filepath);
	print('filepath:$filepath');

	try {
		var lines = await file.readAsLines();

		print('file reading...2');
		for (var line in lines) {
			int index_text = line.indexOf('const content');
			if (index_text != -1) {
				String problem_text_unicode = line.substring(index_text+17, line.length - 2);
				String problem_text = jsonDecode('"$problem_text_unicode"');
				for (int i=0; i<problem_text.length; i++) {
					if(problem_text[i] == '\$' && problem_text[i+1] == '\$') {
						int count = 3;
						while(true) {
							if(problem_text[i+count] == '\$' && problem_text[i+count+1] == '\$') {
								problem_text = problem_text.substring(0,i-1) + problem_text.substring(i+2,i+count) + problem_text.substring(i+count+3);
								break;
							}
							count += 1;
						}
						i = i+count-3;
					} else if(problem_text[i] == '\$') {
						int count = 2;
            while(true) {
              if(problem_text[i+count] == '\$') {
                problem_text = problem_text.substring(0,i-1) + problem_text.substring(i+1,i+count) + problem_text.substring(i+count+2);
                break;
              }
              count += 1;
            }
            i = i+count-2;
					}
				}
				print('$problem_text');
				problem_data.problem_text = problem_text;
			} else if (line.contains('点数:')) {
				var line_point = line.indexOf('点数:');
				var problem_point = line.substring(line_point+4, line.length-4);
				print('$line');
				print('$problem_point');
				problem_data.problem_point = int.parse(problem_point.toString());
			}
		}
	} catch (e) {
		print('some error occured:$e');
	}
}










/*    if var Ok(lines) = read_lines(contest_name) {
        print("file reading...");
        for line in lines {
            if var Ok(ip) = line {
                if var Some(index) = ip.find(&contest_url) {
                //a line contains url
                    var problem_url = &ip[index..];
                    var mut problem_url = problem_url.to_string();
                    var length = problem_url.len();
                    problem_url.truncate(length - 2);
                    var end_char: &String = &problem_url.chars().skip(problem_url.len().saturating_sub(1)).collect();
                    if end_char != "\"" {
                        var problem_alphabet = 65 + count;
                        var problem_alphabet = problem_alphabet as u8 as char;
                        var problem_address = contest_n.to_string() + &problem_alphabet.to_string();
                        problem_url_map.insert(problem_address, problem_url);
                        count += 1;
                    }
                }
            }
        }
    }
    for (key, value) in &problem_url_map {
        print("{}: {}", key, value);
    }


}

fn read_lines<P>(filename: P) -> io::Result<io::Lines<io::BufReader<File>>>
where P: AsRef<Path>, {
    var file = File::open(filename)?;
    Ok(io::BufReader::new(file).lines())
}

#[tokio::main]
async fn download_file(url: String) -> Result<()> {
    var filename = url.split("/").last().unwrap();
    var response: reqwest::Response = reqwest::get(url).await?;
    var bytes = response.bytes().await?;
    var mut out = File::create(filename)?;
    io::copy(&mut bytes.as_ref(), &mut out)?;

    Ok(())
}

fn search_word_in_sentence(filepath: String, search_word: String) -> String{
    if var Ok(lines) = read_lines(filepath) {
        for line in lines {
            if var Ok(ip) = line {
                if var Some(index) = ip.find(&search_word) {
                    var mut count = 0;
                    var content = &ip[index..];
                    var mut content_string = content.to_string();
                    print("{}", &content);
                    loop {
                        var capital_content = content.get(count..count+1);
                        if capital_content == Some("\\") {
                            break;
                        }
                        count += 1;
                    }
                    print("{}", count);
                    var content = &content[count..];
                    var mut content_string = content.to_string();
                    content_string.pop();
                    content_string.pop();
                    print("{}", &content_string);
                    //from_u32(content)
                    return content_string;
                }
            }
        }
    }
    return String::from("no such word in this file.");
}

String unicode_to_readable(content: String){
    var mut content_readable = String::from("");
    var length = content.chars().count();
    for mut i in 0..length {
        if &content[i..(i+2)] == "\\u" {
            var unicode_escape_str = &content[(i+2)..(i+6)];
            print("{}", &unicode_escape_str);
            var unicode_escape = unicode_escape_str.parse::<u32>().unwrap();
            var char_readable = from_u32(unicode_escape).unwrap();
            print("{}", &char_readable);
            content_readable.push(char_readable);
            i += 6;
        } else if &content[i..(i+2)] == "$$" {
            var mut count = 2;
            loop {
                if &content[(i+count)..(i+count+2)] == "$$" {
                    break;
                }
                count += 1;
            }
            content_readable.push_str(&content[(i+2)..(i+count)]);
            i += count+2;
        } else if &content[i..(i+1)] == "$" {
            var mut count = 1;
            loop { if &content[(i+count)..(i+count+1)] == "$" {
                    break;
                }
                count += 1;
            }
            content_readable.push_str(&content[(i+1)..(i+count)]);
            i += count+1;
        } else {
            i += 1;
        }
    }
    return content_readable
}
*/
