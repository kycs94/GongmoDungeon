package team04.project.login;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import team04.project.community.Community_reviewWriteDTO;
import team04.project.community.Community_writeDTO;
import team04.project.gongmo.GongmoWriteDTO;

public class LoginDAO {
	
	// 싱글턴
	private static LoginDAO instance = new LoginDAO();
	private LoginDAO() {}
	public static LoginDAO getInstance() {return instance;}
	
	// 커넥션
	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	
	// 회원가입
	public void insertMember(signupDTO dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			
			if("normal".equals(dto.getOrgType())) { //일반회원 가입
				String sql = "insert into usern values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,sysdate)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, dto.getUser_id());
				pstmt.setString(2, dto.getUsern_pw());
				pstmt.setString(3, dto.getUsern_name());
				pstmt.setString(4, dto.getUsern_email());
				pstmt.setString(5, dto.getUsern_phone());
				pstmt.setString(6, dto.getUsern_attach());
				pstmt.setString(7, dto.getUsern_local());
				pstmt.setString(8, dto.getUsern_favor());
				pstmt.setString(9, dto.getUsern_job());
				pstmt.setInt(10, dto.getUsern_award());
				pstmt.setInt(11, dto.getUsern_popul());
				pstmt.setString(12, dto.getUsern_history());
				pstmt.setInt(13, dto.getUsern_active());
				pstmt.setString(14, dto.getUsern_dropmsg());
				
				pstmt.executeUpdate();
			}else { //기업회원 가입
				conn = getConnection();
				String sql = "insert into userc values(?,?,?,?,?,?,?,sysdate)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, dto.getUser_id());
				pstmt.setString(2, dto.getUserc_pw());
				pstmt.setString(3, dto.getUserc_name());
				pstmt.setString(4, dto.getUserc_type());
				pstmt.setString(5, dto.getUserc_num());
				pstmt.setString(6, dto.getUserc_url());
				pstmt.setString(7, dto.getUserc_email());
				
				pstmt.executeUpdate();
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) try {pstmt.close();} catch(Exception e) {e.printStackTrace();}
			if(conn != null) try {conn.close();} catch(Exception e) {e.printStackTrace();}
		}
	}
		
	// 아이디 중복확인
	public boolean confirmId(String user_id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean result = false;
		
		try {
			conn = getConnection();
			String sql = "SELECT USER_ID FROM (SELECT USERN_ID AS USER_ID FROM USERN UNION ALL SELECT USERC_ID AS USER_ID FROM USERC) WHERE USER_ID = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_id);

			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = true;
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();} catch(Exception e) {e.printStackTrace();}
			if(pstmt != null) try {pstmt.close();} catch(Exception e) {e.printStackTrace();}
			if(conn != null) try {conn.close();} catch(Exception e) {e.printStackTrace();}
		}
		return result;
	}
	
	// id, pw 일치여부 확인
	public boolean idPwCheck(String user_id, String user_pw, String orgType) {
		boolean result = false;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		try {
			conn = getConnection();
			
			if(orgType != null || orgType != "") {
				if("normal".equals(orgType)) {//일반회원
					 sql = "select * from usern where usern_id=? and usern_pw=?";
				}else {//기업회원
					 sql = "select * from userc where userc_id=? and userc_pw=?";
				}
			}
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_id);
			pstmt.setString(2, user_pw);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();} catch(Exception e) {e.printStackTrace();}
			if(pstmt != null) try {pstmt.close();} catch(Exception e) {e.printStackTrace();}
			if(conn != null) try {conn.close();} catch(Exception e) {e.printStackTrace();}
		}
		return result;
	}
	
   // 명예의전당 수상횟수 TOP3
   public List getHallOfFameList() {
      Connection conn = null; 
      PreparedStatement pstmt = null; 
      ResultSet rs = null; 
      List hallOfFameList = null; 
      try {
         conn = getConnection();
         String sql = "select usern_id from (select usern_id from usern order by usern_award desc) where rownum < 4";
         pstmt = conn.prepareStatement(sql);
         rs = pstmt.executeQuery(); 
         if(rs.next()) {
        	 hallOfFameList = new ArrayList();  // 결과가 있으면 list 객체생성해서 준비 (나중에 null로 확인하기 위하여)
            do { // if문에서 rs.next() 실행되서 커서가 내려가버렸으니 do-while로 먼저 데이터 꺼내게 하기.
               signupDTO hallOfFame = new signupDTO(); 
               hallOfFame.setUsern_id(rs.getString("usern_id"));
               hallOfFameList.add(hallOfFame); // 리스트에 추가 
            }while(rs.next());
         }// if
      }catch(Exception e) {
         e.printStackTrace();
      }finally {
         if(rs != null) try { rs.close(); } catch(Exception e) { e.printStackTrace();}
         if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace();}
         if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace();}
      }
      return hallOfFameList;
   }
   
   // 명예의전당 평판점수 TOP3
   public List getPopulList() {
      Connection conn = null; 
      PreparedStatement pstmt = null; 
      ResultSet rs = null; 
      List populList = null; 
      try {
         conn = getConnection();
         String sql = "select usern_id from (select usern_id from usern order by usern_popul desc) where rownum < 4";
         pstmt = conn.prepareStatement(sql);
         rs = pstmt.executeQuery(); 
         if(rs.next()) {
        	 populList = new ArrayList();  // 결과가 있으면 list 객체생성해서 준비 (나중에 null로 확인하기 위하여)
            do { // if문에서 rs.next() 실행되서 커서가 내려가버렸으니 do-while로 먼저 데이터 꺼내게 하기.
               signupDTO popul = new signupDTO(); 
               popul.setUsern_id(rs.getString("usern_id"));
               populList.add(popul); // 리스트에 추가 
            }while(rs.next());
         }// if
      }catch(Exception e) {
         e.printStackTrace();
      }finally {
         if(rs != null) try { rs.close(); } catch(Exception e) { e.printStackTrace();}
         if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace();}
         if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace();}
      }
      return populList;
   }
   
   // 회원가입 이메일 항목 select option DB에서 꺼내오기
	public List getmailList() {
      Connection conn = null; 
      PreparedStatement pstmt = null; 
      ResultSet rs = null; 
      List getmailList = null; 
      try {
         conn = getConnection();
         String sql = "select code from code where group_code='mail'";
         pstmt = conn.prepareStatement(sql);
         rs = pstmt.executeQuery(); 
         if(rs.next()) {
        	 getmailList = new ArrayList();  // 결과가 있으면 list 객체생성해서 준비 (나중에 null로 확인하기 위하여)
            do { // if문에서 rs.next() 실행되서 커서가 내려가버렸으니 do-while로 먼저 데이터 꺼내게 하기.
               signupDTO mail = new signupDTO(); 
               mail.setCode(rs.getString("code"));
               getmailList.add(mail); // 리스트에 추가 
            }while(rs.next());
         }// if
      }catch(Exception e) {
         e.printStackTrace();
      }finally {
         if(rs != null) try { rs.close(); } catch(Exception e) { e.printStackTrace();}
         if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace();}
         if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace();}
      }
      return getmailList;
   }

	// 팀원 평가 점수 insert
	public int insertPopul(String applyteam_id, int popul) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		int result =-1;
		
		try {
			conn = getConnection();
			String sql = "select usern_popul from usern where usern_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, applyteam_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				sql = "update usern set usern_popul=usern_popul+? where usern_id=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, popul);
				pstmt.setString(2, applyteam_id);
				result = pstmt.executeUpdate();
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt!=null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return result;
	}
	
	// maketeam_id 한사람의 캐릭터 가져오기
	public signupDTO maketeamIdchar(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		signupDTO sdto = null;
		try {
			conn = getConnection();
			String sql = "select usern_job from usern where usern_id=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				sdto = new signupDTO();
				sdto.setUsern_job(rs.getString(1));
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt!=null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return sdto;
	}

	// 세션아이디사람의 캐릭터 가져오기
	public signupDTO usernteamIdchar(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		signupDTO sdto = null;
		try {
			conn = getConnection();
			String sql = "select usern_job from usern where usern_id=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				sdto = new signupDTO();
				sdto.setUsern_job(rs.getString(1));
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt!=null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return sdto;
	}
	
	//검색한 공모전 게시글 가져오기
	public List getGongmoTitleList(String search) {
	   List titleList1 = null;
	   Connection conn = null; 
	   PreparedStatement pstmt = null; 
	   ResultSet rs = null;  
	   try {
		   conn = getConnection();
		   String sql = "select B.*, r from (select A.*, rownum r from (select * from gmboard where gmboard_title like '%"+search+"%' order by gmboard_reg desc) A order by gmboard_reg desc) B where r >= 1 and r <= 4";
		   pstmt = conn.prepareStatement(sql);
		   rs = pstmt.executeQuery();
		   if(rs.next()) {
			   titleList1 = new ArrayList();
			   do { 
				   GongmoWriteDTO article = new GongmoWriteDTO(); 
				   article.setGmboard_title(rs.getString("gmboard_title"));
				   article.setGmboard_num(rs.getInt("gmboard_num"));
				   titleList1.add(article);
			   }while(rs.next());
		   }// if
	   }catch(Exception e) {
		   e.printStackTrace();
	   }finally {
		   if(rs != null) try { rs.close(); } catch(Exception e) { e.printStackTrace();}
		   if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace();}
		   if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace();}
	   }
	   return titleList1;
	}
   
	//검색한 자유게시판 게시글 가져오기
	public List getFreeTitleList(String search) {
	   List titleList2 = null;
	   Connection conn = null; 
	   PreparedStatement pstmt = null; 
	   ResultSet rs = null;  
	   try {
		   conn = getConnection();
		   String sql = "select B.*, r from (select A.*, rownum r from (select * from cmboard where cmboard_title like '%"+search+"%' order by cmboard_reg desc) A order by cmboard_reg desc) B where r >= 1 and r <= 4";
		   pstmt = conn.prepareStatement(sql);
		   rs = pstmt.executeQuery();
		   if(rs.next()) {
			   titleList2 = new ArrayList();
			   do { 
				   Community_writeDTO article = new Community_writeDTO(); 
				   article.setCMBoard_title(rs.getString("cmboard_title"));
				   article.setCMBoard_num(rs.getInt("cmboard_num"));
				   titleList2.add(article);
			   }while(rs.next());
		   }// if
	   }catch(Exception e) {
		   e.printStackTrace();
	   }finally {
		   if(rs != null) try { rs.close(); } catch(Exception e) { e.printStackTrace();}
		   if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace();}
		   if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace();}
	   }
	   return titleList2;
	}
   
	//검색한 후기게시판 게시글 가져오기
	public List getReviewTitleList(String search) {
	   List titleList3 = null;
	   Connection conn = null; 
	   PreparedStatement pstmt = null; 
	   ResultSet rs = null;  
	   try {
		   conn = getConnection();
		   String sql = "select B.*, r from (select A.*, rownum r from (select * from review where review_title like '%"+search+"%' order by review_reg desc) A order by review_reg desc) B where r >= 1 and r <= 4";
		   pstmt = conn.prepareStatement(sql);
		   rs = pstmt.executeQuery();
		   if(rs.next()) {
			   titleList3 = new ArrayList();
			   do { 
				   Community_reviewWriteDTO article = new Community_reviewWriteDTO(); 
				   article.setReview_title(rs.getString("review_title"));
				   article.setReview_num(rs.getInt("review_num"));
				   titleList3.add(article);
			   }while(rs.next());
		   }// if
	   }catch(Exception e) {
		   e.printStackTrace();
	   }finally {
		   if(rs != null) try { rs.close(); } catch(Exception e) { e.printStackTrace();}
		   if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace();}
		   if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace();}
	   }
	   return titleList3;
	}
	
	//최신공고 4개 가져오기
		public List getGongmoList() {
			List gongmoList = null;
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				conn = getConnection();
				
				String sql = "select B.*, r from (select A.*, rownum r from (select * from gmboard order by gmboard_reg desc) A order by gmboard_reg desc) B where rownum < 5";
				
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					gongmoList = new ArrayList(); //결과가 있으면 리스트 객체 생성해서 준비(나중에 null 확인하기 위해서)
					do { // if문에서 rs.next로 이미 커서가 내려가 버려 do while을 써서 먼저 데이터 담음
						GongmoWriteDTO gm = new GongmoWriteDTO();
						gm.setGmboard_num(rs.getInt("Gmboard_num"));
						gm.setGmboard_title(rs.getString("Gmboard_title"));
						gm.setGmboard_reg(rs.getTimestamp("Gmboard_reg"));
						gm.setGmboard_view(rs.getInt("Gmboard_view"));
						gm.setGmboard_poster(rs.getString("Gmboard_poster"));
						gm.setGmboard_name(rs.getString("Gmboard_name"));
						gm.setGmboard_eday(rs.getString("Gmboard_eday"));
						gongmoList.add(gm); // 리스트 추가
					}while(rs.next());
				}//if
						
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs!=null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
				if(pstmt!=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
				if(conn!=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
			}
			
			return gongmoList;
		}
	
	// 검색한 키워드가 공모전에 몇 개 있는지
	public int getGongmoTitlecount(String search) {
		   Connection conn = null; 
		   PreparedStatement pstmt = null; 
		   ResultSet rs = null;  
		   int result = 0;
		   try {
			   conn = getConnection();
			   String sql = "select count(*) from gmboard where gmboard_title like '%"+search+"%'";
			   pstmt = conn.prepareStatement(sql);
			   rs = pstmt.executeQuery();
			   if(rs.next()) {
				   result = rs.getInt(1);
			   }

		   }catch(Exception e) {
			   e.printStackTrace();
		   }finally {
			   if(rs != null) try { rs.close(); } catch(Exception e) { e.printStackTrace();}
			   if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace();}
			   if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace();}
		   }
		   return result;
	}
	
	// 검색한 키워드가 자유게시판에 몇 개 있는지
	public int getFreeTitlecount(String search) {
		   Connection conn = null; 
		   PreparedStatement pstmt = null; 
		   ResultSet rs = null;  
		   int result = 0;
		   try {
			   conn = getConnection();
			   String sql = "select count(*) from cmboard where cmboard_title like '%"+search+"%'";
			   pstmt = conn.prepareStatement(sql);
			   rs = pstmt.executeQuery();
			   if(rs.next()) {
				   result = rs.getInt(1);
			   }

		   }catch(Exception e) {
			   e.printStackTrace();
		   }finally {
			   if(rs != null) try { rs.close(); } catch(Exception e) { e.printStackTrace();}
			   if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace();}
			   if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace();}
		   }
		   return result;
	}
	
	// 검색한 키워드가 후기게시판에 몇 개 있는지
	public int getReviewTitlecount(String search) {
		   Connection conn = null; 
		   PreparedStatement pstmt = null; 
		   ResultSet rs = null;  
		   int result = 0;
		   try {
			   conn = getConnection();
			   String sql = "select count(*) from review where review_title like '%"+search+"%'";
			   pstmt = conn.prepareStatement(sql);
			   rs = pstmt.executeQuery();
			   if(rs.next()) {
				   result = rs.getInt(1);
			   }

		   }catch(Exception e) {
			   e.printStackTrace();
		   }finally {
			   if(rs != null) try { rs.close(); } catch(Exception e) { e.printStackTrace();}
			   if(pstmt != null) try { pstmt.close(); } catch(Exception e) { e.printStackTrace();}
			   if(conn != null) try { conn.close(); } catch(Exception e) { e.printStackTrace();}
		   }
		   return result;
	}
	
	// 일반 회원 로그인 할때 active 가 0 인지 1인지 체크 1이면 추방당한 회원임.
	public signupDTO activeCheck(String user_id, String orgType) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		 ResultSet rs = null;  
		 signupDTO sdto = null;
		 String sql = "";
		try {
			conn = getConnection();
			if(orgType != null || orgType != "") {
				if("normal".equals(orgType)) {//일반회원
					 sql = "select usern_active, usern_dropmsg from usern where usern_id=?";
				}
			}
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				sdto = new signupDTO();
				sdto.setUsern_active(rs.getInt(1));
				sdto.setUsern_dropmsg(rs.getString(2));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) try {rs.close();} catch(Exception e) {e.printStackTrace();}
			if(pstmt != null) try {pstmt.close();} catch(Exception e) {e.printStackTrace();}
			if(conn != null) try {conn.close();} catch(Exception e) {e.printStackTrace();}
		}
		return sdto;
	}	
	
	
	
	
}
