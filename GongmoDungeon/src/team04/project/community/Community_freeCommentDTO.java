package team04.project.community;

import java.sql.Timestamp;

public class Community_freeCommentDTO {
	private int CmComment_num;
	private int CmComment_postNum;
	private String CmComment_id;
	private String CmComment_comm;
	private int CmComment_level;
	private int CmComment_step;
	private int CmComment_ref;
	private Timestamp CmComment_reg;
	
	public int getCmComment_num() {
		return CmComment_num;
	}
	public void setCmComment_num(int cmComment_num) {
		CmComment_num = cmComment_num;
	}
	public int getCmComment_postNum() {
		return CmComment_postNum;
	}
	public void setCmComment_postNum(int cmComment_postNum) {
		CmComment_postNum = cmComment_postNum;
	}
	public String getCmComment_id() {
		return CmComment_id;
	}
	public void setCmComment_id(String cmComment_id) {
		CmComment_id = cmComment_id;
	}
	public String getCmComment_comm() {
		return CmComment_comm;
	}
	public void setCmComment_comm(String cmComment_comm) {
		CmComment_comm = cmComment_comm;
	}
	public int getCmComment_level() {
		return CmComment_level;
	}
	public void setCmComment_level(int cmComment_level) {
		CmComment_level = cmComment_level;
	}
	public int getCmComment_step() {
		return CmComment_step;
	}
	public void setCmComment_step(int cmComment_step) {
		CmComment_step = cmComment_step;
	}
	public int getCmComment_ref() {
		return CmComment_ref;
	}
	public void setCmComment_ref(int cmComment_ref) {
		CmComment_ref = cmComment_ref;
	}
	public Timestamp getCmComment_reg() {
		return CmComment_reg;
	}
	public void setCmComment_reg(Timestamp cmComment_reg) {
		CmComment_reg = cmComment_reg;
	}
	
	
}
