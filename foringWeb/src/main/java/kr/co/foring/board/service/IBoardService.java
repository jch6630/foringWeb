package kr.co.foring.board.service;

import java.util.List;

import kr.co.foring.board.domain.BoardDTO;
import kr.co.foring.board.domain.Criteria;

public interface IBoardService {

	public List<BoardDTO> boardlist(Criteria cri, String categorymenu) throws Exception;
	public int getTotalCnt(Criteria cri, String categorymenu) throws Exception;
	
}