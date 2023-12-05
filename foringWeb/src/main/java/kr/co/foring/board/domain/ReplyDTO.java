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
public class ReplyDTO {
	private int replyid;
	private int boardid;
	private String usernick;
	private String disclosure;
	private String replycontent;
	private Date replyregdate;
}
