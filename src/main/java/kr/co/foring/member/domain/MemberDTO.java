package kr.co.foring.member.domain;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Data
@ToString
public class MemberDTO {

	private String username;
	private String email;
	private String userpw;
	private String usernick;
	private String termsstr;
	private Timestamp regdate;
	private Timestamp updatedate;
}
