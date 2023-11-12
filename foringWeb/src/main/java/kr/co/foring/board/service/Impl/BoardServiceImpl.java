package kr.co.foring.board.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.foring.board.domain.BoardDTO;
import kr.co.foring.board.domain.Criteria;
import kr.co.foring.board.mapper.BoardMapper;
import kr.co.foring.board.service.IBoardService;

@Service
public class BoardServiceImpl implements IBoardService {

	@Autowired
	private BoardMapper mapper;

	@Override
	public List<BoardDTO> boardlist(Criteria cri) throws Exception {
		return mapper.boardList(cri);
	}

	@Override
	public int getTotalCnt(Criteria cri) throws Exception {
		return mapper.getTotalCnt(cri);
	}
	
	@Override
	public BoardDTO read(Integer bno) throws Exception {
		return mapper.read(bno);
	}
	
}
