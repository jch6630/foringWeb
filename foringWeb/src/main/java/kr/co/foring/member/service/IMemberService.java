package kr.co.foring.member.service;

import kr.co.foring.member.domain.MemberDTO;

public interface IMemberService {
	public void join(MemberDTO mDto);
	public Integer joincheck(String usernick);
	public MemberDTO login(MemberDTO mDto);
}
