package team04.project.community;

import java.sql.Timestamp;

public class Community_reviewWriteDTO {
	private int Review_num;
	private String Review_targetGM;
	private String Review_id;
	private String Review_title;
	private String Review_content;
	private String Review_file;
	private int Review_view;
	private Timestamp Review_reg;
	
	public int getReview_num() {
		return Review_num;
	}
	public void setReview_num(int review_num) {
		Review_num = review_num;
	}
	public String getReview_targetGM() {
		return Review_targetGM;
	}
	public void setReview_targetGM(String review_targetGM) {
		Review_targetGM = review_targetGM;
	}
	public String getReview_id() {
		return Review_id;
	}
	public void setReview_id(String review_id) {
		Review_id = review_id;
	}
	public String getReview_title() {
		return Review_title;
	}
	public void setReview_title(String review_title) {
		Review_title = review_title;
	}
	public String getReview_content() {
		return Review_content;
	}
	public void setReview_content(String review_content) {
		Review_content = review_content;
	}
	public String getReview_file() {
		return Review_file;
	}
	public void setReview_file(String review_file) {
		Review_file = review_file;
	}
	public int getReview_view() {
		return Review_view;
	}
	public void setReview_view(int review_view) {
		Review_view = review_view;
	}
	public Timestamp getReview_reg() {
		return Review_reg;
	}
	public void setReview_reg(Timestamp review_reg) {
		Review_reg = review_reg;
	}
	
}
