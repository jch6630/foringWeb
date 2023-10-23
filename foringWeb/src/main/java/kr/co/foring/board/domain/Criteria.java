package kr.co.foring.board.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Data;

@Data
public class Criteria {
	
	private int	pageNum;
	private int amount;
	
	private String categorymenu;
	private String keyword;
	
	public Criteria(){
		this(1,30);
	}
	
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	public String getListLink() {
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("pageNum", this.pageNum)
				.queryParam("amount", this.amount)
				.queryParam("categorymenu", this.categorymenu)
				.queryParam("keyword", this.keyword);
		return builder.toUriString();
	}
	
}
