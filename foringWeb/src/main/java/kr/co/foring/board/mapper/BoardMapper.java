package kr.co.foring.board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.co.foring.board.domain.BoardDTO;
import kr.co.foring.board.domain.Criteria;

@Mapper
public interface BoardMapper {
	public int getTotalCnt(@Param("cri")Criteria cri);
	public List<BoardDTO> boardList(@Param("cri")Criteria cri);
}
