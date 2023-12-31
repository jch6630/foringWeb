package kr.co.foring.board.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.foring.board.domain.BoardDTO;
import kr.co.foring.board.domain.Criteria;
import kr.co.foring.board.domain.ReReplyDTO;
import kr.co.foring.board.domain.ReplyDTO;
import kr.co.foring.board.mapper.BoardMapper;
import kr.co.foring.board.service.IBoardService;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
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
		log.info("read 들어옴.............");
		return mapper.read(bno);
	}

	@Override
	public int viewCnt(Integer bno) throws Exception {
		log.info("viewCnt 들어옴.............");
		return mapper.viewCnt(bno);
	}

	@Override
	public List<ReplyDTO> reply(Integer bno, Criteria cri) throws Exception {
		return  mapper.reply(bno, cri);
	}

	@Override
	public int getReplyTotalCnt(Integer bno, Criteria cri) throws Exception {
		return mapper.getReplyTotalCnt(bno, cri);
	}

	@Override
	public int replyRegister(ReplyDTO rDto) {
		mapper.replyCnt(rDto);
		return mapper.replyRegister(rDto);
	}

	@Override
	public List<ReReplyDTO> rereply(Integer replyid) {
		return mapper.rereply(replyid);
	}

	@Override
	public int reReplyRegister(ReReplyDTO rrDto) {
		return mapper.reReplyRegister(rrDto);
	}

//	@Transactional
//	@Override
//	public void write(BoardDTO bDto) throws Exception {
//		mapper.insert(bDto);
//
//		if (bDto.getAttachList() == null || bDto.getAttachList().size() <= 0) {
//			return;
//		}
//
//		bDto.getAttachList().forEach(attach -> {
//			log.info("bDto ==================> " + bDto);
//			attach.setBno(bDto.getBno());
//			log.info("attach ==================> " + attach);
//			attachMapper.insert(attach);
//		});
//	}

}
