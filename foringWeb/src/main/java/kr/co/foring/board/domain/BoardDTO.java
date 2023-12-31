package kr.co.foring.board.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Data
@ToString
public class BoardDTO {

	private Integer boardid;
	private String category;
	private String usernick;
	private String disclosure;
	private String boardpw;
	private String boardtitle;
	private String boardcontent;
	private int viewCnt;
	private int likeCnt;
	private Integer replyCnt;
	private List<BoardAttachDTO> attachList;
	
}
