package team04.project.gongmo;

import java.sql.Timestamp;

public class GongmoTeamApplyDTO {

		private int applyteam_num, applyteam_postNum, applyteam_result;
		private String applyteam_id, applyteam_comm;
		private Timestamp applyteam_reg;
		
		public int getApplyteam_num() {
			return applyteam_num;
		}
		public void setApplyteam_num(int applyteam_num) {
			this.applyteam_num = applyteam_num;
		}
		public int getApplyteam_postNum() {
			return applyteam_postNum;
		}
		public void setApplyteam_postNum(int applyteam_postNum) {
			this.applyteam_postNum = applyteam_postNum;
		}
		public int getApplyteam_result() {
			return applyteam_result;
		}
		public void setApplyteam_result(int applyteam_result) {
			this.applyteam_result = applyteam_result;
		}
		public String getApplyteam_id() {
			return applyteam_id;
		}
		public void setApplyteam_id(String applyteam_id) {
			this.applyteam_id = applyteam_id;
		}
		public String getApplyteam_comm() {
			return applyteam_comm;
		}
		public void setApplyteam_comm(String applyteam_comm) {
			this.applyteam_comm = applyteam_comm;
		}
		public Timestamp getApplyteam_reg() {
			return applyteam_reg;
		}
		public void setApplyteam_reg(Timestamp applyteam_reg) {
			this.applyteam_reg = applyteam_reg;
		}

		
		
	}