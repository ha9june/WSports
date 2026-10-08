package config;

import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import scheduler.MatchScheduler;
import javax.servlet.annotation.WebListener;

@WebListener
public class MatchSchedulerListener implements ServletContextListener {
	private ScheduledExecutorService ses;

	@Override
	public void contextInitialized(ServletContextEvent e) {
		ses = Executors.newSingleThreadScheduledExecutor(r -> {
			Thread t = new Thread(r, "match-scheduler");
			t.setDaemon(true);                       // 서버 종료를 막지 않게
			return t;
		});
		MatchScheduler job = new MatchScheduler();
		ses.scheduleWithFixedDelay(job::run, 0, 60, TimeUnit.SECONDS);   // 시작하자마자 1회, 이후 이전 실행이 끝나고 60초 뒤
		System.out.println("[스케줄러] 시작");
	}

	@Override
	public void contextDestroyed(ServletContextEvent e) {
		if (ses != null) ses.shutdownNow();          // 재배포 때 스케줄러가 겹쳐 도는 걸 막음
		System.out.println("[스케줄러] 종료");
	}
}
