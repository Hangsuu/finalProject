package com.kh.insider.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/attachment")
public class HomeController {

	@GetMapping("")
	public String home() {
		return "home";
	}
	
    // 임시 파일 업로드 주소
    @GetMapping("/file")
    public String file(){
        return "attachment/file";
    }

    // 임시 서머노트 & 파일 업로드 연계
    @GetMapping("/write")
    public String write(){
        return "attachment/write";
    }
}
