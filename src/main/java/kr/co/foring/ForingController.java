package kr.co.foring;

import java.net.InetAddress;
import java.net.UnknownHostException;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

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
	
	@RequestMapping("/main")
	public void main() {
		log.info("foring Web Start....................");
		Logger.info("foring Web Start..........................");
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
//        Random random = new Random();
        int checkNum = 111111;
//        int checkNum = random.nextInt(888888) + 111111;
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
	public void login() {
		log.info("foring Web login Start....................");
		Logger.info("foring Web login Start....................");
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String loginPost(MemberDTO mDto, HttpSession session, Model model) {
		service.join(mDto);
		log.info("mDto ====> " + mDto);
		Logger.info("mDto ====> " + mDto);
		String returnURL = "";
		return returnURL;
	}
	
}
