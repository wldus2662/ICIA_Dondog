package com.dondog.dbapp;

import java.util.List;

import java.util.Map;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dondog.dbapp.dto.FileDto;
import com.dondog.dbapp.dto.HostMemberDto;
import com.dondog.dbapp.dto.MemberDto;
import com.dondog.dbapp.service.HostMemberService;
import com.dondog.dbapp.service.MemberService;
import com.dondog.dbapp.service.PetMemberService;


@Controller
public class HomeController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@Autowired
	private MemberService mServ;
	@Autowired
	private PetMemberService pmServ;

	@Autowired
	private HostMemberService hostServ;

	private ModelAndView mv;

	@GetMapping("/")
	public String home() {
		logger.info("home()");

		return "home";
	}

	@GetMapping("/mainCP")
	public ModelAndView homecp() {
		logger.info("mainCP()");
		mv = new ModelAndView();
		//모델 데이터 담기
		mv.addObject("mainsle", 1);
		//뷰 이름 지정하기
		mv.setViewName("mainCP");

		return mv;
	}

	@GetMapping("main")
	public ModelAndView main_go() {
		logger.info("main()");

		mv = new ModelAndView();
		//모델 데이터 담기
		mv.addObject("mainsle", 0);
		//뷰 이름 지정하기
		mv.setViewName("main");

		return mv;
	}

	@GetMapping("petsitterres")
	public String petsitterres() {
		logger.info("pet_sitter_res()");

		return "pet_sitter_res";
	}

	@GetMapping("loginFrm")
	public String loginFrm() {
		logger.info("loginFrm()");

		return "loginFrm";
	}



	@PostMapping("login")
	public String loginProc(MemberDto member, 
			RedirectAttributes rttr) {
		logger.info("loginProc()");

		String view = mServ.loginProc(member, rttr);		
		return view;		
	}

	@GetMapping("logout")
	public String logout() {
		return mServ.logout();
	}

	@GetMapping("HostJoin")
	public String searchHt() {
		logger.info("HostJoin()");

		return "HostJoin";
	}

	@GetMapping(value = "hidCheck", produces = "application/text; charset=utf-8")
	@ResponseBody
	public String hidCheck(String hid) {
		logger.info("hidCheck() hid: " + hid);

		String result = hostServ.hidCheck(hid);

		return result;
	}
	//업체명 중복 확인
	@GetMapping(value="hbusinCheck", produces="application/text; charset=utf-8")
	@ResponseBody
	public String hbusinCheck(String hbusin) {
		logger.info("hbusinCheck() hbusin:"+hbusin);
		String result = hostServ.hbusinCheck(hbusin);
		return result;
	}
	//이메일 중복 확인
	@GetMapping(value="hemailCheck", produces="application/text; charset=utf-8")
	@ResponseBody
	public String hemailCheck(String hemail) {
		logger.info("hemailCheck() hemail:"+hemail);
		String result = hostServ.hemailCheck(hemail);
		return result;
	}

	@PostMapping("hostInsert")
	public String hostInsert(HostMemberDto host, RedirectAttributes rttr) {
		logger.info("hostInsert()");

		String view = hostServ.hostInsert(host, rttr);

		return view;
	}

	@GetMapping("hloginFrm")
	public String hloginFrm() {
		logger.info("loginFrm()");

		return "hloginFrm";
	}


	@PostMapping("hlogin")
	public String hloginProc(HostMemberDto host, RedirectAttributes rttr) {
		logger.info("hloginProc()");

		String view  = hostServ.hloginProc(host, rttr);
		return view;
	}

	/* 회원 가입 */
	//회원가입 선택 페이지 이동
	@GetMapping("joinSelect")
	public String joinSelect() {
		logger.info("joinSelect()");

		return "joinSelect";
	}
	//회원가입(일반)기본양식 페이지 이동
	@GetMapping("joinFrm")
	public String joinFrm() {
		logger.info("joinFrm()");

		return "joinFrm";
	}
	//회원가입 반려동물 등록 양식 페이지 이동
	@GetMapping("joinFrm_pet")
	public String joinFrm_pet(HttpServletRequest request) {
		logger.info("joinFrm_pet()");
		String referer = request.getHeader("referer");
		logger.info(referer);
		return "joinFrm_pet";
	}
	//아이디 중복 확인
	@GetMapping(value="idCheck", produces="application/text; charset=utf-8")
	@ResponseBody
	public String idCheck(String mid) {
		logger.info("idCheck() id:"+mid);
		String result = mServ.idCheck(mid);
		return result;
	}
	//닉네임 중복 확인
	@GetMapping(value="name2Check", produces="application/text; charset=utf-8")
	@ResponseBody
	public String name2Check(String mname2) {
		logger.info("name2Check() mname2:"+mname2);
		String result = mServ.name2Check(mname2);
		return result;
	}
	//이메일 중복 확인
	@GetMapping(value="emailCheck", produces="application/text; charset=utf-8")
	@ResponseBody
	public String emailCheck(String memail) {
		logger.info("emailCheck() id:"+memail);
		String result = mServ.emailCheck(memail);
		return result;
	}
	//회원가입 - 기본 정보 입력
	@PostMapping("memInsert")
	public String memInsert(MemberDto member, 
			RedirectAttributes rttr) {
		logger.info("memInsert()");

		String view = mServ.memberInsert(member, rttr);

		return view; 
	}

	//회원가입 - 반려동물 정보 입력
	@PostMapping("petInsert")
	public String petInsert(MultipartHttpServletRequest petmulti, RedirectAttributes rttr) {
		logger.info("controll.petInsert()");
		String view = pmServ.petInsert(petmulti, rttr);

		return view;
	}
	//펫시터 등록 페이지이동
	@GetMapping("pet_sitter_apply")
	public String pet_sitter_apply() {
		logger.info("pet_sitter_apply()");

		return "pet_sitter_apply";
	}
	/////////////////////////////////////////////////////////////////////////////


	//기본 정보 가져오기 
	@GetMapping("myInfoData")
	public ModelAndView myInfoData(String m_id) {
		logger.info("myInfo()-m_id: " +m_id);
		mv = mServ.getMemberInfo(m_id);

		return mv;
	}
	//내 정보 확인 페이지 이동
	@GetMapping("myInfo")
	public String myInfo() {
		logger.info("myInfo()");

		return "myInfo";
	}

	//내 정보 수정 페이지로 이동 & 수정할 게시글 불러오기
	@GetMapping("myInfo_upFrm")
	public ModelAndView updateFrm(String m_id, RedirectAttributes rttr) {
		logger.info("updateFrm()-m_id : " +m_id);
		mv = mServ.myInfo_updateFrm(m_id, rttr);
		return mv;
	}

	//기본 정보 수정 처리
	@PostMapping("myInfoUpdate")
	public String myInfoUpdate(MemberDto member,
			RedirectAttributes rttr) {
		String view= mServ.myInfoUpdate(member, rttr);

		return view;
	}

	/////////////////////////////////////////////////////////////////////////////////
	/* 반려동물 정보 수정 */
	//반려동물 정보 가져오기 
	@GetMapping("petInfoData")
	public ModelAndView petInfoData(String p_pid) {
		logger.info("petInfo()-p_pid: " +p_pid);
		mv = pmServ.getPetInfo(p_pid);

		return mv;
	}
	//반려동물 정보 리스트 보기	
	@GetMapping("petInfoList")
	public ModelAndView petInfoList() {
		logger.info("petInfoList()");
		mv = pmServ.petInfoList();

		return mv;
	}
	//내 반려동물 정보 확인 페이지 이동
	@GetMapping("petInfo")
	public String petInfo() {
		logger.info("petInfo()");

		return "petInfo";
	}

	//내 반려동물 수정 페이지로 이동 & 수정할 게시글 불러오기
	@GetMapping("petInfo_upFrm")
	public ModelAndView pet_updateFrm(String p_pid, RedirectAttributes rttr) {
		logger.info("petInfo_updateFrm()-p_pid : " +p_pid);
		mv = pmServ.petInfo_updateFrm(p_pid, rttr);
		return mv;
	}

	//반려동물 정보 수정 처리
	@PostMapping("petInfoUpdate")
	public String petInfoUpdate(MultipartHttpServletRequest multi,
			RedirectAttributes rttr) {
		String view= pmServ.petInfoUpdate(multi, rttr);

		return view;
	}
	//개별 파일 삭제
	@PostMapping(value = "delfile",
			produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, List<FileDto>> delFile(String sysname, String p_pid) {
		Map<String, List<FileDto>> rMap = null;

		rMap = pmServ.fileDelete(sysname, p_pid);

		return rMap;
	}
	///////////////////////////////////////////////////////////////////////////////
	@GetMapping("myMain")
	public String myMain() {
		logger.info("myMain()");

		return "myMain";
	}

	@GetMapping("mgInfo")
	public String mgInfo() {
		logger.info("mgInfo()");

		return "mgInfo";
	}
	/////////////////////////////////////////////////////////////////0201추가
	@GetMapping("myQuit")
	public String myQuit (String m_id, RedirectAttributes rttr) {
		String view = mServ.myQuit(m_id, rttr);
		return view;
	}
	////////////////////////////////////////////////////////////////0209추가
	@Autowired
	private JavaMailSender mailSender;

	/* 이메일 인증 */
	@RequestMapping(value="/mailCheck", method=RequestMethod.GET)
	@ResponseBody
	public String mailCheckGET(String email) throws Exception{

		/* 뷰(View)로부터 넘어온 데이터 확인 */
		logger.info("이메일 데이터 전송 확인");
		logger.info("이메일 : " + email);

		/* 인증번호(난수) 생성 */
		Random random = new Random();
		int checkNum = random.nextInt(888888) + 111111;
		logger.info("인증번호 " + checkNum);

		/* 이메일 보내기 */
		String setFrom = "dondog12341234@gmail.com";
		String toMail = email;
		String title = "[DonDog] 회원가입 인증 이메일 입니다.";
		String content = 
				"DonDog 홈페이지를 방문해주셔서 감사합니다." +
						"<br><br>" + 
						"인증 번호는 " + checkNum + "입니다." + 
						"<br>" + 
						"해당 인증번호를 인증번호 확인란에 기입하여 주세요.";		

		try {

			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
			helper.setFrom(setFrom);
			helper.setTo(toMail);
			helper.setSubject(title);
			helper.setText(content,true);
			mailSender.send(message);

		}catch(Exception e) {
			e.printStackTrace();
		}		

		String num = Integer.toString(checkNum);

		return num;

	}	

}
