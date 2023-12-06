package kr.co.foring.board.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Data
@ToString
public class ReReplyDTO {
	private int replyid;
	private int rereplyid;
	private String usernick;
	private String disclosure;
	private String rereplycontent;
	private Date rereplyregdate;
}
