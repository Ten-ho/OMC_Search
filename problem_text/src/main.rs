use std::collections::HashMap;
use std::fs::File;
use std::io::{self, BufRead};
use std::path::Path;
fn main() {
    let contest_url = return_contest_url(135);
    println!("{}", &contest_url);
    let omc135 = search_problem_url(135, contest_url);



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

fn search_problem_url(contest_n: i32, contest_url: String) -> HashMap<char, String> {
    let mut problem_url_map = HashMap::new();
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
                        problem_url_map.insert(problem_alphabet, problem_url);
                        count += 1;
                    }
                }
            }
        }
    }
    for (key, value) in &problem_url_map {
        println!("{}: {}", key, value);
    }
    return problem_url_map;


}

fn read_lines<P>(filename: P) -> io::Result<io::Lines<io::BufReader<File>>>
where P: AsRef<Path>, {
    let file = File::open(filename)?;
    Ok(io::BufReader::new(file).lines())
}
