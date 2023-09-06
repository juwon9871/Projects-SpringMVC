package kr.smhrd.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.smhrd.entity.Board;
import kr.smhrd.entity.Criteria;
import kr.smhrd.entity.PageMaker;
import kr.smhrd.mapper.BoardMapper;

@Controller //POJO
public class BoardController {
	// @Inject
	@Autowired // 설명(DI : 의존성주입)
	private BoardMapper mapper;
	
	// 1.리스트 요청 처리 : /list.do --> boardList() : HandlerMapping(핸들러메핑)
	// 다른 컨트롤러에서든 어디서든 RequestMapping(네임)이 중복이 되면 안된다.
	@RequestMapping("/list.do") // get, post 둘 다 상관없이 받을 때
	public String list(Criteria cri, Model request) {
		List<Board> list = mapper.boardList(cri);
		
		request.addAttribute("list", list); // 객체바인딩(HttpServletRequest, HttpSession, ServletContext)
		// Model == HttpServletRequest
		
		// 페이징 처리 객체 생성하기
		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		pm.setTotalCount(mapper.totalCount(cri));
		request.addAttribute("pm", pm);
		
		return "boardList"; // forward방식(무조건 jsp로 이동) // 뷰의 논리적인 이름 --> 물리적인 위치로 변경(ViewResolver)
	}
	// 2-1. 게시글 등록 UI 요청 처리
	@GetMapping("/register.do")
	public String register() {
		return "register"; // /WEB-INF/views/register.jsp
	}
	
	// 2-2. 게시글 등록 요청 처리
	
	@PostMapping("/register.do") // register.jsp(등록화면) : title, content, writer
	public String register(Board vo) { // 파라미터 수집 할 메서드 작성
		
		mapper.boardInsert(vo); // 등록성공
		
		return "redirect:/list.do"; // redirect 방식으로 jsp가아닌 다른 컨트롤러에 보낼거면 redirect: 붙여줘야함
	}
	
	// 3. 게시글 상세보기 요청 처리
	@RequestMapping("/get.do") // ?num=?
	public String get(@ModelAttribute("cri") Criteria cri, int num, Model model) { // << 변수명을 바꿔서 받고싶으면 @RequestParam("num") 타입(int) 변수명(idx) // 알리아스 별칭
		
		Board vo = mapper.boardGet(num);
		model.addAttribute("vo", vo);
		// model.addAttribute("cri", cri); @ModelAttribute 어노테이션이랑 똑같음
		// 조회수 누적
		mapper.count(num);
		
		return "get"; //get.jsp 로 이동
	}
	
	// 4. 삭제 요청 처리
	@RequestMapping("/remove.do") // ?num=?&page=?
	public String remove(Criteria cri, int num, RedirectAttributes rttr) {
		
		mapper.boardDelete(num);
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/list.do";
	}
	
	// 5-1. 수정화면 요청 처리
	@GetMapping("/modify.do") // ?num=?&page=?
	public String modify(Criteria cri, int num, Model model) {
		
		Board vo = mapper.boardGet(num);
		model.addAttribute("vo", vo);
		model.addAttribute("cri", cri);
		
		return "modify"; // modify.jsp
	}
	// 5-2 수정하기 요청 처리
	@PostMapping("/modify.do") // num, title, content
	public String modify(Criteria cri, Board vo, RedirectAttributes rttr) { // ?key=value 형태를 만들어주는게 RedirectAttributes <<
		
		mapper.boardModify(vo);
		// 수정성공 -> 리스트 페이지로 이동(list.do)
		// 수정성공 -> 상세보기 페이지로 이동(get.do?num=?)
		// return "redirect:/list.do";
		rttr.addAttribute("num", vo.getNum()); // ?num=?
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/get.do"; 
	}
	
	// 6-1. 답글UI 요청 처리
	@GetMapping("/reply.do") // ?num=?
	public String reply(Criteria cri, int num, Model model) {
		
		Board pvo = mapper.boardGet(num); // 부모글
		model.addAttribute("pvo", pvo);
		model.addAttribute("cri", cri);
		
		return "reply"; //reply.jsp
	}
	
	// 6-2. 답글저장 요청 처리
	@PostMapping("/reply.do") // num(부모의넘버), [username, title, content, writer, bgroup, bseq, blevel]
	public String reply(Criteria cri, Board vo, RedirectAttributes rttr) {
		// 1. 부모글의 정보 가져오기
		Board pvo = mapper.boardGet(vo.getNum());
		
		// 2. 답글의 bgroup 설정
		vo.setBgroup(pvo.getBgroup());
		
		// 3. 답글의 bseq 설정
		vo.setBseq(pvo.getBseq()+1);
		
		// 4. 답글의 blevel 설정
		vo.setBlevel(pvo.getBlevel()+1);
		
		// 5. 부모의 bgroup과 같고 부모의 bseq보다 큰 답글의 bseq를 모두 1씩 증가
		mapper.replySeqUpdate(pvo);
		
		// 6. 답글저장
		mapper.replyInsert(vo);
		
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/list.do";
	}
	
	
}
