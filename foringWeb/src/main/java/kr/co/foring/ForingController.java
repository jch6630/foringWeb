package kr.co.foring;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.foring.board.domain.BoardDTO;
import kr.co.foring.board.domain.Criteria;
import kr.co.foring.board.service.IBoardService;
import kr.co.foring.member.domain.MemberDTO;
import kr.co.foring.member.service.IMemberService;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/foring")
@Log4j
public class ForingController {

	private static final Logger Logger = LoggerFactory.getLogger(ForingController.class);
	
	@Autowired
    private JavaMailSender mailSender;
	
	@Autowired
	private IMemberService service;
	@Autowired
	private IBoardService bService;
	
	@RequestMapping("/main")
	public void main() {
		log.info("foring Web Start....................");
		Logger.info("foring Web Start..........................");
	}
	
	@RequestMapping("/mainchat")
	public String chat(HttpServletRequest req) {
		log.info("[Controller] : mainchat");
//		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String usernick = req.getParameter("usernick");
		
		log.info("req ==================> " + req);
		log.info("usernick ==================> " + usernick);
		log.info("==================================");
		log.info("@ChatController, GET Chat / Usernick : " + usernick);
		return "redirect:/foring/main";
	}

	@RequestMapping("/join")
	public void join() {
		log.info("foring Web Join Start....................");
		Logger.info("foring Web Join Start....................");
	}
	
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public String joinPost(MemberDTO mDto, HttpSession session, Model model) {
		service.join(mDto);
		log.info("mDto ====> " + mDto);
		Logger.info("mDto ====> " + mDto);
		String returnURL = "";
		return returnURL;
	}
	
	@RequestMapping("/checkJoinNick")
	@ResponseBody
    public Integer checkJoinNickPost(HttpServletResponse res, HttpServletRequest req, Model model) {
		String usernick = req.getParameter("usernick");
		Integer checkJoinNickPostResult = service.joincheck(usernick);
        log.info("usernick ====> " + usernick);
		log.info("memInfo ====> " + checkJoinNickPostResult);
		Logger.info("memInfo ====> " + checkJoinNickPostResult);
		
        return checkJoinNickPostResult;
    }

	@RequestMapping(value="/mailCheck", method=RequestMethod.GET)
    @ResponseBody
    public String mailCheckGET(String email) throws Exception{
        
        /* 뷰(View)로부터 넘어온 데이터 확인 */
		Logger.info("이메일 데이터 전송 확인");
		Logger.info("email : " + email);
                
		/* 인증번호(난수) 생성 */
        Random random = new Random();
        int checkNum = random.nextInt(888888) + 111111;
//        int checkNum = 111111;
        Logger.info("인증번호 : " + checkNum);
        
        /* 이메일 보내기 */
        String setFrom = "jch6630@naver.com";
        String toMail = email;
        String title = "[Foring]회원가입 인증 이메일 입니다.";
        String content = "Foring에 방문해주셔서 감사합니다." +
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
	
	@RequestMapping(value="/domainCheck", method=RequestMethod.GET)
	@ResponseBody
	public boolean domainCheckGET(String domain) throws Exception{
		boolean domainCheck = false;
		/* 뷰(View)로부터 넘어온 데이터 확인 */
		Logger.info("이메일 데이터 전송 확인");
		Logger.info("email : " + domain);
		
		try{   
		     InetAddress ipaddress = InetAddress.getByName(domain);
		     System.out.println("IP address: " + ipaddress.getHostAddress());
		     domainCheck = true;
		     } catch ( UnknownHostException e )    {    
		       System.out.println("Could not find IP address for: " + domain);   
		     }
		
		return domainCheck;
		
	}
	
	@RequestMapping("/login")
	public void loginGet(@ModelAttribute("mDto") MemberDTO mDto) {
		log.info("foring Web login Start....................");
		Logger.info("foring Web login Start....................");
	}
	
	@RequestMapping(value = "/loginPost", method = RequestMethod.POST)
	public String loginPost(MemberDTO mDto, HttpSession session, Model model) {
		String returnURL = "";
		log.info("mDto ====> " + mDto);
		Logger.info("mDto ====> " + mDto);
		MemberDTO memInfo = service.login(mDto);
		log.info("memInfo ====> " + memInfo);
		Logger.info("memInfo ====> " + memInfo);
		if (memInfo == null) {
			MemberDTO memNotFound = new MemberDTO();
			memNotFound.setEmail("notFound");
			model.addAttribute("memNotFound", memNotFound);
			log.info("memNotFound ====> " + model);
			session.setAttribute("memInfo", null);
			return "foring/login";
		} 
		
		model.addAttribute("memInfo", memInfo);
		session.setAttribute("memInfo", memInfo);
		return returnURL;
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		log.info("logout........................");
		Object obj = session.getAttribute("login");
		
		if (obj != null) {
			session.removeAttribute("login");
			session.invalidate();
		}
		return "redirect:/foring/main";
	}
	
	@RequestMapping(value = "/hotBoardList", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, List<BoardDTO>> hotBoardList(Criteria cri) throws Exception {
		log.info("hotBoardList.......................");
		cri.setHotBoard("hotBoard");
		log.info("cri : " + cri);
		Map<String, List<BoardDTO>> result = new HashMap<>();
		result.put("list", bService.boardlist(cri));
		log.info("result : " + result);
		return result;
	}
	
}
