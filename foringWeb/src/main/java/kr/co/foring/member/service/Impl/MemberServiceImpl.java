package kr.co.foring.member.service.Impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.foring.member.domain.MemberDTO;
import kr.co.foring.member.mapper.MemberMapper;
import kr.co.foring.member.service.IMemberService;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class MemberServiceImpl implements IMemberService{

	@Autowired
	private MemberMapper mapper;
	

	@Override
	public void join(MemberDTO mDto) {
		// TODO Auto-generated method stub
		mapper.join(mDto);
	}
	
	@Override
	public Integer joincheck(String usernick) {
		MemberDTO mDto = new MemberDTO();
		mDto.setUsernick(usernick);
		log.info("mDto MemberServiceImpl ====>" + mDto);
		log.info("joincheck MemberServiceImpl ====>" + mapper.joincheck(mDto));
		return mapper.joincheck(mDto);
	}
	
	@Override
	public MemberDTO login(MemberDTO mDto) {
		log.info("login service impl 진입...........");
		log.info("login service impl 매개변수값 : " + mDto + "...........");
//		MemberDTO sermDto = mapper.login(mDto);
		log.info("login service impl 반환값 : " + mapper.login(mDto) + "...........");
		return null;
	}

}
