package team04.project.gongmo;

import java.sql.Timestamp;

public class GongmoContentQnADTO {
   private int gmqna_num;
   private int gmqna_postnum;
   private String gmqna_id;
   private String gmqna_comm;
   private int gmqna_level;
   private int gmqna_step;
   public int getGmqna_num() {
      return gmqna_num;
   }
   public void setGmqna_num(int gmqna_num) {
      this.gmqna_num = gmqna_num;
   }
   public int getGmqna_postnum() {
      return gmqna_postnum;
   }
   public void setGmqna_postnum(int gmqna_postnum) {
      this.gmqna_postnum = gmqna_postnum;
   }
   public String getGmqna_id() {
      return gmqna_id;
   }
   public void setGmqna_id(String gmqna_id) {
      this.gmqna_id = gmqna_id;
   }
   public String getGmqna_comm() {
      return gmqna_comm;
   }
   public void setGmqna_comm(String gmqna_comm) {
      this.gmqna_comm = gmqna_comm;
   }
   public int getGmqna_level() {
      return gmqna_level;
   }
   public void setGmqna_level(int gmqna_level) {
      this.gmqna_level = gmqna_level;
   }
   public int getGmqna_step() {
      return gmqna_step;
   }
   public void setGmqna_step(int gmqna_step) {
      this.gmqna_step = gmqna_step;
   }
   public int getGmqna_ref() {
      return gmqna_ref;
   }
   public void setGmqna_ref(int gmqna_ref) {
      this.gmqna_ref = gmqna_ref;
   }
   public Timestamp getGmqna_reg() {
      return gmqna_reg;
   }
   public void setGmqna_reg(Timestamp gmqna_reg) {
      this.gmqna_reg = gmqna_reg;
   }
   private int gmqna_ref;
   private Timestamp gmqna_reg;
}