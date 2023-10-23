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
	public String boardlist(Criteria cri, String categorymenu, String result) throws Exception{
		log.info("list.......List<BoardDTO>.....................categorymenu : " + categorymenu + ".....cri : " + cri);
		List<BoardDTO> boardlist = service.boardlist(cri, categorymenu);
		
		Map<String, String> resultMap = new HashMap<>();
		
		String boardliststr = boardlist.toString();
		resultMap.put("list", boardliststr);
		log.info("boardliststr.............. " + boardliststr);
		
		int total = service.getTotalCnt(cri, categorymenu);
		
		log.info("total : " + total);
		PageDTO pageDto = new PageDTO(cri, total);
		String pagedtostr = pageDto.toString();
		log.info("pagedtostr ................... " + pagedtostr);
		
		resultMap.put("listMaker", pagedtostr);
		
		Gson gson = new GsonBuilder().create();
        result = gson.toJson(resultMap);
//		result = "{list : " + '"' + boardliststr + '"' + ", listMaker : " + '"' + pagedtostr + '"' + " }";
		log.info("result : " + result);
		return result;
	}
	
}
