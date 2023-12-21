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

import kr.co.foring.board.domain.BoardDTO;
import kr.co.foring.board.domain.Criteria;
import kr.co.foring.board.domain.PageDTO;
import kr.co.foring.board.domain.ReReplyDTO;
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
	
	@RequestMapping(value = "/board", method = RequestMethod.POST)
	public void main(@RequestParam("category") String category, Model model) {
		log.info("foring board Start....................");
		Logger.info("foring board Start..........................");
		model.addAttribute("category", category);
	}
	
	@RequestMapping(value = "/boardlist", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> boardlist(Criteria cri, @RequestParam Map<String, Object> requestParam, String result) throws Exception{
		
		String category = (String) requestParam.get("category");
		String keyword = (String) requestParam.get("content");
		int pageNum = Integer.parseInt((String)requestParam.get("nowPageNum"));
		
		cri.setPageNum(pageNum);
		cri.setCategory(category);
		cri.setKeyword(keyword);
		
		log.info("list.......List<BoardDTO>.....................category : " + category + ".....cri : " + cri);
		List<BoardDTO> boardlist = service.boardlist(cri);
		
//		Gson gson = new GsonBuilder().create();
		Map<String, Object> resultMap = new HashMap<>();
		
//		String boardlistgson = gson.toJson(boardlist);
		
		resultMap.put("list", boardlist);
		log.info("boardlist.............. " + boardlist);
		
		int total = service.getTotalCnt(cri);
		
		log.info("total : " + total);
		PageDTO pageDto = new PageDTO(cri, total);
//		String pagedtogson = gson.toJson(pageDto);
		log.info("pageDto ................... " + pageDto);
		
		resultMap.put("listMaker", pageDto);
		
//        result = gson.toJson(resultMap);
		log.info("resultMap : " + resultMap);
		
		return resultMap;
	}

	@RequestMapping(value = "/read", method = RequestMethod.GET)
	public void read(@RequestParam("bno") int bno, @ModelAttribute("cri") Criteria cri, Model model) throws Exception{
		log.info("read 페이지 들어옴..............");
		int viewCntResult = service.viewCnt(bno);
		log.info("viewCntResult : "+viewCntResult);
		model.addAttribute("read", service.read(bno));
		log.info("model : "+model);
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
	
	@RequestMapping(value = "/rereply", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> rereply(@RequestParam("replyid") Integer replyid) throws Exception{
		log.info("rereply 페이지 들어옴..............");
		log.info("replyid : " + replyid);
		Map<String, Object> result = new HashMap<>();
		
		result.put("rereply", service.rereply(replyid));
		
		log.info(result);
		return result;
	}
	@RequestMapping(value = "/reReplyRegister", method = RequestMethod.POST)
	@ResponseBody
	public int reReplyRegister(ReReplyDTO rrDto) throws Exception{
		log.info("reReply 작성중..............");
		log.info("rrDto : " + rrDto);
		
		int result = service.reReplyRegister(rrDto);
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
