package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import config.MybatisSqlSessionFactory;
import dto.Notification;

public class NotificationDaoImpl implements NotificationDao {

	@Override
	public Long insertNotification(Notification notification) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			sqlSession.insert("mapper.notification.insertNotification", notification);
			sqlSession.commit();
			return notification.getNotificationId();
		} catch (Exception e) {
			e.printStackTrace();
			sqlSession.rollback();
			throw e;
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public void updateNotificationIdRead(Long notificationId) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			sqlSession.insert("mapper.notification.updateNotificationIdRead", notificationId);
			sqlSession.commit();

		} catch (Exception e) {
			e.printStackTrace();
			sqlSession.rollback();
			throw e;
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public Notification selectNotification(Long notificationId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.notification.selectNotification", notificationId);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Notification> selectNotificationListNotConfirm3(Long userId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.notification.selectNotificationListNotConfirm3", userId);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Notification> selectNotificationList(Long userId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.notification.selectNotificationList", userId);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public int selectNotificationListNotConfirmCnt(Long userId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.notification.selectNotificationListNotConfirmCnt", userId);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Map<String, Object>> selectMypageNotificationList(Long userId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.notification.selectMypageNotificationList", userId);
		}
	}

	@Override
	public int selectMypageAlarmUnreadCount(Long userId) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			int cnt = sqlSession.update("mapper.notification.selectMypageAlarmUnreadCount", userId);
			sqlSession.commit();
			return cnt;
		} catch (Exception e) {
			sqlSession.rollback();
			throw e;
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public int updateMypageNotificationRead(Map<String, Object> param) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			int cnt = sqlSession.update("mapper.notification.updateMypageNotificationRead", param);
			sqlSession.commit();
			return cnt;
		} catch (Exception e) {
			sqlSession.rollback();
			throw e;
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public int updateMypageAllNotificationRead(Long userId) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			int cnt = sqlSession.update("mapper.notification.updateMypageAllNotificationRead", userId);
			sqlSession.commit();
			return cnt;
		} catch (Exception e) {
			sqlSession.rollback();
			throw e;
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public int updateRead(Map<String, Object> param) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			int cnt = sqlSession.update("mapper.notification.updateRead", param);
			sqlSession.commit();
			return cnt;
		} catch (Exception e) {
			sqlSession.rollback();
			e.printStackTrace();
			throw e;
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public String selectLink(Map<String, Object> param) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.notification.selectLink", param);
		}
	}

	@Override
	public int updateAllRead(Long userId) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			int cnt = sqlSession.update("mapper.notification.updateAllRead", userId);
			sqlSession.commit();
			return cnt;
		} catch (Exception e) {
			sqlSession.rollback();
			e.printStackTrace();
			throw e;
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public List<Map<String, Object>> selectMyNotificationList(Long userId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.notification.selectMyNotificationList", userId);
		}
	}
}
