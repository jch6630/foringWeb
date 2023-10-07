package kr.co.foring.member.mapper;

import kr.co.foring.member.domain.MemberDTO;

public interface MemberMapper {
	
	public void join(MemberDTO memberDto);
	public Integer joincheck(MemberDTO mDto);
	public MemberDTO login(MemberDTO memberDto);
	
}
