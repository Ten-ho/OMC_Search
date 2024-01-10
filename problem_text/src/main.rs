use std::collections::HashMap;
use std::char::from_u32;
//use anyhow::Result;
use std::fs::File;
use std::io::{self, BufRead};
use std::path::Path;
fn main() {
    let contest_url = return_contest_url(135);
    println!("{}", &contest_url);
    let mut problem_url_map = HashMap::new();
    search_problem_url(135, contest_url, problem_url_map);
    //download_file(problem_url_map.get(135A));
    search_word_in_sentence(String::from("omc135A.html"), String::from("const content"));


}

fn return_contest_url(contest_n: i32) -> String {
    if contest_n < 10 {
        let url = "https://onlinemathcontest.com/contests/omc00".to_string() + &contest_n.to_string() + "/tasks/";
        return url;
    } else if contest_n < 100 {
        let url = "https://onlinemathcontest.com/contests/omc0".to_string() + &contest_n.to_string() + "/tasks/";
        return url;
    } else {
        let url = "https://onlinemathcontest.com/contests/omc".to_string() + &contest_n.to_string() + "/tasks/";
        return url;
    }
}

fn search_problem_url(contest_n: i32, contest_url: String, mut problem_url_map:HashMap<String,String>) {
    let mut count: i32 = 0;
    let mut contest_name = String::from("Hello! What are you doing here?");


    if contest_n < 10 {
        contest_name = "../../omc_files/omc00".to_string() + &contest_n.to_string() + ".html";
    } else if contest_n < 100 {
        contest_name = "../../omc_files/omc0".to_string() + &contest_n.to_string() + "html";
    } else {
        contest_name = "../../omc_files/omc".to_string() + &contest_n.to_string() + ".html";
    }
    println!("{}", &contest_name);
    
    
    if let Ok(lines) = read_lines(contest_name) {
        println!("file reading...");
        for line in lines {
            if let Ok(ip) = line {
                if let Some(index) = ip.find(&contest_url) {
                //a line contains url
                    let problem_url = &ip[index..];
                    let mut problem_url = problem_url.to_string();
                    let length = problem_url.len();
                    problem_url.truncate(length - 2);
                    let end_char: &String = &problem_url.chars().skip(problem_url.len().saturating_sub(1)).collect();
                    if end_char != "\"" {
                        let problem_alphabet: i32 = 65 + count;
                        let problem_alphabet = problem_alphabet as u8 as char;
                        let problem_address = contest_n.to_string() + &problem_alphabet.to_string();
                        problem_url_map.insert(problem_address, problem_url);
                        count += 1;
                    }
                }
            }
        }
    }
    for (key, value) in &problem_url_map {
        println!("{}: {}", key, value);
    }


}

fn read_lines<P>(filename: P) -> io::Result<io::Lines<io::BufReader<File>>>
where P: AsRef<Path>, {
    let file = File::open(filename)?;
    Ok(io::BufReader::new(file).lines())
}
/*
#[tokio::main]
async fn download_file(url: String) -> Result<()> {
    let filename = url.split("/").last().unwrap();
    let response: reqwest::Response = reqwest::get(url).await?;
    let bytes = response.bytes().await?;
    let mut out = File::create(filename)?;
    io::copy(&mut bytes.as_ref(), &mut out)?;

    Ok(())
}
*/
fn search_word_in_sentence(filepath: String, search_word: String){
    if let Ok(lines) = read_lines(filepath) {
        for line in lines {
            if let Ok(ip) = line {
                if let Some(index) = ip.find(&search_word) {
                    let mut count = 0;
                    let content = &ip[index..];
                    let mut content_string = content.to_string();
                    println!("{}", &content);
                    while(true) {
                        let capital_content = content.get(count..count+1);
                        if capital_content == Some("\\") {
                            break;
                        }
                        count += 1;
                    }
                    println!("{}", count);
                    let content = &content[count..];
                    let mut content_string = content.to_string();
                    content_string.pop();
                    content_string.pop();
                    println!("{}", &content_string);
                    //from_u32(content)
                }
            }
        }
    }
}
