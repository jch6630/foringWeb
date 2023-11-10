package kr.co.foring;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import kr.co.foring.board.domain.BoardDTO;
import kr.co.foring.board.domain.Criteria;
import kr.co.foring.board.domain.PageDTO;
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
	public void main() {
		log.info("foring board Start....................");
		Logger.info("foring board Start..........................");
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
	public void read() throws Exception{
		log.info("read 페이지 들어옴..............");
	}
	
}
