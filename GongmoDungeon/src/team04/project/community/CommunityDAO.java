package team04.project.community;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import team04.project.gongmo.GongmoTeamMakeDTO;


public class CommunityDAO {
	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}
	
	//자유게시판 글쓰기
	public int freeWrite(Community_writeDTO dto) {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			
			String sql = "insert into cmboard(CMBoard_num,CMBoard_title,CMBoard_id,CMBoard_content,CMBoard_commCount,CMBoard_view,CMBoard_reg) values(CMBOARD_SEQ.nextVal,?,?,?,0,0,sysdate)";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getCMBoard_title());
			pstmt.setString(2, dto.getCMBoard_id());
			pstmt.setString(3, dto.getCMBoard_content());
			
			result = pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt!=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		
		return result;
	}
	
	//검색한거 갯수
	public int getSearchCount(String sel, String search) {
		int count = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			
			String sql = "select count(*) from (select CMBoard_num, CMBoard_title, CMBoard_id, CMBoard_view, CMBoard_reg, CMBoard_content from cmboard union select Review_num, Review_title, Review_id, Review_view, Review_reg, Review_content from review) where " + sel + " like '%" + search +"%'";
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}//if
					
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		
		return count;
	}
	
	//자유게시판에서 검색한거 갯수
	public int getFreeSearchCount(String sel, String search) {
		int count = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			
			String sql = "select count(*) from cmboard where " + sel + " like '%" + search +"%'";
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}//if
					
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		
		return count;
	}
	
	//팀모집게시판에서 검색한거 갯수
	public int getTeamSearchCount(String sel, String search) {
		int count = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			
			String sql = "select count(*) from maketeam where " + sel + " like '%" + search +"%'";
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}//if
					
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		
		return count;
	}
	
	//후기게시판에서 검색한거 갯수
	public int getReviewSearchCount(String sel, String search) {
		int count = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			
			String sql = "select count(*) from review where " + sel + " like '%" + search +"%'";
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}//if
					
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		
		return count;
	}
	
	//전체 갯수
	public int getAllCount() {
		int count = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			
			String sql = "select count(*) from (select CMBoard_num, CMBoard_title, CMBoard_id, CMBoard_view, CMBoard_reg from cmboard union select Review_num, Review_title, Review_id, Review_view, Review_reg from review)";
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}//if
					
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		
		return count;
	}
	
	//내가 쓴 글 전체 갯수
	public int getMyCount(String id) {
		int count = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			
			String sql = "select count(*) from (select CMBoard_num, CMBoard_title, CMBoard_id, CMBoard_view, CMBoard_reg from cmboard union select Review_num, Review_title, Review_id, Review_view, Review_reg from review) where CMBoard_id=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}//if
					
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		
		return count;
	}
	
	//내가 댓글 쓴 글 전체 갯수
	public int getMyCommCount(String id) {
		int count = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			
			String sql = "select count(*) from cmcomment where cmcomment_id = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}//if
					
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		
		return count;
	}
	
	//자유게시판 전제 갯수
	public int getFreeAllCount() {
		int count = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			
			String sql = "select count(*) from cmboard";
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}//if
					
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		
		return count;
	}
	
	//후기게시판 전제 갯수
	public int getReviewAllCount() {
		int count = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			
			String sql = "select count(*) from review";
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}//if
					
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		
		return count;
	}
	
	//팀모집게시판 전제 갯수
	public int getTeamAllCount() {
		int count = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			
			String sql = "select count(*) from maketeam";
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}//if
					
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		
		return count;
	}
	
	//자유게시판에 전체 리스트 가져옴
	public List getFreeAllList(int start, int end) {
		List articles = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			
			String sql = "select B.*, r from (select A.*, rownum r from (select * from cmboard order by cmboard_reg desc) A order by cmboard_reg desc) B where r >= ? and r <= ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				articles = new ArrayList(); //결과가 있으면 리스트 객체 생성해서 준비(나중에 null 확인하기 위해서)
				do { // if문에서 rs.next로 이미 커서가 내려가 버려 do while을 써서 먼저 데이터 담음
					Community_writeDTO article = new Community_writeDTO();
					article.setCMBoard_num(rs.getInt("CMBoard_num"));
					article.setCMBoard_title(rs.getString("CMBoard_title"));
					article.setCMBoard_id(rs.getString("CMBoard_id"));
					article.setCMBoard_commCount(rs.getInt("CMBoard_commCount"));
					article.setCMBoard_view(rs.getInt("CMBoard_view"));
					article.setCMBoard_reg(rs.getTimestamp("CMBoard_reg"));
					articles.add(article); // 리스트 추가
				}while(rs.next());
			}//if
					
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		
		return articles;
	}
	
	//팀지원게시판에 전체 리스트 가져옴
		public List getTeamAllList(int start, int end) {
			List articles = null;
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				conn = getConnection();
				
				String sql = "select B.*, r from (select A.*, rownum r from (select * from maketeam order by maketeam_reg desc) A order by maketeam_reg desc) B where r >= ? and r <= ?";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					articles = new ArrayList(); //결과가 있으면 리스트 객체 생성해서 준비(나중에 null 확인하기 위해서)
					do { // if문에서 rs.next로 이미 커서가 내려가 버려 do while을 써서 먼저 데이터 담음
						GongmoTeamMakeDTO article = new GongmoTeamMakeDTO();
						article.setMaketeam_num(rs.getInt("maketeam_num"));
						article.setMaketeam_targetGM(rs.getInt("maketeam_targetGM"));
						article.setMaketeam_id(rs.getString("maketeam_id"));
						article.setMaketeam_title(rs.getString("maketeam_title")); 
						article.setMaketeam_name(rs.getString("maketeam_name"));
						article.setMaketeam_Ptotal(rs.getInt("maketeam_ptotal"));
						article.setMaketeam_job(rs.getString("maketeam_job"));
						article.setMaketeam_view(rs.getInt("maketeam_view"));
						article.setMaketeam_content(rs.getString("maketeam_content"));
						article.setMaketeam_pnow(rs.getString("maketeam_pnow"));
						article.setMaketeam_done(rs.getString("maketeam_done"));
						article.setMaketeam_reg(rs.getTimestamp("maketeam_reg"));
						articles.add(article); // 리스트 추가
					}while(rs.next());
				}//if
						
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs!=null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
				if(pstmt!=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
				if(conn!=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
			}
			
			return articles;
		}
		
		//후기게시판에 전체 리스트 가져옴
		public List getReviewAllList(int start, int end) {
			List articles = null;
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				conn = getConnection();
				
				String sql = "select B.*, r from (select A.*, rownum r from (select * from review order by review_reg desc) A order by review_reg desc) B where r >= ? and r <= ?";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					articles = new ArrayList(); //결과가 있으면 리스트 객체 생성해서 준비(나중에 null 확인하기 위해서)
					do { // if문에서 rs.next로 이미 커서가 내려가 버려 do while을 써서 먼저 데이터 담음
						Community_reviewWriteDTO article = new Community_reviewWriteDTO();
						article.setReview_num(rs.getInt("Review_num"));
						article.setReview_targetGM(rs.getString("Review_targetGM"));
						article.setReview_id(rs.getString("Review_id"));
						article.setReview_title(rs.getString("Review_title"));
						article.setReview_content(rs.getString("Review_content"));
						article.setReview_file(rs.getString("Review_file"));
						article.setReview_view(rs.getInt("Review_view"));
						article.setReview_reg(rs.getTimestamp("Review_reg"));
						articles.add(article); // 리스트 추가
					}while(rs.next());
				}//if
						
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs!=null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
				if(pstmt!=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
				if(conn!=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
			}
			
			return articles;
		}
	
	//전체 리스트 가져옴
	public List getAllList(int start, int end) {
		List articles = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			
			String sql = "select CMBoard_num, CMBoard_title, CMBoard_id, CMBoard_view, CMBoard_reg, tbName, r from (select CMBoard_num, CMBoard_title, CMBoard_id, CMBoard_view, CMBoard_reg, tbName, rownum r from (select t.CMBoard_num, t.CMBoard_title, t.CMBoard_id, t.CMBoard_view, t.CMBoard_reg, tbName from (select CMBoard_num, CMBoard_title, CMBoard_id, CMBoard_view, CMBoard_reg, 'CMBoard' as tbName from cmboard union select Review_num, Review_title, Review_id, Review_view, Review_reg, 'Review' as tbName from review) t order by t.cmboard_reg desc) order by CMBoard_reg desc) where r >= ? and r <= ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				articles = new ArrayList(); //결과가 있으면 리스트 객체 생성해서 준비(나중에 null 확인하기 위해서)
				do { // if문에서 rs.next로 이미 커서가 내려가 버려 do while을 써서 먼저 데이터 담음
					Community_writeDTO article = new Community_writeDTO();
					article.setCMBoard_num(rs.getInt("CMBoard_num"));
					article.setCMBoard_title(rs.getString("CMBoard_title")+"/"+rs.getString("tbName"));
					article.setCMBoard_id(rs.getString("CMBoard_id"));
					article.setCMBoard_view(rs.getInt("CMBoard_view"));
					article.setCMBoard_reg(rs.getTimestamp("CMBoard_reg"));
					articles.add(article); // 리스트 추가
				}while(rs.next());
			}//if
					
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		
		return articles;
	}
	
	//검색한 리스트 가져옴
	public List getSearchList(int start, int end, String sel, String search) {
		List articles = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			
			String sql = "select CMBoard_num, CMBoard_title, CMBoard_id, CMBoard_view, CMBoard_reg, tbName, r from (select CMBoard_num, CMBoard_title, CMBoard_id, CMBoard_view, CMBoard_reg, tbName, rownum r from (select t.CMBoard_num, t.CMBoard_title, t.CMBoard_id, t.CMBoard_view, t.CMBoard_reg, tbName from (select CMBoard_num, CMBoard_title, CMBoard_id, CMBoard_view, CMBoard_reg, 'CMBoard' as tbName from cmboard union select Review_num, Review_title, Review_id, Review_view, Review_reg, 'Review' as tbName from review) t where " + sel + " like '%" + search + "%' order by t.cmboard_reg desc) order by CMBoard_reg desc) where r >= ? and r <= ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				articles = new ArrayList(); //결과가 있으면 리스트 객체 생성해서 준비(나중에 null 확인하기 위해서)
				do { // if문에서 rs.next로 이미 커서가 내려가 버려 do while을 써서 먼저 데이터 담음
					Community_writeDTO article = new Community_writeDTO();
					article.setCMBoard_num(rs.getInt("CMBoard_num"));
					article.setCMBoard_title(rs.getString("CMBoard_title")+"/"+rs.getString("tbName"));
					article.setCMBoard_id(rs.getString("CMBoard_id"));
					article.setCMBoard_view(rs.getInt("CMBoard_view"));
					article.setCMBoard_reg(rs.getTimestamp("CMBoard_reg"));
					articles.add(article); // 리스트 추가
				}while(rs.next());
			}//if
					
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		
		return articles;
	}
	
	//내가 쓴 글 리스트 가져옴
	public List getMyList(int start, int end, String id) {
		List articles = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			String sql = "select CMBoard_num, CMBoard_title, CMBoard_id, CMBoard_view, CMBoard_reg, tbName, r from (select CMBoard_num, CMBoard_title, CMBoard_id, CMBoard_view, CMBoard_reg, tbName, rownum r from (select t.CMBoard_num, t.CMBoard_title, t.CMBoard_id, t.CMBoard_view, t.CMBoard_reg, tbName from (select CMBoard_num, CMBoard_title, CMBoard_id, CMBoard_view, CMBoard_reg, 'CMBoard' as tbName from cmboard union select Review_num, Review_title, Review_id, Review_view, Review_reg, 'Review' as tbName from review) t where CMBoard_id = ? order by t.cmboard_reg desc) order by CMBoard_reg desc) where r >= ? and r <= ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				articles = new ArrayList(); //결과가 있으면 리스트 객체 생성해서 준비(나중에 null 확인하기 위해서)
				do { // if문에서 rs.next로 이미 커서가 내려가 버려 do while을 써서 먼저 데이터 담음
					Community_writeDTO article = new Community_writeDTO();
					article.setCMBoard_num(rs.getInt("CMBoard_num"));
					article.setCMBoard_title(rs.getString("CMBoard_title")+"/"+rs.getString("tbName"));
					article.setCMBoard_id(rs.getString("CMBoard_id"));
					article.setCMBoard_view(rs.getInt("CMBoard_view"));
					article.setCMBoard_reg(rs.getTimestamp("CMBoard_reg"));
					articles.add(article); // 리스트 추가
				}while(rs.next());
			}//if
					
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		
		return articles;
	}
	
	//내가 댓글 쓴 글 리스트 가져옴
	public List getMyCommList(int start, int end, String id) {
		List articles = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ResultSet rs1 = null;
		
		try {
			conn = getConnection();
			
			String sql = "select B.*, r from (select A.*, rownum r from (select * from cmcomment where cmcomment_id= ? order by cmcomment_reg desc) A order by cmcomment_reg desc) B where r >= ? and r <= ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				articles = new ArrayList(); //결과가 있으면 리스트 객체 생성해서 준비(나중에 null 확인하기 위해서)
				do { // if문에서 rs.next로 이미 커서가 내려가 버려 do while을 써서 먼저 데이터 담음
					Community_writeDTO article = new Community_writeDTO();
					article.setCMBoard_num(rs.getInt("cmcomment_postnum"));
					
					sql = "select * from cmboard where cmboard_num = ?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, rs.getInt("cmcomment_postnum"));
					rs1 = pstmt.executeQuery();
					if(rs1.next()) {
						article.setCMBoard_title(rs1.getString("CMBoard_title")+"/CMBoard");
						article.setCMBoard_id(rs1.getString("CMBoard_id"));
						article.setCMBoard_view(rs1.getInt("CMBoard_view"));
						article.setCMBoard_reg(rs1.getTimestamp("CMBoard_reg"));
					}
					articles.add(article); // 리스트 추가
				}while(rs.next());
			}//if
					
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs1!=null)try {rs1.close();}catch(Exception e) {e.printStackTrace();}
			if(rs!=null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		
		return articles;
	}
	
	//자유 게시판에서 검색한 리스트 가져옴
	public List getFreeSearchList(int start, int end, String sel, String search) {
		List articles = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			
			String sql = "select B.*, r from (select A.*, rownum r from (select * from cmboard where " + sel + " like '%" + search + "%' order by cmboard_reg desc) A order by cmboard_reg desc) B where r>= ? and r <= ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				articles = new ArrayList(); //결과가 있으면 리스트 객체 생성해서 준비(나중에 null 확인하기 위해서)
				do { // if문에서 rs.next로 이미 커서가 내려가 버려 do while을 써서 먼저 데이터 담음
					Community_writeDTO article = new Community_writeDTO();
					article.setCMBoard_num(rs.getInt("CMBoard_num"));
					article.setCMBoard_title(rs.getString("CMBoard_title"));
					article.setCMBoard_id(rs.getString("CMBoard_id"));
					article.setCMBoard_commCount(rs.getInt("CMBoard_commCount"));
					article.setCMBoard_view(rs.getInt("CMBoard_view"));
					article.setCMBoard_reg(rs.getTimestamp("CMBoard_reg"));
					articles.add(article); // 리스트 추가
				}while(rs.next());
			}//if
					
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		
		return articles;
	}
	
	//팀지원 게시판에서 검색한 리스트 가져옴
	public List getTeamSearchList(int start, int end, String sel, String search) {
		List articles = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			
			String sql = "select B.*, r from (select A.*, rownum r from (select * from maketeam where " + sel + " like '%" + search + "%' order by maketeam_reg desc) A order by maketeam_reg desc) B where r>= ? and r <= ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				articles = new ArrayList(); //결과가 있으면 리스트 객체 생성해서 준비(나중에 null 확인하기 위해서)
				do { // if문에서 rs.next로 이미 커서가 내려가 버려 do while을 써서 먼저 데이터 담음
					GongmoTeamMakeDTO article = new GongmoTeamMakeDTO();
					article.setMaketeam_num(rs.getInt("maketeam_num"));
					article.setMaketeam_targetGM(rs.getInt("maketeam_targetGM"));
					article.setMaketeam_id(rs.getString("maketeam_id"));
					article.setMaketeam_title(rs.getString("maketeam_title")); 
					article.setMaketeam_name(rs.getString("maketeam_name"));
					article.setMaketeam_Ptotal(rs.getInt("maketeam_ptotal"));
					article.setMaketeam_job(rs.getString("maketeam_job"));
					article.setMaketeam_view(rs.getInt("maketeam_view"));
					article.setMaketeam_content(rs.getString("maketeam_content"));
					article.setMaketeam_pnow(rs.getString("maketeam_pnow"));
					article.setMaketeam_done(rs.getString("maketeam_done"));
					article.setMaketeam_reg(rs.getTimestamp("maketeam_reg"));
					articles.add(article); // 리스트 추가
				}while(rs.next());
			}//if
					
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		
		return articles;
	}
	
	//후기 게시판에서 검색한 리스트 가져옴
	public List getReviewSearchList(int start, int end, String sel, String search) {
		List articles = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			
			String sql = "select B.*, r from (select A.*, rownum r from (select * from review where " + sel + " like '%" + search + "%' order by review_reg desc) A order by review_reg desc) B where r>= ? and r <= ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				articles = new ArrayList(); //결과가 있으면 리스트 객체 생성해서 준비(나중에 null 확인하기 위해서)
				do { // if문에서 rs.next로 이미 커서가 내려가 버려 do while을 써서 먼저 데이터 담음
					Community_reviewWriteDTO article = new Community_reviewWriteDTO();
					article.setReview_num(rs.getInt("Review_num"));
					article.setReview_targetGM(rs.getString("Review_targetGM"));
					article.setReview_id(rs.getString("Review_id"));
					article.setReview_title(rs.getString("Review_title"));
					article.setReview_content(rs.getString("Review_content"));
					article.setReview_file(rs.getString("Review_file"));
					article.setReview_view(rs.getInt("Review_view"));
					article.setReview_reg(rs.getTimestamp("Review_reg"));
					articles.add(article); // 리스트 추가
				}while(rs.next());
			}//if
					
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		
		return articles;
	}
	
	//자유게시판 글 내용
	public Community_writeDTO getFreeContent(int num) {
		Community_writeDTO dto = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			String sql = "update CMBoard set CMBoard_view = CMBoard_view + 1 where CMBoard_num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
			sql = "select * from CMBoard where CMBoard_num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new Community_writeDTO();
				dto.setCMBoard_num(rs.getInt("CMBoard_num"));
				dto.setCMBoard_title(rs.getString("CMBoard_title"));
				dto.setCMBoard_id(rs.getString("CMBoard_id"));
				dto.setCMBoard_content(rs.getString("CMBoard_content"));
				dto.setCMBoard_commCount(rs.getInt("CMBoard_commCount"));
				dto.setCMBoard_view(rs.getInt("CMBoard_view"));
				dto.setCMBoard_reg(rs.getTimestamp("CMBoard_reg"));
			}
					
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return dto;
	}
	
	//리뷰 글 내용
	public Community_reviewWriteDTO getReviewContent(int num) {
		Community_reviewWriteDTO dto = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			String sql = "update Review set Review_view = Review_view + 1 where Review_num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
			sql = "select * from Review where Review_num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new Community_reviewWriteDTO();
				dto.setReview_num(rs.getInt("Review_num"));
				dto.setReview_targetGM(rs.getString("Review_targetGM"));
				dto.setReview_id(rs.getString("Review_id"));
				dto.setReview_title(rs.getString("Review_title"));
				dto.setReview_content(rs.getString("Review_content"));
				dto.setReview_file(rs.getString("Review_file"));
				dto.setReview_view(rs.getInt("review_view"));
				dto.setReview_reg(rs.getTimestamp("Review_reg"));
			}
					
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return dto;
	}
	
	//후기게시판 내가 참가한 공모전 번호 가져오기
	public String[] getUserJoinGM(String id) {
		String[] names = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			String sql = "select usern_history from usern where usern_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				names = rs.getString("usern_history").split(",");
			}
					
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return names;
	}
	
	//공모 고유 번호 받으면 이름 리턴하는 메소드
	public String getGMName(int num) {
		String name = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			String sql = "select gmboard_title from gmboard where gmboard_num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				name = rs.getString("gmboard_title");
			}
					
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return name;
	}
	
	//후기게시판 글쓰기
	public int viewWrite(String title, String gmName, String content, String fileName, String id) {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			
			String sql = "insert into review(Review_num,Review_targetGM,Review_id,Review_title,Review_content,Review_file,Review_view,Review_reg) values(REVIEW_SEQ.nextVal,?,?,?,?,?,0,sysdate)";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, gmName);
			pstmt.setString(2, id);
			pstmt.setString(3, title);
			pstmt.setString(4, content);
			pstmt.setString(5, fileName);
			
			result = pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt!=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		
		return result;
	}
	
	//자유게시글 댓글 작성
	public int insertComment(Community_freeCommentDTO dto) {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int ref = dto.getCmComment_ref();
		int re_step = dto.getCmComment_step();
		int re_level = dto.getCmComment_level();
		int forRef = 0;
		
		try {
			conn = getConnection();
			//댓글 수 추가
			String sql = "update cmboard set cmboard_commcount = cmboard_commcount + 1 where cmboard_num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getCmComment_postNum());
			pstmt.executeUpdate();
			
			sql = "select max(cmcomment_num) from cmcomment";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				forRef = rs.getInt(1) + 1;
			}else forRef = 1;
			
			ref = forRef;
			sql = "insert into cmcomment(cmcomment_num,cmcomment_postNum,cmcomment_id,cmcomment_comm,cmcomment_level,cmcomment_step,cmcomment_ref,cmcomment_reg) values(CMCOMMENT_SEQ.nextVal,?,?,?,?,?,?,sysdate)";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, dto.getCmComment_postNum());
			pstmt.setString(2, dto.getCmComment_id());
			pstmt.setString(3, dto.getCmComment_comm());
			pstmt.setInt(4, re_level);
			pstmt.setInt(5, re_step);
			pstmt.setInt(6, ref);
			
			result = pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		
		return result;
	}
	
	//자유게시글 댓글 작성
	public int insertReComment(Community_freeCommentDTO dto) {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int ref = dto.getCmComment_ref();
		int re_step = dto.getCmComment_step();
		int re_level = dto.getCmComment_level();
		int forRef = 0;
		
		try {
			conn = getConnection();
			//댓글 수 추가
			String sql = "update cmboard set cmboard_commcount = cmboard_commcount + 1 where cmboard_num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getCmComment_postNum());
			pstmt.executeUpdate();
			
			sql = "select max(cmcomment_num) from cmcomment";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				forRef = rs.getInt(1) + 1;
			}else forRef = 1;
			
			sql = "update cmcomment set cmcomment_step=cmcomment_step+1 where cmcomment_ref=? and cmcomment_step > ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ref);
			pstmt.setInt(2, re_step);
			pstmt.executeUpdate();
			
			//답글은 DB에 저장하기전에, 받아온 초기값 0 에서 1이 되게 더해줌
			re_step += 1;
			re_level += 1;
			
			sql = "insert into cmcomment(cmcomment_num,cmcomment_postNum,cmcomment_id,cmcomment_comm,cmcomment_level,cmcomment_step,cmcomment_ref,cmcomment_reg) values(CMCOMMENT_SEQ.nextVal,?,?,?,?,?,?,sysdate)";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, dto.getCmComment_postNum());
			pstmt.setString(2, dto.getCmComment_id());
			pstmt.setString(3, dto.getCmComment_comm());
			pstmt.setInt(4, re_level);
			pstmt.setInt(5, re_step);
			pstmt.setInt(6, ref);
			
			result = pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		
		return result;
	}
	
	//자유게시판 댓글 유무
	public int getCommCount(int num) {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			
			String sql = "select cmboard_commcount from cmboard where cmboard_num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt("cmboard_commcount");
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		
		return result;
	}
	
	//해당 넘버 게시물의 댓글 정보 가져오기
	public List getCommArticle(int num, int start, int end) {
		List articles = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			
			String sql = "select B.*, r from (select A.*, rownum r from (select * from cmcomment where cmcomment_postnum = ? order by cmcomment_ref desc, cmcomment_step asc) A order by cmcomment_ref desc, cmcomment_step asc) B where r >= ? and r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				articles = new ArrayList(); //결과가 있으면 리스트 객체 생성해서 준비(나중에 null 확인하기 위해서)
				do { // if문에서 rs.next로 이미 커서가 내려가 버려 do while을 써서 먼저 데이터 담음
					Community_freeCommentDTO article = new Community_freeCommentDTO();
					article.setCmComment_num(rs.getInt("CmComment_num"));
					article.setCmComment_postNum(rs.getInt("CmComment_postNum"));
					article.setCmComment_id(rs.getString("CmComment_id"));
					article.setCmComment_comm(rs.getString("CmComment_comm"));
					article.setCmComment_level(rs.getInt("CmComment_level"));
					article.setCmComment_step(rs.getInt("CmComment_step"));
					article.setCmComment_ref(rs.getInt("CmComment_ref"));
					article.setCmComment_reg(rs.getTimestamp("CmComment_reg"));
					articles.add(article); // 리스트 추가
				}while(rs.next());
			}//if
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return articles;
	}
	
	public void deleteFreecontent(int num) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = getConnection();
			//게시글 삭제
			String sql = "delete from cmboard where cmboard_num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
			System.out.println("삭제");
			
			//댓글 존재하는지 체크
			sql = "select * from cmcomment where cmcomment_postnum = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				//댓글 존재하면 댓글들 삭제
				sql = "delete from cmcomment where cmcomment_postnum = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.executeUpdate();
			}

			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
	}
	
	public void deleteComm(int num) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			
			String sql = "select cmcomment_comm from cmcomment where cmcomment_num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				String comm = rs.getString("cmcomment_comm") + "({[DeLeTe]})삭제된 댓글입니다.";
				sql = "update cmcomment set cmcomment_comm = ? where cmcomment_num = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, comm);
				pstmt.setInt(2, num);
				pstmt.executeUpdate();
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
	}
	
	public void deleteReview(int num) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			//게시글 삭제
			String sql = "delete from review where review_num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt!=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
	}
	
	public Community_writeDTO getFreeArticle(int num) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Community_writeDTO dto = null;
		try {
			conn = getConnection();
			String sql = "select * from cmboard where cmboard_num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto = new Community_writeDTO();
				dto.setCMBoard_title(rs.getString("cmboard_title"));
				dto.setCMBoard_content(rs.getString("cmboard_content"));
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return dto;
	}
	
	public Community_reviewWriteDTO getReviewArticle(int num) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Community_reviewWriteDTO dto = null;
		try {
			conn = getConnection();
			String sql = "select * from review where review_num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto = new Community_reviewWriteDTO();
				dto.setReview_title(rs.getString("review_title"));
				dto.setReview_targetGM(rs.getString("Review_targetGM"));
				dto.setReview_file(rs.getString("Review_file"));
				dto.setReview_content(rs.getString("Review_content"));		
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt!=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return dto;
	}
	
	public void updateFreeContent(int num, String title, String content) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConnection();
			String sql = "update cmboard set cmboard_title = ?, cmboard_content = ? where cmboard_num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, content);
			pstmt.setInt(3, num);
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt!=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
	}
	
	public void updateViewNoFile(String title, String gmName, String content, int num) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			
			String sql = "update review set review_targetGM = ?, review_title = ?, review_content = ? where review_num = ?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, gmName);
			pstmt.setString(2, title);
			pstmt.setString(3, content);
			pstmt.setInt(4, num);
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt!=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
	}
	
	public void updateViewFile(String title, String gmName, String content, int num, String review_file) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			
			String sql = "update review set review_targetGM = ?, review_title = ?, review_content = ?, review_file = ? where review_num = ?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, gmName);
			pstmt.setString(2, title);
			pstmt.setString(3, content);
			pstmt.setString(4, review_file);
			pstmt.setInt(5, num);
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt!=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
	}
	
	public void commModify(String msg, int num) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = getConnection();
			
			String sql = "update cmcomment set cmcomment_comm = ? where cmcomment_num = ?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, msg);
			pstmt.setInt(2, num);
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt!=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
	}
}
