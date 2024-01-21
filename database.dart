import 'dart:io';
void main() {
    var contest_url = return_contest_url(135);
    print("$contest_url");
    Map<String, String>  problem_url_map = {};
    search_problem_url(135, contest_url, problem_url_map);
    //download_file(problem_url_map.get(135A));
    var content_unicode = search_word_in_sentence("omc135A.html",　"const content");
    content = unicode_to_readable(content_unicode);
    print("This is content_readable:$content");


}

String return_contest_url(int contest_n) {
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
}

void search_problem_url(contest_n: i32, contest_url: String, mut problem_url_map:HashMap<String,String>) {
    int count = 0;
    String contest_name = "Hello! What are you doing here?";


    if (contest_n < 10) {
        contest_name = "../../omc_files/omc00" + contest_n + ".html";
    } else if (contest_n < 100) {
        contest_name = "../../omc_files/omc0" + contest_n + "html";
    } else {
        contest_name = "../../omc_files/omc" + contest_n + ".html";
    }
    print("$contest_name");
    
    
    if var Ok(lines) = read_lines(contest_name) {
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
/*
#[tokio::main]
async fn download_file(url: String) -> Result<()> {
    var filename = url.split("/").last().unwrap();
    var response: reqwest::Response = reqwest::get(url).await?;
    var bytes = response.bytes().await?;
    var mut out = File::create(filename)?;
    io::copy(&mut bytes.as_ref(), &mut out)?;

    Ok(())
}
*/
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
