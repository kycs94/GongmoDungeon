package team04.project.gongmo;

import java.sql.Timestamp;

public class GongmoWriteDTO {

	private int gmboard_num, gmboard_view;
	private String gmboard_title, gmboard_id,gmboard_name ,gmboard_favor, gmboard_target, gmboard_winner, gmboard_benefit, gmboard_money, gmboard_content, gmboard_url, gmboard_type,gmboard_poster, gmboard_file,gmboard_sday, gmboard_eday;
	public String getGmboard_type() {
		return gmboard_type;
	}
	public void setGmboard_type(String gmboard_type) {
		this.gmboard_type = gmboard_type;
	}
	public String getGmboard_id() {
		return gmboard_id;
	}
	public void setGmboard_id(String gmboard_id) {
		this.gmboard_id = gmboard_id;
	}
	public String getGmboard_url() {
		return gmboard_url;
	}
	public void setGmboard_url(String gmboard_url) {
		this.gmboard_url = gmboard_url;
	}
	private Timestamp gmboard_reg;
	public int getGmboard_num() {
		return gmboard_num;
	}
	public void setGmboard_num(int gmboard_num) {
		this.gmboard_num = gmboard_num;
	}
	public int getGmboard_view() {
		return gmboard_view;
	}
	public String getGmboard_name() {
		return gmboard_name;
	}
	public void setGmboard_name(String gmboard_name) {
		this.gmboard_name = gmboard_name;
	}
	public void setGmboard_view(int gmboard_view) {
		this.gmboard_view = gmboard_view;
	}
	public String getGmboard_title() {
		return gmboard_title;
	}
	public void setGmboard_title(String gmboard_title) {
		this.gmboard_title = gmboard_title;
	}
	public String getGmboard_favor() {
		return gmboard_favor;
	}
	public void setGmboard_favor(String gmboard_favor) {
		this.gmboard_favor = gmboard_favor;
	}
	public String getGmboard_target() {
		return gmboard_target;
	}
	public void setGmboard_target(String gmboard_target) {
		this.gmboard_target = gmboard_target;
	}
	public String getGmboard_winner() {
		return gmboard_winner;
	}
	public void setGmboard_winner(String gmboard_winner) {
		this.gmboard_winner = gmboard_winner;
	}
	public String getGmboard_benefit() {
		return gmboard_benefit;
	}
	public void setGmboard_benefit(String gmboard_benefit) {
		this.gmboard_benefit = gmboard_benefit;
	}
	public String getGmboard_money() {
		return gmboard_money;
	}
	public void setGmboard_money(String gmboard_money) {
		this.gmboard_money = gmboard_money;
	}
	public String getGmboard_content() {
		return gmboard_content;
	}
	public void setGmboard_content(String gmboard_content) {
		this.gmboard_content = gmboard_content;
	}
	public String getGmboard_poster() {
		return gmboard_poster;
	}
	public void setGmboard_poster(String gmboard_poster) {
		this.gmboard_poster = gmboard_poster;
	}
	public String getGmboard_file() {
		return gmboard_file;
	}
	public void setGmboard_file(String gmboard_file) {
		this.gmboard_file = gmboard_file;
	}
	public String getGmboard_sday() {
		return gmboard_sday;
	}
	public void setGmboard_sday(String gmboard_sday) {
		this.gmboard_sday = gmboard_sday;
	}
	public String getGmboard_eday() {
		return gmboard_eday;
	}
	public void setGmboard_eday(String gmboard_eday) {
		this.gmboard_eday = gmboard_eday;
	}
	public Timestamp getGmboard_reg() {
		return gmboard_reg;
	}
	public void setGmboard_reg(Timestamp gmboard_reg) {
		this.gmboard_reg = gmboard_reg;
	}
	
	
}
