package team04.project.mypage;

import java.sql.Timestamp;

public class MsgDTO {
	private String msg_sid, msg_rid, msg_content;
	private Timestamp msg_reg;
	
	public String getMsg_sid() {
		return msg_sid;
	}
	public void setMsg_sid(String msg_sid) {
		this.msg_sid = msg_sid;
	}
	public String getMsg_rid() {
		return msg_rid;
	}
	public void setMsg_rid(String msg_rid) {
		this.msg_rid = msg_rid;
	}
	public String getMsg_content() {
		return msg_content;
	}
	public void setMsg_content(String msg_content) {
		this.msg_content = msg_content;
	}
	public Timestamp getMsg_reg() {
		return msg_reg;
	}
	public void setMsg_reg(Timestamp msg_reg) {
		this.msg_reg = msg_reg;
	}
	
	

}
