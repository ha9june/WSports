package scheduler;

public class MatchScheduler {
    private TeamMatchJob job = new TeamMatchJob();
    private PersonalMatchJob personaljob = new PersonalMatchJob();
    private PersonalMatchJob pmJob = new PersonalMatchJob();
    
    public void run() {
        System.out.println("[스케줄러] 실행 " + java.time.LocalDateTime.now());
        try {
            job.run();
            pmJob.run();
        } catch (Throwable t) { // 스케줄러 스레드가 죽지 않도록
            t.printStackTrace();
        }
        try {                                                      
        	personaljob.run();
        } catch (Throwable t) {
            t.printStackTrace();
        }
    }
}