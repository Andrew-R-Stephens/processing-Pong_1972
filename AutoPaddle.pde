public class AutoPaddle extends Paddle {
    
  private Difficulty difficulty = Difficulty.EASY; // THE CHOSEN AI DIFFICULTY
  
  private int maxSpeed = 1; // THE MAXIMUM AI MOVEMENT SPEED
  private double hitTarget = 0; // WHERE THE AI WILL WANT TO HIT THE BALL RELATIVE TO THE PADDLE
  
  private boolean showExtra = false;
  
  public AutoPaddle(GameBoardSide side, int w, int h, Difficulty difficulty) {
    super(side, w, h);
    setDifficulty(difficulty);
    setHitTarget();
  }
  
  // SETS THE DIFFICULTY OF THE AI
  public void setDifficulty(Difficulty difficulty) {
    this.difficulty = difficulty;
    maxSpeed = difficulty.getMaxSpeed();
  }
  
  // WHERE THE AI WILL WANT TO HIT THE BALL RELATIVE TO THE PADDLE
  public void setHitTarget(){
    double errorMargin = 0;
    if(random(-1, 10) < 0)
      errorMargin = difficulty.getErrorMargin();
    hitTarget = random((int)(100 * errorMargin) * -1, (int)((100 * .01) + (100 * errorMargin)));
  }
  
  public void onHit(Ball ball) {
    super.onHit(ball);
    setHitTarget();
  }
  
  
  
  public void update(Ball ball) {
    if((gameBoardSide == GameBoardSide.LEFT_HAND && ball.getVelX() > 0) || (gameBoardSide == GameBoardSide.RIGHT_HAND && ball.getVelX() < 0))
      return;
        
    double hitPaddleLoc = y + (int)(hitTarget * h);
    
    int dY = (int)(hitPaddleLoc - ball.getY());
    
    int move = min(abs(dY), maxSpeed);
    if(hitPaddleLoc >= ball.getY())
      move *= -1;
    
    setY(y + move);
  }
  
  // RESETS PADDLE
  public void reset() {
    super.reset();
    
    setHitTarget();
  }
 
  // TOGGLES AI UI
  public void toggleExtra() {
    showExtra = !showExtra;
  }
 
  public void draw() {
    super.draw();
    
    noStroke();
    fill(255, 0, 0);
    
    if(showExtra) {
      if(gameBoardSide == GameBoardSide.LEFT_HAND)
        circle(x + w, (int)(y + (hitTarget * h)), ball.getSize()/2);
      else
        circle(x, (int)(y + (hitTarget * h)), ball.getSize()/2);
    }
  }
}

// DIFFICULTY LEVELS
public enum Difficulty {
  EASY(0), MEDIUM(1), HARD(2), VETERAN(3), IMPOSSIBLE(4);
  
  private int difficulty;
  
  private Difficulty(int difficulty){
    this.difficulty = difficulty;
  }
  
  // DETERMINES THE MAX AI SPEED
  public int getMaxSpeed(){
    
    switch(difficulty) {
      case 0: return 3;
      case 1: return 4;
      case 2: return 6;
      case 3: return 8;
      default: return Ball.MAX_VELY*2;
    }
  }
  
  // DETERMINES THE POTENTIAL FOR A MISSED HIT
  public double getErrorMargin() {
    
    switch(difficulty) {
      case 0: return .012;
      case 1: return .0101;
      case 2: return .0051;
      case 3: return .0051;
      default: return 0;
    }
  }
  
}
