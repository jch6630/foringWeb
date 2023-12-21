package kr.co.foring.board.service;

import java.util.List;

import kr.co.foring.board.domain.BoardDTO;
import kr.co.foring.board.domain.Criteria;
import kr.co.foring.board.domain.ReReplyDTO;
import kr.co.foring.board.domain.ReplyDTO;

public interface IBoardService {

	public List<BoardDTO> boardlist(Criteria cri) throws Exception;
	public int getTotalCnt(Criteria cri) throws Exception;
	public int getReplyTotalCnt(Integer bno, Criteria cri) throws Exception;
	public BoardDTO read(Integer bno) throws Exception;
	public List<ReplyDTO> reply(Integer bno, Criteria cri) throws Exception;
	public int viewCnt(Integer bno) throws Exception;
//	public void write(BoardDTO bDto) throws Exception;
	public int replyRegister(ReplyDTO rDto);
	public List<ReReplyDTO> rereply(Integer replyid);
	public int reReplyRegister(ReReplyDTO rrDto);
	
}
