package kr.co.foring;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import kr.co.foring.board.domain.BoardDTO;
import kr.co.foring.board.domain.Criteria;
import kr.co.foring.board.domain.PageDTO;
import kr.co.foring.board.domain.ReplyDTO;
import kr.co.foring.board.service.IBoardService;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/foring")
@Log4j
public class BoardController {

	private static final Logger Logger = LoggerFactory.getLogger(BoardController.class);
	
	@Autowired
	private IBoardService service;
	
	@RequestMapping("/board")
	public void main(@RequestParam("categorymenu") String categorymenu, Model model) {
		log.info("foring board Start....................");
		Logger.info("foring board Start..........................");
		model.addAttribute("categorymenu", categorymenu);
	}
	
	@RequestMapping(value = "/boardlist", method = RequestMethod.POST)
	@ResponseBody
	public String boardlist(Criteria cri, @RequestParam Map<String, Object> requestParam, String result) throws Exception{
		
		String categorymenu = (String) requestParam.get("categorymenu");
		String keyword = (String) requestParam.get("content");
		int pageNum = Integer.parseInt((String)requestParam.get("nowPageNum"));
		
		cri.setPageNum(pageNum);
		cri.setCategorymenu(categorymenu);
		cri.setKeyword(keyword);
		
		log.info("list.......List<BoardDTO>.....................categorymenu : " + categorymenu + ".....cri : " + cri);
		List<BoardDTO> boardlist = service.boardlist(cri);
		
		Gson gson = new GsonBuilder().create();
		Map<String, String> resultMap = new HashMap<>();
		
		String boardlistgson = gson.toJson(boardlist);
		
		resultMap.put("list", boardlistgson);
		log.info("boardlistgson.............. " + boardlistgson);
		
		int total = service.getTotalCnt(cri);
		
		log.info("total : " + total);
		PageDTO pageDto = new PageDTO(cri, total);
		String pagedtogson = gson.toJson(pageDto);
		log.info("pagedtogson ................... " + pagedtogson);
		
		resultMap.put("listMaker", pagedtogson);
		
        result = gson.toJson(resultMap);
		log.info("result : " + result);
		
		return result;
	}
	
	@RequestMapping(value = "/read", method = RequestMethod.GET)
	public void read(@RequestParam("bno") int bno, @ModelAttribute("cri") Criteria cri, Model model) throws Exception{
		log.info("read 페이지 들어옴..............");
		service.viewCnt(bno);
		model.addAttribute("read", service.read(bno));
	}
	
	@RequestMapping(value = "/reply", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> reply(@RequestParam("bno") int bno, @RequestParam("nowPageNum") int pageNum) throws Exception{
		log.info("reply 페이지 들어옴..............");
		log.info("bno : " + bno);
		Map<String, Object> result = new HashMap<>();
		
		Criteria cri = new Criteria();
		cri.setPageNum(pageNum);
		cri.setAmount(10);
		
		result.put("reply", service.reply(bno, cri));
		int total = service.getReplyTotalCnt(bno,cri);
		
		log.info("total : " + total);
		PageDTO pageDto = new PageDTO(cri, total);
		result.put("listMaker", pageDto);
		
		log.info(result);
		return result;
	}
	
	@RequestMapping(value = "/replyRegister", method = RequestMethod.POST)
	@ResponseBody
	public int replyRegister(ReplyDTO rDto) throws Exception{
		log.info("reply 작성중..............");
		log.info("rDto : " + rDto);
		
		int result = service.replyRegister(rDto);
		log.info(result);
		return result;
	}
	
	@RequestMapping(value = "/write", method = RequestMethod.GET)
	public void write() throws Exception{
		log.info("write 페이지 들어옴..............");
	}
	
	@RequestMapping(value = "/write", method = RequestMethod.POST)
	public String registerPost(BoardDTO bDto, RedirectAttributes rttr) throws Exception{
		log.info("write post............");
		
//		log.info("register : " + bDto);
//		
//		if (bDto.getAttachList() != null) {
//			bDto.getAttachList().forEach(attach -> log.info(attach));
//		}
//
////		service.register(bDto);
//		
//		rttr.addFlashAttribute("result", bDto.getBoardid());
		
		return "redirect:/foring/boardlist";
	}
	
}
