use std::collections::HashMap;
use std::fs::File;
use std::io::prelude::*;
use std::io::{self, BufRead};
use std::path::Path;
fn main() {
    let contest_url = return_contest_url(135);
    let omc135 = search_problem_url(135, contest_url);



}

fn return_contest_url(contest_n: int) -> String {
    if contest_n < 10 {
        let url = "https://onlinemathcontest.com/contests/omc00" + contest_n.to_string() + "/tasks/";
        return url;
    } else if contest_n < 100 {
        let url = "https://onlinemathcontest.com/contests/omc00" + contest_n.to_string() + "/tasks/";
        return url;
    } else {
        let url = "https://onlinemathcontest.com/contests/omc00" + contest_n.to_string() + "/tasks/";
        return url;
    }
}

fn search_problem_url(contest_n: int, contest_url: String) -> HashMap<char, String> {
    let mut problem_url = HashMap::new();
    let mut count: int = 0;
    let mut contest_name = String::from("Hello! What are you doing here?");

    if contest_n < 10 {
        contest_name = "./omc00" + contest_n.to_string() + ".html";
    } else if contest_n < 100 {
        contest_name = "./omc0" + contest_n.to_string() + "html";
    } else {
        contest_name = "./omc" + contest_n.to_string() + ".html";
    }
   if let Ok(lines) = read_lines(contest_name) {
       for line in lines {
           if let Ok(ip) = line {





}

fn read_lines<P>(filename: P) -> io::Result<io::Lines<io::BufReader<File>>>
where P: AsRef<Path>, {
    let file = File::open(filename)?;
    Ok(io::BufReader::new(file).lines())
}
