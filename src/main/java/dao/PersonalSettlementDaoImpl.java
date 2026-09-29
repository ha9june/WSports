package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import config.MybatisSqlSessionFactory;
import dto.PersonalSettlement;

public class PersonalSettlementDaoImpl implements PersonalSettlementDao {
	@Override
	public List<PersonalSettlement> selectPersonalSettlementMatchList() throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.personalsettlement.selectPersonalSettlementMatchList");
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}


//	@Override
//	public PersonalSettlement selectPersonalsettlementcount(String amount, String personalSettlement,
//			String personalMatch, String personalMatchId, String matchDate, String settlementStatus) throws Exception {
//		// TODO Auto-generated method stub
//		return null;
//	}

	

}
