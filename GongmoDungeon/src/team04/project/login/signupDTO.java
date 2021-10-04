package team04.project.login;

import java.sql.Timestamp;

public class signupDTO {
	
	//공통 start
	private String user_id;
	private String user_pw;
	private String user_name;	
	private String orgType;
	//공통 end
	
	//기업 start
	private String userc_id;
	private String userc_pw;
	private String userc_name;
	private String userc_type;
	private String userc_num;
	private String userc_url;
	private String userc_email;
	private Timestamp userc_reg;
	//기업 end
	
	//일반 start
	private String usern_id;
	private String usern_pw;
	private String usern_name;
	private String usern_email;
	private String usern_phone;
	private String usern_attach;
	private String usern_local;
	private String usern_favor;
	private String user_favor;
	private String usern_job;
	private int usern_award;
	private int usern_popul;
	private String usern_history;
	private int usern_active;
	private String usern_dropmsg;
	private Timestamp usern_reg;
	private String code;
	//일반 end
	
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_pw() {
		return user_pw;
	}
	public void setUser_pw(String user_pw) {
		this.user_pw = user_pw;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getOrgType() {
		return orgType;
	}
	public void setOrgType(String orgType) {
		this.orgType = orgType;
	}
	public String getUserc_id() {
		return userc_id;
	}
	public void setUserc_id(String userc_id) {
		this.userc_id = userc_id;
	}
	public String getUserc_pw() {
		return userc_pw;
	}
	public void setUserc_pw(String userc_pw) {
		this.userc_pw = userc_pw;
	}
	public String getUserc_name() {
		return userc_name;
	}
	public void setUserc_name(String userc_name) {
		this.userc_name = userc_name;
	}
	public String getUserc_type() {
		return userc_type;
	}
	public void setUserc_type(String userc_type) {
		this.userc_type = userc_type;
	}
	public String getUserc_num() {
		return userc_num;
	}
	public void setUserc_num(String userc_num) {
		this.userc_num = userc_num;
	}
	public String getUserc_url() {
		return userc_url;
	}
	public void setUserc_url(String userc_url) {
		this.userc_url = userc_url;
	}
	public String getUserc_email() {
		return userc_email;
	}
	public void setUserc_email(String userc_email) {
		this.userc_email = userc_email;
	}
	public Timestamp getUserc_reg() {
		return userc_reg;
	}
	public void setUserc_reg(Timestamp userc_reg) {
		this.userc_reg = userc_reg;
	}
	public String getUsern_id() {
		return usern_id;
	}
	public void setUsern_id(String usern_id) {
		this.usern_id = usern_id;
	}
	public String getUsern_pw() {
		return usern_pw;
	}
	public void setUsern_pw(String usern_pw) {
		this.usern_pw = usern_pw;
	}
	public String getUsern_name() {
		return usern_name;
	}
	public void setUsern_name(String usern_name) {
		this.usern_name = usern_name;
	}
	public String getUsern_email() {
		return usern_email;
	}
	public void setUsern_email(String usern_email) {
		this.usern_email = usern_email;
	}
	public String getUsern_phone() {
		return usern_phone;
	}
	public void setUsern_phone(String usern_phone) {
		this.usern_phone = usern_phone;
	}
	public String getUsern_attach() {
		return usern_attach;
	}
	public void setUsern_attach(String usern_attach) {
		this.usern_attach = usern_attach;
	}
	public String getUsern_local() {
		return usern_local;
	}
	public void setUsern_local(String usern_local) {
		this.usern_local = usern_local;
	}
	public String getUsern_favor() {
		return usern_favor;
	}
	public void setUsern_favor(String usern_favor) {
		this.usern_favor = usern_favor;
	}
	public String getUsern_job() {
		return usern_job;
	}
	public void setUsern_job(String usern_job) {
		this.usern_job = usern_job;
	}
	public int getUsern_award() {
		return usern_award;
	}
	public void setUsern_award(int usern_award) {
		this.usern_award = usern_award;
	}
	public int getUsern_popul() {
		return usern_popul;
	}
	public void setUsern_popul(int usern_popul) {
		this.usern_popul = usern_popul;
	}
	public String getUsern_history() {
		return usern_history;
	}
	public void setUsern_history(String usern_history) {
		this.usern_history = usern_history;
	}
	public int getUsern_active() {
		return usern_active;
	}
	public void setUsern_active(int usern_active) {
		this.usern_active = usern_active;
	}
	public String getUsern_dropmsg() {
		return usern_dropmsg;
	}
	public void setUsern_dropmsg(String usern_dropmsg) {
		this.usern_dropmsg = usern_dropmsg;
	}
	public Timestamp getUsern_reg() {
		return usern_reg;
	}
	public void setUsern_reg(Timestamp usern_reg) {
		this.usern_reg = usern_reg;
	}
	public String getUser_favor() {
		return user_favor;
	}
	public void setUser_favor(String user_favor) {
		this.user_favor = user_favor;
	}

}
