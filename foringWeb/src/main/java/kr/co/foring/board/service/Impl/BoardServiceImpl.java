package kr.co.foring.board.service.Impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import kr.co.foring.board.domain.BoardDTO;
import kr.co.foring.board.domain.Criteria;
import kr.co.foring.board.mapper.BoardMapper;
import kr.co.foring.board.service.IBoardService;

public class BoardServiceImpl implements IBoardService {

	@Autowired
	private BoardMapper mapper;

	@Override
	public List<BoardDTO> listAll(Criteria cri) throws Exception {
		// TODO Auto-generated method stub
		return mapper.boardList(cri);
	}

	@Override
	public int getTotalCnt(Criteria cri) throws Exception {
		// TODO Auto-generated method stub
		return mapper.getTotalCnt(cri);
	}
	
}
