package kr.co.foring;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.foring.member.service.IMemberService;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/foring")
@Log4j
public class BoardController {

	private static final Logger Logger = LoggerFactory.getLogger(BoardController.class);
	
	@Autowired
	private IMemberService service;
	
	@RequestMapping("/board")
	public void main() {
		log.info("foring board Start....................");
		Logger.info("foring board Start..........................");
	}
	
}
