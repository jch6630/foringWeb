package kr.co.foring.board.mapper;

import java.util.List;

import kr.co.foring.board.domain.BoardDTO;
import kr.co.foring.board.domain.Criteria;
import kr.co.foring.member.domain.MemberDTO;

public interface BoardMapper {
	public int getTotalCnt(Criteria cri);
	public List<BoardDTO> boardList(Criteria cri);
}
