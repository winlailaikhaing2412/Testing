package Model;

public class AverageResult {
    private String quizTitle;
    private double avgScore;
    private int totalAttempts;
    private String quizCategory;
    private String quizLevel;
    private int testNum;

    public String getQuizTitle() { return quizTitle; }
    public void setQuizTitle(String quizTitle) { this.quizTitle = quizTitle; }

    public double getAvgScore() { return avgScore; }
    public void setAvgScore(double avgScore) { this.avgScore = avgScore; }

    public int getTotalAttempts() { return totalAttempts; }
    public void setTotalAttempts(int totalAttempts) { this.totalAttempts = totalAttempts; }
    
    public String getQuizCategory() { return quizCategory; }
    public void setQuizCategory(String quizCategory) { this.quizCategory = quizCategory; }
    
    public String getQuizLevel() { return quizLevel; }
    public void setQuiLevel(String quizLevel) { this.quizLevel = quizLevel; }
    
    public int getTestNum() { return testNum; }
    public void setTestNum(int testNum) { this.testNum = testNum; }
    
}
