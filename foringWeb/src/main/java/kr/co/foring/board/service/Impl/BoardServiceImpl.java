package kr.co.foring.board.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.foring.board.domain.BoardDTO;
import kr.co.foring.board.domain.Criteria;
import kr.co.foring.board.mapper.BoardMapper;
import kr.co.foring.board.service.IBoardService;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class BoardServiceImpl implements IBoardService {

	@Autowired
	private BoardMapper mapper;

	@Override
	public List<BoardDTO> boardlist(Criteria cri, String categorymenu) throws Exception {
		log.info("servicecategorymenu ====================>" + categorymenu);
		// TODO Auto-generated method stub
		return mapper.boardList(cri, categorymenu);
	}

	@Override
	public int getTotalCnt(Criteria cri, String categorymenu) throws Exception {
		// TODO Auto-generated method stub
		return mapper.getTotalCnt(cri, categorymenu);
	}
	
}
