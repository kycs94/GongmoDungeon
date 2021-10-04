package team04.project.gongmo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import team04.project.login.signupDTO;


public class GongmoDAO {

private Connection getConnection() throws Exception{
		
		Context ctx = new InitialContext();
		Context env = (Context)ctx.lookup("java:comp/env");
		DataSource ds = (DataSource)env.lookup("jdbc/orcl");
		return ds.getConnection();
	}

	public GongmoWriteDTO setGmboard(String id, GongmoWriteDTO dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			
			conn = getConnection();
			String sql ="select * from userc where userc_id = ?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto.setGmboard_id(rs.getString("userc_id"));
				dto.setGmboard_name(rs.getString("userc_name"));
				dto.setGmboard_url(rs.getString("userc_url"));
				dto.setGmboard_type(rs.getString("userc_type"));
			}

			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt!=null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return dto;
	}


	// 공모전 추가 insert !!!
	public int insertGmBoard(GongmoWriteDTO gmboard) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result =-1;
		
		try {
			
			conn = getConnection();
			String sql ="insert into gmboard values(gmboard_seq.nextVal,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,sysdate)";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, gmboard.getGmboard_id());
			pstmt.setString(2, gmboard.getGmboard_title());
			pstmt.setString(3, gmboard.getGmboard_name());
			pstmt.setString(4, gmboard.getGmboard_favor());
			pstmt.setString(5, gmboard.getGmboard_target());
			pstmt.setString(6, gmboard.getGmboard_winner());
			pstmt.setString(7, gmboard.getGmboard_benefit());
			pstmt.setString(8, gmboard.getGmboard_money());
			pstmt.setString(9, gmboard.getGmboard_sday());
			pstmt.setString(10, gmboard.getGmboard_eday());
			pstmt.setString(11, gmboard.getGmboard_content());
			pstmt.setString(12, gmboard.getGmboard_url());
			pstmt.setString(13, gmboard.getGmboard_type());
			pstmt.setString(14, gmboard.getGmboard_poster());
			pstmt.setString(15, gmboard.getGmboard_file());
			pstmt.setInt(16, gmboard.getGmboard_view());
			
			result = pstmt.executeUpdate();
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt!=null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return result;
	}
	
	// 공모게스글 수정 
	public int updateGmBoard(GongmoWriteDTO gmboard, int num) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result =-1;
		
		try {
			
			conn = getConnection();
			String sql ="update gmboard set gmboard_title=?, gmboard_favor=?, gmboard_target=?, gmboard_winner=?, gmboard_benefit=?, gmboard_money=?, gmboard_sday=?, gmboard_eday=?, gmboard_content=?, gmboard_poster=?,gmboard_file=? where gmboard_num=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, gmboard.getGmboard_title());
			pstmt.setString(2, gmboard.getGmboard_favor());
			pstmt.setString(3, gmboard.getGmboard_target());
			pstmt.setString(4, gmboard.getGmboard_winner());
			pstmt.setString(5, gmboard.getGmboard_benefit());
			pstmt.setString(6, gmboard.getGmboard_money());
			pstmt.setString(7, gmboard.getGmboard_sday());
			pstmt.setString(8, gmboard.getGmboard_eday());
			pstmt.setString(9, gmboard.getGmboard_content());
			pstmt.setString(10, gmboard.getGmboard_poster());
			pstmt.setString(11, gmboard.getGmboard_file());
			pstmt.setInt(12, num);
			
			result = pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt!=null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return result;
	}

	// 공모 게시글 content 보여주기
	public GongmoWriteDTO getGmBoardList(int num) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		GongmoWriteDTO gmdto=null;
		int result = -1;
		
		try {
			conn = getConnection();
			String sql = "update gmboard set gmboard_view=gmboard_view+1 where gmboard_num=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
						
			sql ="select * from gmboard where gmboard_num=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				gmdto = new GongmoWriteDTO();
				gmdto.setGmboard_num(num);
				gmdto.setGmboard_title(rs.getString("gmboard_title"));
				gmdto.setGmboard_id(rs.getString("gmboard_id"));
				gmdto.setGmboard_name(rs.getString("gmboard_name"));
				gmdto.setGmboard_favor(rs.getString("gmboard_favor"));
				gmdto.setGmboard_target(rs.getString("gmboard_target"));
				gmdto.setGmboard_winner(rs.getString("gmboard_winner"));
				gmdto.setGmboard_benefit(rs.getString("gmboard_benefit"));
				gmdto.setGmboard_money(rs.getString("gmboard_money"));
				gmdto.setGmboard_sday(rs.getString("gmboard_sday"));
				gmdto.setGmboard_eday(rs.getString("gmboard_eday"));
				gmdto.setGmboard_content(rs.getString("gmboard_content"));
				gmdto.setGmboard_url(rs.getString("gmboard_url"));
				gmdto.setGmboard_type(rs.getString("gmboard_type"));
				gmdto.setGmboard_poster(rs.getString("gmboard_poster"));
				gmdto.setGmboard_file(rs.getString("gmboard_file"));
				gmdto.setGmboard_view(rs.getInt("gmboard_view"));
				gmdto.setGmboard_reg(rs.getTimestamp("gmboard_reg"));
				
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt!=null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return gmdto;
	}
	
	// 검색에 만족하는 리스트 count 가져오기
	public int searchGongmoCount(String list, String search) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count =0;
		
		try {
			
			conn = getConnection();
			String sql ="select count(*) from gmboard where "+list+ " like '%" +search+"%'";
			pstmt=conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt!=null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return count;
	}
	
	// 공모 list2(최신순, 스크랩순, 마감순, 조회순 으로 나오게 하기)
	public List showList2GongmoList(int startRow, int endRow, String list2) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List list=null;
		GongmoWriteDTO gmboard=null;
		
		try {
			conn=getConnection();
			String sql ="";
			if(list2.equals("gmboard_reg")) {
				sql="select B.*, r from (select A.*, rownum r from (select * from gmboard order by gmboard_reg desc)A)B where r>=? and r<=?";
			}else if(list2.equals("gmboard_eday")) {
				sql="select B.*, r from (select A.*, rownum r from (select * from gmboard order by gmboard_eday asc)A)B where r>=? and r<=?";
			}else if(list2.equals("gmboard_view")) {
				sql="select B.*, r from (select A.*, rownum r from (select * from gmboard order by gmboard_view desc)A)B where r>=? and r<=?";
			}else if(list2.equals("gmboard_num")) {
				sql="select a.* from (select gb.* , nvl(s.scrap_num,0), nvl(s.whole, 0) as cnt, rownum AS r from gmboard gb left outer join (select scrap_num, count(*) as Whole from scrap group by scrap_num) s on gb.gmboard_num = s.scrap_num) a where a.r>=? and a.r<=? order by a.cnt desc";
			}
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				list = new ArrayList();
				do {
					gmboard = new GongmoWriteDTO();
					gmboard.setGmboard_num(rs.getInt("gmboard_num"));
					gmboard.setGmboard_title(rs.getString("gmboard_title"));
					gmboard.setGmboard_name(rs.getString("gmboard_name"));
					gmboard.setGmboard_sday(rs.getString("gmboard_sday"));
					gmboard.setGmboard_eday(rs.getString("gmboard_eday"));
					gmboard.setGmboard_view(rs.getInt("gmboard_view"));
					gmboard.setGmboard_poster(rs.getString("gmboard_poster"));
					
					list.add(gmboard);
				}while(rs.next());
			}			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt!=null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return list;
	}
	
	// 공모 리스트 있는지 없는지 count 체크 가져오기
	public int showGongmoCount() {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count =0;
		
		try {
			
			conn = getConnection();
			String sql ="select count(*) from gmboard";
			pstmt=conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt!=null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return count;
	}
	
	// 검색했을때 리스트 가져오기
	public List showsearchGongmoList(int startRow,int endRow, String list, String search) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List list1=null;
		GongmoWriteDTO gmboard=null;
		
		try {
			conn = getConnection();
			String sql="select B.*, r from (select A.*, rownum r from (select * from gmboard where "+list+" like '%" +search+"%')A order by gmboard_reg desc)B where r>=? and r<=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			
			rs =pstmt.executeQuery();
			if(rs.next()) {
				list1 = new ArrayList();
				do {
					gmboard = new GongmoWriteDTO();
					gmboard.setGmboard_num(rs.getInt("gmboard_num"));
					gmboard.setGmboard_title(rs.getString("gmboard_title"));
					gmboard.setGmboard_name(rs.getString("gmboard_name"));
					gmboard.setGmboard_sday(rs.getString("gmboard_sday"));
					gmboard.setGmboard_eday(rs.getString("gmboard_eday"));
					gmboard.setGmboard_view(rs.getInt("gmboard_view"));
					gmboard.setGmboard_poster(rs.getString("gmboard_poster"));
					
					list1.add(gmboard);
				}while(rs.next());
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt!=null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return list1;
	}
	
	// 전체 공모 게시글 가져오기
	public List showGongmoListY(int startRow,int endRow) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List list=null;
		GongmoWriteDTO gmboard=null;
		
		try {
			conn = getConnection();
			String sql="select B.*, r from (select A.*, rownum r from (select * from gmboard order by gmboard_reg desc)A)B where r>=? and r<=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			
			rs =pstmt.executeQuery();
			if(rs.next()) {
				list = new ArrayList();
				do {
					gmboard = new GongmoWriteDTO();
					gmboard.setGmboard_num(rs.getInt("gmboard_num"));
					gmboard.setGmboard_title(rs.getString("gmboard_title"));
					gmboard.setGmboard_name(rs.getString("gmboard_name"));
					gmboard.setGmboard_sday(rs.getString("gmboard_sday"));
					gmboard.setGmboard_eday(rs.getString("gmboard_eday"));
					gmboard.setGmboard_view(rs.getInt("gmboard_view"));
					gmboard.setGmboard_poster(rs.getString("gmboard_poster"));
					
					list.add(gmboard);
				}while(rs.next());
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt!=null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn!=null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return list;
	}
	
	// 팀 만들기 -> 등록 메소드
		public int insertmakeTeam(GongmoTeamMakeDTO dto, String str, String id, int num) {
			
			Connection conn = null;
			PreparedStatement pstmt = null;
			int result =-1;
			
			
			try {

				conn = getConnection();
				String sql ="insert into maketeam values(maketeam_seq.nextVal,?,?,?,?,?,?,?,?,?,?,sysdate)";
				pstmt=conn.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.setString(2, id);
				pstmt.setString(3, dto.getMaketeam_title());
				pstmt.setString(4, dto.getMaketeam_name());
				pstmt.setInt(5, dto.getMaketeam_Ptotal());
				pstmt.setString(6, str);
				pstmt.setInt(7, dto.getMaketeam_view());
				pstmt.setString(8, dto.getMaketeam_content());
				pstmt.setString(9, dto.getMaketeam_pnow());
				pstmt.setString(10, dto.getMaketeam_done());
				
				result = pstmt.executeUpdate();
				
				
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(pstmt!=null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
				if(conn!=null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
			}
			return result;
		}
		
		// 팀원 모집 게시글이 있는지 없는지 count
		public int showTeamListCount(int num) {
			
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			int count = 0;
			
			try {
				
				conn = getConnection();
				String sql ="select count(*) from maketeam where maketeam_targetgm=?";
				pstmt=conn.prepareStatement(sql);
				pstmt.setInt(1, num);
				
				rs = pstmt.executeQuery();
				if(rs.next()) {
					count = rs.getInt(1);
				}
				
				
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs!=null) try {rs.close();}catch(Exception e) {e.printStackTrace();}
				if(pstmt!=null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
				if(conn!=null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
			}
			return count;
		}
		
		// 팀원게시글 count 0개 이상일때
		public List showTeamList(int num1, int startRow, int endRow) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List list=null;
			GongmoTeamMakeDTO dto;
			
			try {
				
				conn = getConnection();
				String sql ="select B.*, r from (select A.*, rownum r from (select * from maketeam)A order by maketeam_reg desc)B where maketeam_targetgm=? and r>=? and r<=?";
				pstmt=conn.prepareStatement(sql);
				pstmt.setInt(1, num1);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					list = new ArrayList();
					do {
						dto= new GongmoTeamMakeDTO();
						dto.setMaketeam_num(rs.getInt("maketeam_num"));
						dto.setMaketeam_targetGM(num1);
						dto.setMaketeam_id(rs.getString("maketeam_id"));
						dto.setMaketeam_title(rs.getString("maketeam_title"));
						dto.setMaketeam_name(rs.getString("maketeam_name"));
						dto.setMaketeam_Ptotal(rs.getInt("maketeam_Ptotal"));
						dto.setMaketeam_job(rs.getString("maketeam_job"));
						dto.setMaketeam_view(rs.getInt("maketeam_view"));
						dto.setMaketeam_content(rs.getString("maketeam_content"));
						dto.setMaketeam_pnow(rs.getString("maketeam_pnow"));
						dto.setMaketeam_done(rs.getString("maketeam_done"));
						dto.setMaketeam_reg(rs.getTimestamp("maketeam_reg"));
						
						list.add(dto);
						
					}while(rs.next());
				}			
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs!=null) try {rs.close();}catch(Exception e) {e.printStackTrace();}
				if(pstmt!=null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
				if(conn!=null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
			}
			return list;
		}
		
		// num 가지고 해당 게시글 내용 가져오기
		public GongmoTeamMakeDTO getListContent(int num) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			GongmoTeamMakeDTO dto=null;
			
			
			try {
				
				conn = getConnection();
				String sql = "update maketeam set maketeam_view=maketeam_view+1 where maketeam_num = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.executeUpdate();
				
				sql ="select * from maketeam where maketeam_num=?";
				pstmt=conn.prepareStatement(sql);
				pstmt.setInt(1, num);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
						dto= new GongmoTeamMakeDTO();
						dto.setMaketeam_num(rs.getInt("maketeam_num"));
						dto.setMaketeam_targetGM(rs.getInt("maketeam_targetGM"));
						dto.setMaketeam_id(rs.getString("maketeam_id"));
						dto.setMaketeam_title(rs.getString("maketeam_title"));
						dto.setMaketeam_name(rs.getString("maketeam_name"));
						dto.setMaketeam_Ptotal(rs.getInt("maketeam_Ptotal"));
						dto.setMaketeam_job(rs.getString("maketeam_job"));
						dto.setMaketeam_view(rs.getInt("maketeam_view"));
						dto.setMaketeam_content(rs.getString("maketeam_content"));
						dto.setMaketeam_pnow(rs.getString("maketeam_pnow"));
						dto.setMaketeam_done(rs.getString("maketeam_done"));
						dto.setMaketeam_reg(rs.getTimestamp("maketeam_reg"));
						
				}		
						
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs!=null) try {rs.close();}catch(Exception e) {e.printStackTrace();}
				if(pstmt!=null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
				if(conn!=null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
			}
			return dto;
		}
		
		// 지원자가 있는지 없는지
		public int applyListCount(int mnum) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			int count = 0;
			
			try {
				
				conn = getConnection();
				String sql ="select count(*) from applyteam where applyteam_postnum=?";
				pstmt=conn.prepareStatement(sql);
				pstmt.setInt(1, mnum);
				
				rs = pstmt.executeQuery();
				if(rs.next()) {
					count = rs.getInt(1);
				}
				
				
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs!=null) try {rs.close();}catch(Exception e) {e.printStackTrace();}
				if(pstmt!=null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
				if(conn!=null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
			}
			return count;
		}
		
		// (지원)apply한 사람 리스트
		public List applyList(int mnum) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List list=null;
			GongmoTeamApplyDTO dto;
			
			try {
				
				conn = getConnection();
				String sql ="select * from applyteam where applyteam_postnum=?";
				pstmt=conn.prepareStatement(sql);
				pstmt.setInt(1, mnum);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					list = new ArrayList();
					do {
						dto= new GongmoTeamApplyDTO();
						dto.setApplyteam_num(rs.getInt("applyteam_num"));
						dto.setApplyteam_postNum(rs.getInt("applyteam_postNum"));
						dto.setApplyteam_id(rs.getString("applyteam_id"));
						dto.setApplyteam_comm(rs.getString("applyteam_comm"));
						dto.setApplyteam_result(rs.getInt("applyteam_result"));
						dto.setApplyteam_reg(rs.getTimestamp("applyteam_reg"));
						
						list.add(dto);
						
					}while(rs.next());
				}			
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(rs!=null) try {rs.close();}catch(Exception e) {e.printStackTrace();}
				if(pstmt!=null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
				if(conn!=null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
			}
			return list;
		}
		
		// contentTeam.jsp에서 접수 누르면 지원 insert 가능하게
		public int insertApplyTeam(int mnum, String applyteam_comm, String id) {
			
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			int result =-1;
			
			try {
				
				conn = getConnection();
				String sql = "select * from maketeam where maketeam_num = ?";
				pstmt=conn.prepareStatement(sql);
				pstmt.setInt(1, mnum);
				
				rs =pstmt.executeQuery();
				
				if(rs.next()) {
					sql ="insert into applyteam values(applyteam_seq.nextVal, ?, ?, ?, 0 , sysdate)";
					pstmt=conn.prepareStatement(sql);
					pstmt.setInt(1, mnum);
					pstmt.setString(2, id);
					pstmt.setString(3, applyteam_comm);
					
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
		
		// 팀장이 지원자 합격 줬을때,
		public int okresult(int mnum, String applyteam_id) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			int result = -1;
			
			try {
				conn = getConnection();
				String sql = "update applyteam set applyteam_result=1 where applyteam_postnum=? and applyteam_id =? ";
				pstmt=conn.prepareStatement(sql);
				pstmt.setInt(1, mnum);
				pstmt.setString(2, applyteam_id);
				
				result = pstmt.executeUpdate();
				
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				if(pstmt!=null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
				if(conn!=null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
			}
			return result;
		}
		
		// 팀장이 지원자 합격을 줬을떄, maketeam_pnow에 지원자 추가
		public int updatemaketeamPnowY(int mnum, String applyteam_id) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			int result = -1;
			
			try {
				conn=getConnection();
				String sql ="select maketeam_pnow from maketeam where maketeam_num=?";
				pstmt=conn.prepareStatement(sql);
				pstmt.setInt(1, mnum);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					String pnow = rs.getString(1);
					if(pnow.equals("0")) {
						sql = "update maketeam set maketeam_pnow=? where maketeam_num=?";
						pstmt=conn.prepareStatement(sql);
						pstmt.setString(1, applyteam_id);
						pstmt.setInt(2, mnum);
						result = pstmt.executeUpdate();
					}else {
						
						sql = "update maketeam set maketeam_pnow= concat(concat(maketeam_pnow, ','), ?) where maketeam_num=?";
						pstmt=conn.prepareStatement(sql);
						pstmt.setString(1, applyteam_id);
						pstmt.setInt(2, mnum);
						result = pstmt.executeUpdate();
					}
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
		
		// 팀장이 지원자 합격을 줬다가 추방 시켰을때 maketeam_pnow 에서 삭제가 되어야한다 ,,,
				public GongmoTeamMakeDTO updatemaketeamPnowO(int mnum) {
					Connection conn = null;
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					GongmoTeamMakeDTO gmdto = null;
					
					try {
						conn=getConnection();
						String sql ="select maketeam_pnow from maketeam where maketeam_num=?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setInt(1, mnum);
						rs = pstmt.executeQuery();
						if(rs.next()) {
							gmdto = new GongmoTeamMakeDTO();
							gmdto.setMaketeam_pnow(rs.getString(1));
						}
						
					}catch(Exception e) {
						e.printStackTrace();
					}finally {
						if(rs!=null) try {rs.close();}catch(Exception e) {e.printStackTrace();}
						if(pstmt!=null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
						if(conn!=null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
					}
					return gmdto;
				}
				
			// 추방 눌렀을때 maketeam_pnow 추방된 사람 빼고 인간 업데이트...
				public int outresult(int mnum, String newPnow) {
					Connection conn = null;
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					int result = -1;
					
					try {
						conn = getConnection();
						String sql = "update maketeam set maketeam_pnow=? where maketeam_num=?";
						pstmt=conn.prepareStatement(sql);
						pstmt.setString(1, newPnow);
						pstmt.setInt(2, mnum);
						result = pstmt.executeUpdate();
						
						sql = "select maketeam_pnow from maketeam where maketeam_num=?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setInt(1, mnum);
						rs = pstmt.executeQuery();
						if(rs.next()) {
							if(rs.getString(1)==null) {
								sql = "update maketeam set maketeam_pnow=0 where maketeam_num=?";
								pstmt=conn.prepareStatement(sql);
								pstmt.setInt(1, mnum);
								result = pstmt.executeUpdate();
							}
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
		
		
	
		// 팀장이 지원자 합격 줬을때,
				public int noresult(int mnum, String applyteam_id) {
					Connection conn = null;
					PreparedStatement pstmt = null;
					int result = 0;
					
					try {
						conn = getConnection();
						String sql = "update applyteam set applyteam_result=2 where applyteam_postnum=? and applyteam_id =? ";
						pstmt=conn.prepareStatement(sql);
						pstmt.setInt(1, mnum);
						pstmt.setString(2, applyteam_id);
						
						result = pstmt.executeUpdate();
						
					}catch(Exception e) {
						e.printStackTrace();
					}finally {
						if(pstmt!=null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
						if(conn!=null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
					}
					return result;
				}
	
				// applyteam 내용 수정
				public int applyModify(int amun, String applyteam_comm1) {
					Connection conn = null;
					PreparedStatement pstmt = null;
					int result = 0;
					
					try {
						conn = getConnection();
						String sql = "update applyteam set applyteam_comm=? where applyteam_num =? ";
						pstmt=conn.prepareStatement(sql);
						pstmt.setString(1, applyteam_comm1);
						pstmt.setInt(2, amun);
						
						result = pstmt.executeUpdate();
						
					}catch(Exception e) {
						e.printStackTrace();
					}finally {
						if(pstmt!=null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
						if(conn!=null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
					}
					return result;
				}
				
			// applyteam 지원 삭제
				public int deleteModify(int anum, String applyteam_id, String applyteam_comm) {
					Connection conn = null;
					PreparedStatement pstmt = null;
					int result = -1;
					
					try {
						conn = getConnection();
						String sql = "delete from applyteam where applyteam_num=? and applyteam_id =? and applyteam_comm=?";
						pstmt=conn.prepareStatement(sql);
						pstmt.setInt(1, anum);
						pstmt.setString(2, applyteam_id);
						pstmt.setString(3, applyteam_comm);
						
						result = pstmt.executeUpdate();
						
					}catch(Exception e) {
						e.printStackTrace();
					}finally {
						if(pstmt!=null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
						if(conn!=null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
					}
					return result;
				}
	
			// 팀장이 팀원모집 삭제할때
				public int deleteTeam(String id, String pw, int mnum) {
						Connection conn = null;
						PreparedStatement pstmt =null;
						ResultSet rs =null;
						int result = -1;
						
						try {
							conn = getConnection();
							String sql = "select usern_pw from usern where usern_id=?";
							pstmt=conn.prepareStatement(sql);
							pstmt.setString(1, id);
							rs =pstmt.executeQuery();
							if(rs.next()) {
								String dbpw=rs.getString(1);
								if(dbpw.equals(pw)) {
									sql="delete from maketeam where maketeam_id=? and maketeam_num=?";
									pstmt=conn.prepareStatement(sql);
									pstmt.setString(1, id);
									pstmt.setInt(2, mnum);
									result = pstmt.executeUpdate();
								}
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
				
				// 파일 삭제 할때 poster, file 가져오기
				public GongmoWriteDTO getPoster(String id) {
					Connection conn =null;
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					GongmoWriteDTO gmdto = null;
					
					try {
						conn = getConnection();
						String sql ="select gmboard_poster,gmboard_file from gmboard where gmboard_id=?";
						pstmt=conn.prepareStatement(sql);
						pstmt.setString(1, id);
						
						rs = pstmt.executeQuery();
						if(rs.next()) {
							gmdto= new GongmoWriteDTO();
							gmdto.setGmboard_poster(rs.getString("gmboard_poster"));
							gmdto.setGmboard_file(rs.getString("gmboard_file"));
						}
						
					}catch(Exception e) {
						e.printStackTrace();
					}finally {
						if (rs != null) { try { rs.close(); } catch (Exception e) { e.printStackTrace(); } } 
						if (pstmt != null) { try { pstmt.close(); } catch (Exception e) { e.printStackTrace(); } } 
						if (conn != null) { try { conn.close(); } catch (Exception e) { e.printStackTrace(); } }
					}
					return gmdto;
				}
				
			// 공모 게시글 삭제
				public int deleteGongmo(String id, String pw, int num) {
					Connection conn = null;
					PreparedStatement pstmt =null;
					ResultSet rs =null;
					int result = -1;
					
					try {
						conn = getConnection();
						String sql = "select userc_pw from userc where userc_id=?";
						pstmt=conn.prepareStatement(sql);
						pstmt.setString(1, id);
						rs =pstmt.executeQuery();
						if(rs.next()) {
							String dbpw=rs.getString(1);
							if(dbpw.equals(pw)) {
								sql="delete from gmboard where gmboard_id=? and gmboard_num=?";
								pstmt=conn.prepareStatement(sql);
								pstmt.setString(1, id);
								pstmt.setInt(2, num);
								result = pstmt.executeUpdate();
							}
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
				
			// gmboard_num에 make팀이 있는지 없는지 확인
				public int countMaketeam(int num) {
					Connection conn = null;
					PreparedStatement pstmt = null;
					ResultSet rs =null;
					int count = -1;
					try {
						conn = getConnection();
						String sql = "select count(*) from maketeam where maketeam_targetgm=?";
						pstmt=conn.prepareStatement(sql);
						pstmt.setInt(1, num);
						rs = pstmt.executeQuery();
						if(rs.next()) {
							count  = rs.getInt(1);
						}
						
					}catch(Exception e) {
						e.printStackTrace();
					}finally {
						if(rs!=null) try {rs.close();}catch(Exception e) {e.printStackTrace();}
						if(pstmt!=null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
						if(conn!=null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
					}
					return count;
				}
				
			// 공모전 글 삭제하면  maketeam도 삭제
				public int deleteMaketeam(int num) {
					Connection conn = null;
					PreparedStatement pstmt = null;
					int result = -1;
					try {
						conn = getConnection();
						String sql = "delete from maketeam where maketeam_targetgm=?";
						pstmt=conn.prepareStatement(sql);
						pstmt.setInt(1, num);
						result = pstmt.executeUpdate();
						
					}catch(Exception e) {
						e.printStackTrace();
					}finally {
						if(pstmt!=null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
						if(conn!=null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
					}
					return result;
				}
				
			// num 으로 maketeam_num 뽑기 
				public GongmoTeamMakeDTO getMaketeamNum(int num) {
					Connection conn = null;
					PreparedStatement pstmt = null;
					ResultSet rs =null;
					GongmoTeamMakeDTO dto=null;
					try {
						conn = getConnection();
						String sql ="select maketeam_num from maketeam where maketeam_targetgm=?";
						pstmt=conn.prepareStatement(sql);
						pstmt.setInt(1, num);
						rs = pstmt.executeQuery();
						if(rs.next()) {
							dto = new GongmoTeamMakeDTO();
							dto.setMaketeam_num(rs.getInt(1));
						}
					}catch(Exception e) {
						e.printStackTrace();
					}finally {
						if(rs!=null) try {rs.close();}catch(Exception e) {e.printStackTrace();}
						if(pstmt!=null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
						if(conn!=null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
					}
					return dto;
				}
				
			// maketaem_num에 Apply팀이 있는지 없는지 확인
				public int countApplyteam(int mnum) {
					Connection conn = null;
					PreparedStatement pstmt = null;
					ResultSet rs =null;
					int count = -1;
					try {
						conn = getConnection();
						String sql = "select count(*) from applyteam where applyteam_postnum=?";
						pstmt=conn.prepareStatement(sql);
						pstmt.setInt(1, mnum);
						rs = pstmt.executeQuery();
						if(rs.next()) {
							count  = rs.getInt(1);
						}
						
					}catch(Exception e) {
						e.printStackTrace();
					}finally {
						if(rs!=null) try {rs.close();}catch(Exception e) {e.printStackTrace();}
						if(pstmt!=null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
						if(conn!=null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
					}
					return count;
				}				
				
			// 공모전 글 삭제하면 applyteam도 삭제
				public int deleteApplyteam(int mnum) {
					Connection conn = null;
					PreparedStatement pstmt = null;
					int result = -1;
					try {
						conn = getConnection();
						String sql = "delete from applyteam where applyteam_postnum= ?";
						pstmt=conn.prepareStatement(sql);
						pstmt.setInt(1, mnum);
						result = pstmt.executeUpdate();
						
					}catch(Exception e) {
						e.printStackTrace();
					}finally {
						if(pstmt!=null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
						if(conn!=null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
					}
					return result;
				}
				
			// True or false
				public boolean TFmaketeamNum(int num) {
					Connection conn = null;
					PreparedStatement pstmt = null;
					ResultSet rs =null;
					boolean result = false;
					try {
						conn = getConnection();
						String sql ="select maketeam_num from maketeam where maketeam_targetgm=?";
						pstmt=conn.prepareStatement(sql);
						pstmt.setInt(1, num);
						rs = pstmt.executeQuery();
						if(rs.next()) {
							result = true;
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
	
			// 평가 누르면 세션 id와 applyteam_id 같은지 확인!!
				public boolean getapplyName(int anum, String id) {
					Connection conn = null;
					PreparedStatement pstmt = null;
					ResultSet rs =null;
					boolean result = false;
					
					try {
						conn = getConnection();
						String sql = "select applyteam_id from applyteam where applyteam_num =?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setInt(1, anum);
						rs = pstmt.executeQuery();
						if(rs.next()) {
							String dbid=rs.getString(1);
							if(dbid.contentEquals(id)) {
								result = true;
							}
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
				
				// 세션 id와 지원자id 확인 후 합격자에대한 팀원 리스트 출력
				public List applyTeamList(int mnum, String id) {
					Connection conn = null;
					PreparedStatement pstmt = null;
					ResultSet rs =null;
					GongmoTeamApplyDTO adto;
					List list=null;
					try {
						conn = getConnection();
						String sql ="select applyteam_id from applyteam where applyteam_postnum=? and applyteam_result=1 and applyteam_id NOT IN(?)";
						pstmt=conn.prepareStatement(sql);
						pstmt.setInt(1, mnum);
						pstmt.setString(2, id);
						rs = pstmt.executeQuery();
						if(rs.next()) {
							list = new ArrayList();
							do {
								adto=new GongmoTeamApplyDTO();
								adto.setApplyteam_id(rs.getString("applyteam_id"));
								list.add(adto);
							}while(rs.next());
						}
					}catch(Exception e) {
						e.printStackTrace();
					}finally {
						if(rs!=null) try {rs.close();}catch(Exception e) {e.printStackTrace();}
						if(pstmt!=null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
						if(conn!=null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
					}
					return list;
				}				
				
				// 팀 수정 Update
				public int updatemakeTeam(GongmoTeamMakeDTO dto, String str, String id, int num, int mnum) {
					Connection conn = null;
					PreparedStatement pstmt = null;
					int result =-1;
					
					try {
						conn = getConnection();
						String sql ="update maketeam set maketeam_title=?, maketeam_name=?, maketeam_ptotal=?, maketeam_job=? ,maketeam_content=? where maketeam_num=? and maketeam_id=?";
						pstmt=conn.prepareStatement(sql);
						pstmt.setString(1, dto.getMaketeam_title());
						pstmt.setString(2, dto.getMaketeam_name());
						pstmt.setInt(3, dto.getMaketeam_Ptotal());
						pstmt.setString(4, str);
						pstmt.setString(5, dto.getMaketeam_content());
						pstmt.setInt(6, mnum);
						pstmt.setString(7, id);
						
						result = pstmt.executeUpdate();
					}catch(Exception e) {
						e.printStackTrace();
					}finally {
						
						if(pstmt!=null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
						if(conn!=null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
					}
					return result;
				}
				
			// 현재 모집된 팀원이 있으면 팀수정 불가!!
				public boolean pnowCheck(int mnum) {
					Connection conn = null;
					PreparedStatement pstmt = null;
					ResultSet rs =null;
					Boolean result = false;
					
					try {
						conn = getConnection();
						String sql ="select maketeam_pnow from maketeam where maketeam_num=?";
						pstmt=conn.prepareStatement(sql);
						pstmt.setInt(1, mnum);
						rs =pstmt.executeQuery();
						if(rs.next()) {
							String pnow = rs.getString(1);
							System.out.println("pnow= "+pnow);
							if(pnow.equals("0")) {
								result = true;
							}else {
								result = false;
							}
								
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
				
				// 현재 모집된 인원 뽑아오기
			public GongmoTeamMakeDTO pnowdelete(int mnum) {
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs =null;
				Boolean result = false;
				GongmoTeamMakeDTO gmdto=null;
				
				try {
					conn = getConnection();
					String sql ="select maketeam_pnow from maketeam where maketeam_num=?";
					pstmt=conn.prepareStatement(sql);
					pstmt.setInt(1, mnum);
					rs =pstmt.executeQuery();
					if(rs.next()) {
						gmdto = new GongmoTeamMakeDTO();
						gmdto.setMaketeam_pnow(rs.getString(1));
							
					}
			
				}catch(Exception e) {
					e.printStackTrace();
				}finally {
					if(rs!=null) try {rs.close();}catch(Exception e) {e.printStackTrace();}
					if(pstmt!=null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
					if(conn!=null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
				}
				return gmdto;
			}	
			
			// 팀원 평가를 완료한 세션은 maketeam_done 에 이름이 들어간다.
			public int donePopul(String id, int mnum) {
				Connection conn= null;
				PreparedStatement pstmt = null;
				ResultSet rs =null;
				int result = -1;
				try {
					conn=getConnection();
					String sql ="select maketeam_done from maketeam where maketeam_num=?";
					pstmt=conn.prepareStatement(sql);
					pstmt.setInt(1, mnum);
					rs = pstmt.executeQuery();
					
					if(rs.next()) {
						String done = rs.getString(1);
						if(done.equals("0")) {
							sql = "update maketeam set maketeam_done=? where maketeam_num=?";
							pstmt=conn.prepareStatement(sql);
							pstmt.setString(1, id);
							pstmt.setInt(2, mnum);
							result = pstmt.executeUpdate();
						}else {
							
							sql = "update maketeam set maketeam_done= concat(concat(maketeam_done, ','), ?) where maketeam_num=?";
							pstmt=conn.prepareStatement(sql);
							pstmt.setString(1, id);
							pstmt.setInt(2, mnum);
							result = pstmt.executeUpdate();
						}
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
			
			// 팀에 중복 지원 못하게 막기 위해 id 체크
			public List applyIdCheck(int mnum) {
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs =null;
				List list = null;
				GongmoTeamApplyDTO adto =null;
				try {
					conn =getConnection();
					String sql ="select applyteam_id from applyteam where applyteam_postnum=?";
					pstmt=conn.prepareStatement(sql);
					pstmt.setInt(1, mnum);
					rs = pstmt.executeQuery();
					if(rs.next()) {
						list = new ArrayList();
						do {
							adto = new GongmoTeamApplyDTO();
							adto.setApplyteam_id(rs.getString(1));
							list.add(adto);
						}while(rs.next());
					}
				}catch(Exception e) {
					e.printStackTrace();
				}finally {
					if(rs!=null) try {rs.close();}catch(Exception e) {e.printStackTrace();}
					if(pstmt!=null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
					if(conn!=null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
				}
				return list;
			}
			
			// 팀에 지원한 사람의 id랑 합격했는지.
			public List applyIdJob(int mnum) {
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs =null;
				List list = null;
				signupDTO lodto =null;
				try {
					conn = getConnection();
					String sql = "select applyteam_id from applyteam where applyteam_postnum=? and applyteam_result=1";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, mnum);
					rs = pstmt.executeQuery();
					if(rs.next()) {
						list = new ArrayList();
						do {
							lodto = new signupDTO();
							lodto.setUsern_id(rs.getString(1));
							list.add(lodto);
						}while(rs.next());
					}
					
				}catch(Exception e) {
					e.printStackTrace();
				}finally {
					if(rs!=null) try {rs.close();}catch(Exception e) {e.printStackTrace();}
					if(pstmt!=null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
					if(conn!=null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
				}
				return list;
			}
			
			// mnum에 맞는 maketeam_job 확인
			public GongmoTeamMakeDTO JobCheck(int mnum) {
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs =null;
				GongmoTeamMakeDTO gmdto = null;
				try {
					conn = getConnection();
					String sql = "select maketeam_job,maketeam_id from maketeam where maketeam_num=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, mnum);
					rs = pstmt.executeQuery();
					if(rs.next()) {
						gmdto = new GongmoTeamMakeDTO();
						gmdto.setMaketeam_job(rs.getString(1));
						gmdto.setMaketeam_id(rs.getString(2));
					}
					
				}catch(Exception e) {
					e.printStackTrace();
				}finally {
					if(rs!=null) try {rs.close();}catch(Exception e) {e.printStackTrace();}
					if(pstmt!=null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
					if(conn!=null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
				}
				return gmdto;
			}
			
		// 참가한 공모전 번호 usern_history 에 넣기
			public int inserthistory(String id, int num) {
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs =null;		
				int result =-1;
				try {
					conn = getConnection();
					String sql ="select usern_history from usern where usern_id=?";
					pstmt=conn.prepareStatement(sql);
					pstmt.setString(1, id);
					rs = pstmt.executeQuery();
					if(rs.next()) {
						if(rs.getString(1).equals("0")) {
							sql = "update usern set usern_history=? where usern_id=?";
							pstmt=conn.prepareStatement(sql);
							pstmt.setInt(1, num);
							pstmt.setString(2, id);
							result = pstmt.executeUpdate();
						}else {
							sql = "update usern set usern_history= concat(concat(usern_history, ','), ?) where usern_id=? ";
							pstmt=conn.prepareStatement(sql);
							pstmt.setInt(1, num);
							pstmt.setString(2, id);
							result = pstmt.executeUpdate();
						}
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
			
			// 세션id 히스토리 가져오기
			public signupDTO userhistory(String id) {
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs =null;	
				signupDTO sdto = null;
				try {
					conn=getConnection();
					String sql ="select usern_history from usern where usern_id=?";
					pstmt=conn.prepareStatement(sql);
					pstmt.setString(1, id);
					rs = pstmt.executeQuery();
					if(rs.next()) {
						sdto= new signupDTO();
						sdto.setUsern_history(rs.getString(1));						
					}
				}catch(Exception e) {
					e.printStackTrace();
				}finally {
					if(rs!=null) try {rs.close();}catch(Exception e) {e.printStackTrace();}
					if(pstmt!=null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
					if(conn!=null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
				}
				return sdto;
			}
			
			// 스크랩에 id가 있는지 없는지
			public int scrapYN(String id, int num) {
				
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				int result = -1;
				
				try {
					conn = getConnection();
					String sql = "select * from scrap where scrap_num=? and scrap_id=?";
					pstmt=conn.prepareStatement(sql);
					pstmt.setInt(1, num);
					pstmt.setString(2, id);
					
					rs = pstmt.executeQuery();
					if(rs.next()) {
						result = 1;
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
			
			//스크랩 insert!!
			public int scrapinsert(String id, int num) {
				
				Connection conn=null;
				PreparedStatement pstmt=null;
				int result = -1;
				
				try {
					conn =getConnection();
					String sql = "insert into scrap values(?,?)";
					pstmt=conn.prepareStatement(sql);
					pstmt.setInt(1, num);
					pstmt.setString(2, id);
					
					result = pstmt.executeUpdate();
					
				}catch(Exception e) {
					e.printStackTrace();
				}finally {
					if(pstmt!=null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
					if(conn!=null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
				}
				return result;
			}
			
			// 스크랩 취소 
			public int scrapdelete(String id, int num) {
				Connection conn=null;
				PreparedStatement pstmt=null;
				int result = -1;
				
				try {
					conn =getConnection();
					String sql = "delete from scrap where scrap_num=? and scrap_id=? ";
					pstmt=conn.prepareStatement(sql);
					pstmt.setInt(1, num);
					pstmt.setString(2, id);
					
					result = pstmt.executeUpdate();
					
				}catch(Exception e) {
					e.printStackTrace();
				}finally {
					if(pstmt!=null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
					if(conn!=null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
				}
				return result;
			}
			
			// 공모 마감날짜 찾기
			public GongmoWriteDTO getEndday(int num) {
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				GongmoWriteDTO dto=null;
				
				try {
					conn = getConnection();
					String sql = "select gmboard_eday from gmboard where gmboard_num=?";
					pstmt=conn.prepareStatement(sql);
					pstmt.setInt(1, num);
					rs = pstmt.executeQuery();
					
					if(rs.next()) {
						dto = new GongmoWriteDTO();
						dto.setGmboard_eday(rs.getString("gmboard_eday"));
					}
					
				}catch(Exception e) {
					e.printStackTrace();
				}finally {
					if(rs!=null) try {rs.close();}catch(Exception e) {e.printStackTrace();}
					if(pstmt!=null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
					if(conn!=null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
				}
				return dto;
			}
			
			// 공모전 월별로 가져오기
	         public List getArticles(String start_day, String end_day) {
	            Connection conn = null;
	            PreparedStatement pstmt = null;
	            ResultSet rs = null;
	            List list = null;
	            GongmoWriteDTO gmdto =null;
	            try {
	               conn=getConnection();
	               String sql ="select gmboard_num, gmboard_sday, gmboard_title,gmboard_poster,gmboard_eday from gmboard where gmboard_sday >= ? and gmboard_sday <= ?";
	               pstmt=conn.prepareStatement(sql);
	               pstmt.setString(1, start_day);
	               pstmt.setString(2, end_day);
	               rs = pstmt.executeQuery();
	               if(rs.next()) {
	                  list = new ArrayList();
	                  do {
	                     gmdto = new GongmoWriteDTO();
	                     gmdto.setGmboard_num(rs.getInt(1));
	                     gmdto.setGmboard_sday(rs.getString(2));
	                     gmdto.setGmboard_title(rs.getString(3));
	                     gmdto.setGmboard_poster(rs.getString(4));
	                     gmdto.setGmboard_eday(rs.getString(5));
	                     
	                     list.add(gmdto);
	                  }while(rs.next());
	               }
	            }catch(Exception e) {
	               e.printStackTrace();
	            }finally {
	               if(rs!=null) try {rs.close();}catch(Exception e) {e.printStackTrace();}
	               if(pstmt!=null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
	               if(conn!=null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
	            }
	            return list;
	         }
			// 공모 번호에 맞는 게시글 내용 가져오기
			public GongmoWriteDTO getCalendar(int num) {
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
	            GongmoWriteDTO gmdto =null;
				try {
					conn = getConnection();
					String sql="select gmboard_num, gmboard_sday, gmboard_title,gmboard_poster,gmboard_eday from gmboard where gmboard_num=?";
					pstmt=conn.prepareStatement(sql);
					pstmt.setInt(1, num);
					rs = pstmt.executeQuery();
					 if(rs.next()) {
		
		                     gmdto = new GongmoWriteDTO();
		                     gmdto.setGmboard_num(rs.getInt(1));
		                     gmdto.setGmboard_sday(rs.getString(2));
		                     gmdto.setGmboard_title(rs.getString(3));
		                     gmdto.setGmboard_poster(rs.getString(4));
		                     gmdto.setGmboard_eday(rs.getString(5));
		               }
				}catch(Exception e) {
					e.printStackTrace();
				}finally {
						if(rs!=null) try {rs.close();}catch(Exception e) {e.printStackTrace();}
					  if(pstmt!=null) try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
		               if(conn!=null) try {conn.close();}catch(Exception e) {e.printStackTrace();}
				}
				return gmdto;
			}
		
			 //댓글 갯수
			public int getCommCount(int num) {
				int result = 0;
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				
				try {
					conn = getConnection();
					
					String sql = "select count(*) from gmqna where gmqna_postnum = ?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, num);
					rs = pstmt.executeQuery();
					
					if(rs.next()) {
						result = rs.getInt(1);
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
			
			//댓글 리스트 리턴
			public List getCommArticle(int num, int start, int end) {
				List articles = null;
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				
				try {
					conn = getConnection();
					
					String sql = "select B.*, r from (select A.*, rownum r from (select * from gmqna where gmqna_postnum = ? order by gmqna_ref desc, gmqna_step asc) A order by gmqna_ref desc, gmqna_step asc) B where r >= ? and r <= ?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, num);
					pstmt.setInt(2, start);
					pstmt.setInt(3, end);
					rs = pstmt.executeQuery();
					
					if(rs.next()) {
						articles = new ArrayList(); //결과가 있으면 리스트 객체 생성해서 준비(나중에 null 확인하기 위해서)
						do { // if문에서 rs.next로 이미 커서가 내려가 버려 do while을 써서 먼저 데이터 담음
							GongmoContentQnADTO article = new GongmoContentQnADTO();
							article.setGmqna_num(rs.getInt("gmqna_num"));
							article.setGmqna_postnum(rs.getInt("gmqna_postNum"));
							article.setGmqna_id(rs.getString("gmqna_id"));
							article.setGmqna_comm(rs.getString("gmqna_comm"));
							article.setGmqna_level(rs.getInt("gmqna_level"));
							article.setGmqna_step(rs.getInt("gmqna_step"));
							article.setGmqna_ref(rs.getInt("gmqna_ref"));
							article.setGmqna_reg(rs.getTimestamp("gmqna_reg"));
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
			
			//댓글 등록
			public int insertQnAComment(GongmoContentQnADTO dto) {
				int result = 0;
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				
				int ref = dto.getGmqna_ref();
				int re_step = dto.getGmqna_step();
				int re_level = dto.getGmqna_level();
				int forRef = 0;
				
				try {
					conn = getConnection();
					
					String sql = "select max(gmqna_num) from gmqna";
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					if(rs.next()) {
						forRef = rs.getInt(1) + 1;
					}else forRef = 1;
					
					ref = forRef;
					sql = "insert into gmqna(gmqna_num,gmqna_postnum,gmqna_id,gmqna_comm,gmqna_level,gmqna_step,gmqna_ref,gmqna_reg) values(GMQNA_SEQ.nextVal,?,?,?,?,?,?,sysdate)";
					pstmt = conn.prepareStatement(sql);
					
					pstmt.setInt(1, dto.getGmqna_postnum());
					pstmt.setString(2, dto.getGmqna_id());
					pstmt.setString(3, dto.getGmqna_comm());
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
			
			//대댓글 등록
			public int insertQnaReComment(GongmoContentQnADTO dto) {
				int result = 0;
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				
				int ref = dto.getGmqna_ref();
				int re_step = dto.getGmqna_step();
				int re_level = dto.getGmqna_level();
				int forRef = 0;
				
				try {
					conn = getConnection();
					
					String sql = "select max(gmqna_num) from gmqna";
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					if(rs.next()) {
						forRef = rs.getInt(1) + 1;
					}else forRef = 1;
					
					sql = "update gmqna set gmqna_step=gmqna_step+1 where gmqna_ref=? and gmqna_step > ?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, ref);
					pstmt.setInt(2, re_step);
					pstmt.executeUpdate();
					
					//답글은 DB에 저장하기전에, 받아온 초기값 0 에서 1이 되게 더해줌
					re_step += 1;
					re_level += 1;
					
					sql = "insert into gmqna(gmqna_num,gmqna_postnum,gmqna_id,gmqna_comm,gmqna_level,gmqna_step,gmqna_ref,gmqna_reg) values(GMQNA_SEQ.nextVal,?,?,?,?,?,?,sysdate)";
					pstmt = conn.prepareStatement(sql);
					
					pstmt.setInt(1, dto.getGmqna_postnum());
					pstmt.setString(2, dto.getGmqna_id());
					pstmt.setString(3, dto.getGmqna_comm());
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
			
			// 관리자 일반 회원 있는지 없는지 체크
			public int getUsernCount() {
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				int count =0;
				try {
					conn = getConnection();
					String sql = "select count(*) from usern";
					pstmt=conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					if(rs.next()) {
						count = rs.getInt(1);
					}
				}catch(Exception e) {
					e.printStackTrace();
				}finally {
					if(rs!=null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
					if(pstmt!=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
					if(conn!=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
				}
				return count;
			}
			
			// 일반회원 conut 가 0 이상일때 회원리스트 뽑기
			public List getUsernAll(int startRow, int endRow) {
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				signupDTO sdto=null;
				List list = null;
				try {
					conn = getConnection();
					String sql ="select B.*, r from (select A.*, rownum r from (select * from usern)A order by usern_reg desc)B where r>=? and r<=?";
					pstmt=conn.prepareStatement(sql);
					pstmt.setInt(1, startRow);
					pstmt.setInt(2, endRow);
					rs = pstmt.executeQuery();
					if(rs.next()) {
						list = new ArrayList();
						do {
							sdto = new signupDTO();
							sdto.setUsern_id(rs.getString("usern_id"));
							sdto.setUsern_reg(rs.getTimestamp("usern_reg"));
							list.add(sdto);
						}while(rs.next());
					}
				}catch(Exception e) {
					e.printStackTrace();
				}finally {
					if(rs!=null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
					if(pstmt!=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
					if(conn!=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
				}
				return list;
			}
			// 관리자 기업 회원 있는지 없는지 체크
						public int getUsercCount() {
							Connection conn = null;
							PreparedStatement pstmt = null;
							ResultSet rs = null;
							int count =0;
							try {
								conn = getConnection();
								String sql = "select count(*) from userc";
								pstmt=conn.prepareStatement(sql);
								rs = pstmt.executeQuery();
								if(rs.next()) {
									count = rs.getInt(1);
								}
							}catch(Exception e) {
								e.printStackTrace();
							}finally {
								if(rs!=null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
								if(pstmt!=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
								if(conn!=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
							}
							return count;
						}
						
				// 기업회원 conut 가 0 이상일때 회원리스트 뽑기
				public List getUsercAll(int startRow, int endRow) {
					Connection conn = null;
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					signupDTO sdto=null;
					List list = null;
					try {
						conn = getConnection();
						String sql ="select B.*, r from (select A.*, rownum r from (select * from userc)A order by userc_reg desc)B where r>=? and r<=?";
						pstmt=conn.prepareStatement(sql);
						pstmt.setInt(1, startRow);
						pstmt.setInt(2, endRow);
						rs = pstmt.executeQuery();
						if(rs.next()) {
							list = new ArrayList();
							do {
								sdto = new signupDTO();
								sdto.setUserc_id(rs.getString("userc_id"));
								sdto.setUserc_reg(rs.getTimestamp("userc_reg"));
								list.add(sdto);
							}while(rs.next());
						}
					}catch(Exception e) {
						e.printStackTrace();
					}finally {
						if(rs!=null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
						if(pstmt!=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
						if(conn!=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
					}
					return list;
				}
			
			// admin이 일반 회원 추방 시킬때 userc_id 에 추가 되어야할 내용			
				public int dropUsern(String nid, String content) {
					Connection conn = null;
					PreparedStatement pstmt = null;
					int result = -1;
					try {
						conn = getConnection();
						String sql = "update usern set usern_active=1, usern_dropmsg=? where usern_id=?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setString(1, content);
						pstmt.setString(2, nid);
						result = pstmt.executeUpdate();
						
					}catch(Exception e) {
						e.printStackTrace();
					}finally {
						if(pstmt!=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
						if(conn!=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
					}
					return result;
				}
						
				public signupDTO getApplyIdPopul(String id) {
					Connection conn = null;
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					signupDTO sdto = null;
					try {
						conn = getConnection();
						String sql ="select usern_popul from usern where usern_id=?";
						pstmt=conn.prepareStatement(sql);
						pstmt.setString(1, id);
						rs = pstmt.executeQuery();
						if(rs.next()) {
							sdto = new signupDTO();
							sdto.setUsern_popul(rs.getInt(1));
						}
					}catch(Exception e) {
						e.printStackTrace();
					}finally {
						if(rs!=null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
						if(pstmt!=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
						if(conn!=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
					}
					return sdto;
				}
				
				// 관리자 권한으로 공모전 삭제
				public int admindeletegongmo(int num) {
					Connection conn = null;
					PreparedStatement pstmt = null;
					int result = -1;
					try {
						conn = getConnection();
						String sql ="delete from gmboard where gmboard_num=?";
						pstmt=conn.prepareStatement(sql);
						pstmt.setInt(1, num);
						result = pstmt.executeUpdate();
						
					}catch(Exception e) {
						e.printStackTrace();
					}finally {
						if(pstmt!=null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
						if(conn!=null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
					}
					return result;
				}
				
			
			
		} // GmBoardDAO