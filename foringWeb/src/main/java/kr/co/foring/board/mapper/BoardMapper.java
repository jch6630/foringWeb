package kr.co.foring.board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.co.foring.board.domain.BoardDTO;
import kr.co.foring.board.domain.Criteria;
import kr.co.foring.board.domain.ReReplyDTO;
import kr.co.foring.board.domain.ReplyDTO;

@Mapper
public interface BoardMapper {
	public int getTotalCnt(@Param("cri")Criteria cri);
	public int getReplyTotalCnt(@Param("bno")Integer bno, @Param("cri")Criteria cri);
	public List<BoardDTO> boardList(@Param("cri")Criteria cri);
	public BoardDTO read(@Param("bno")Integer bno);
	public List<ReplyDTO> reply(@Param("bno")Integer bno, @Param("cri")Criteria cri);
	public void insert(@Param("bDto")BoardDTO bDto);
	public void viewCnt(@Param("bno")Integer bno);
	public int replyRegister(ReplyDTO rDto);
	public List<ReReplyDTO> rereply(@Param("replyid")Integer replyid);
	public int reReplyRegister(ReReplyDTO rrDto);
}
