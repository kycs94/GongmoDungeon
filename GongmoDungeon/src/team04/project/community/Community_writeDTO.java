package team04.project.community;

import java.sql.Timestamp;

public class Community_writeDTO {
	private int CMBoard_num;
	private String CMBoard_title;
	private String CMBoard_id;
	private String CMBoard_content;
	private int CMBoard_commCount;
	private int CMBoard_view;
	private Timestamp CMBoard_reg;
	
	public int getCMBoard_num() {
		return CMBoard_num;
	}
	public void setCMBoard_num(int cMBoard_num) {
		CMBoard_num = cMBoard_num;
	}
	public String getCMBoard_title() {
		return CMBoard_title;
	}
	public void setCMBoard_title(String cMBoard_title) {
		CMBoard_title = cMBoard_title;
	}
	public String getCMBoard_id() {
		return CMBoard_id;
	}
	public void setCMBoard_id(String cMBoard_id) {
		CMBoard_id = cMBoard_id;
	}
	public String getCMBoard_content() {
		return CMBoard_content;
	}
	public void setCMBoard_content(String cMBoard_content) {
		CMBoard_content = cMBoard_content;
	}
	public int getCMBoard_commCount() {
		return CMBoard_commCount;
	}
	public void setCMBoard_commCount(int cMBoard_commCount) {
		CMBoard_commCount = cMBoard_commCount;
	}
	public int getCMBoard_view() {
		return CMBoard_view;
	}
	public void setCMBoard_view(int cMBoard_view) {
		CMBoard_view = cMBoard_view;
	}
	public Timestamp getCMBoard_reg() {
		return CMBoard_reg;
	}
	public void setCMBoard_reg(Timestamp cMBoard_reg) {
		CMBoard_reg = cMBoard_reg;
	}
	
	
}
