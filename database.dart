import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'database_helper.dart';
void main() {
    var contest_url = return_contest_url(M,135);
    print("$contest_url");
    List<ProblemDatabase>  problem_data_set = {};
    make_problem_data_set(M, 135, contest_url, problem_data_set);
    print("This is content_readable:$content");


}

String return_contest_url(String mark, int contest_n) {
		if(mark == B){
				if (contest_n < 10) {
        		String url = "https://onlinemathcontest.com/contests/omcb00" + contest_n.toString() + "/tasks/";
        		return url;
    		} else if contest_n < 100 {
        		String url = "https://onlinemathcontest.com/contests/omcb0" + contest_n.toString() + "/tasks/";
        		return url;
    		} else {
        		String url = "https://onlinemathcontest.com/contests/omcb" + contest_n.toString() + "/tasks/";
        		return url;
    		}
		}else if(mark == M){
    		if (contest_n < 10) {
        		String url = "https://onlinemathcontest.com/contests/omc00" + contest_n.toString() + "/tasks/";
        		return url;
    		} else if contest_n < 100 {
        		String url = "https://onlinemathcontest.com/contests/omc0" + contest_n.toString() + "/tasks/";
        		return url;
    		} else {
        		String url = "https://onlinemathcontest.com/contests/omc" + contest_n.toString() + "/tasks/";
        		return url;
    		}
		}else if(mark == E){
			if (contest_n < 10) {
            String url = "https://onlinemathcontest.com/contests/omce00" + contest_n.toString() + "/tasks/";
            return url;
        } else if contest_n < 100 {
            String url = "https://onlinemathcontest.com/contests/omce0" + contest_n.toString() + "/tasks/";
            return url;
        } else {
            String url = "https://onlinemathcontest.com/contests/omce" + contest_n.toString() + "/tasks/";
            return url;
        }
    }
}

class ProblemDatabase {
	String problem_text;
	String problem_name;
	String contest_category;
	String problem_url;
	int problem_point;

	ProblemDatabase(this.problem_name, this.contest_category, this.problem_url);

}

void make_problem_data_set(String mark, int contest_n, String contest_url,List<ProblemDatabase> problem_data_set) async {
    int count = 0;
    String contest_name = "Hello! What are you doing here?";
		String contest_category = "M";
		if(mark == B){
				contest_category = "B"
    		if (contest_n < 10) {
        		contest_name = "../../omc_files/omcb00" + contest_n + ".html";
   			} else if (contest_n < 100) {
        		contest_name = "../../omc_files/omcb0" + contest_n + ".html";
    		} else {
        		contest_name = "../../omc_files/omcb" + contest_n + ".html";
    		}
		}else if(mark == M){
				if (contest_n < 10) {
            contest_name = "../../omc_files/omc00" + contest_n + ".html";
        } else if (contest_n < 100) {
            contest_name = "../../omc_files/omc0" + contest_n + ".html";
        } else {
            contest_name = "../../omc_files/omc" + contest_n + ".html";
        }
		}else if(mark == E){
				contest_category = "E"
				if (contest_n < 10) {
            contest_name = "../../omc_files/omce00" + contest_n + ".html";
        } else if (contest_n < 100) {
            contest_name = "../../omc_files/omce0" + contest_n + ".html";
        } else {
            contest_name = "../../omc_files/omce" + contest_n + ".html";
        }
		}
    print("$contest_name");
    
		var file = File(contest_name);
		try {
			var lines = await file.readAsLines().then((lines) => lines.reversed);

			var last100Lines = reversedLines.take(100).toList();

			for (var line in last100Lines.reversed) {
				int index = line.indexOf(contest_url);
				if(index != -1) {
					String substring = mainString.substring(index);
					String problem_url = substring.substring(0, substring.length-2)
					String end_char = problem_url[problem_url.length - 1];
					if(end_char != "\"") {
						int problem_alphabet_int = 65 + count;
						String problem_alphabet = String.fromCharCode(problem_alphabet_int);
						String problem_name = contest_n.toString() + problem_alphabet;
						problem_data = ProblemDatabase(problem_name: problem_name, contest_category: contest_category, problem_url: problem_url);
						String filepath = contest_name.substring(0, contest_name.length-5) + problem_alphabet + ".html";
						search_word_in_sentences(filepath, problem_data);
						problem_data_set.add(probelm_data);
					}
				}
			}
		}	catch (e) {
				print('some error occured.');
		}
}	

void search_word_in_sentence(String filepath, ProblemDatabase problem_data) {
	var file = File(filepath);

	try {
		var lines = await file.readAsLines();

		for (var line in lines) {
			int index_text = line.indexOf('const content');
			if (index_text != -1) {
				var problem_text = line.substring(17, line.string - 2);
				for (int i=0; i<problem_text.length; i++) {
					if(problem_text[i] == '\$' and problem_text[i+1] == '\$') {
						int count = 3;
						while(true) {
							if(problem_text[i+count] == '\$' and problem_text[i+count+1] == '\$') {
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
				problem_data.problem_text = problem_text;
			} else if (line.contains('点数:')) {
				var problem_point = line.substring(7, line.length-4);
				problem_data.problem_point = int.parse(problem_point);
		}
	} catch (e) {
		print('some error occured.');
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
