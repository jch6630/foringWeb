package kr.co.foring.board.domain;

import java.sql.Date;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Data;

@Data
public class Criteria {
	
	private int	pageNum;
	private int amount;
	
	private String category;
	private String keyword;
	private String hotBoard;
	
	public Criteria(){
		this(1,30);
	}
	
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}

	public String getKeyword() {
		return keyword;
	}
	
	public String getListLink() {
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("pageNum", this.pageNum)
				.queryParam("amount", this.amount)
				.queryParam("category", this.category)
				.queryParam("keyword", this.keyword);
		return builder.toUriString();
	}
	
}
