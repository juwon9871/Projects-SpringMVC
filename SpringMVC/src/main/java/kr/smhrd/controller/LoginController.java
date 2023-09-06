package kr.smhrd.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.smhrd.entity.Member;
import kr.smhrd.mapper.LoginMapper;

@Controller
public class LoginController {
	
	@Autowired
	private LoginMapper mapper;
	
	// 1. 로그인 요청을 처리
	@RequestMapping("/login.do") // username, password
	public String login(Member vo, HttpSession session) { // HttpSession session = request.getSession();
		
		Member mvo = mapper.login(vo);
		// 성공, 실패 여부 확인
		if (mvo != null) { // 성공 -> View(JSP,,,)
			session.setAttribute("mvo", mvo); // ${!empty mvo}
		}
		
		return "redirect:/list.do"; // 메인으로 돌아가기
	}
	
	// 2. 로그아웃 요청을 처리
	@RequestMapping("/logout.do")
	public String logout(HttpSession session) {
		
		session.invalidate();
		
		return "redirect:/list.do";
	}
	
}
