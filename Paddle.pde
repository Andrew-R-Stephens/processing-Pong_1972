public abstract class Paddle extends GameObject{
    
  protected GameBoardSide gameBoardSide;
  protected int w, h;
  
  protected final double contactMargins = .5;
      
  public Paddle(GameBoardSide gameBoardSide, int w, int h) {
    super((int)gameBoardSide.getLocation(width, gameBoardSide, w), (int)(height * .5));
    
    this.gameBoardSide = gameBoardSide;
    setW(w);
    setH(h);
  }
  
  public void setY(int y) {
    this.y = y;
    if(this.y < 0)
      this.y = 0;
    else 
      if(getBottom() > height)
        this.y = height - h;
  }
  
  private void setW(int w) {
    this.w = w;
  }
  
  private void setH(int h) {
    this.h = h;
  }
  
  public int getTop() {
    return y;
  }
  
  public int getBottom() {
    return y + h;
  }
  
  public int getLeft() {
    return x;
  }
  
  public int getRight() {
    return x + w;
  }
  
  public void setGameBoardSide(GameBoardSide gameBoardSide) {
    this.gameBoardSide = gameBoardSide;
  }
  
  public GameBoardSide getGameBoardSide() {
    return gameBoardSide;
  }
  
  public double getTrajectory(Ball ball) {
    double hitLoc = (y + h) - (ball.getY());
    double middlePaddle = h * .5;
    
    return (hitLoc - middlePaddle) / middlePaddle;
  }
  
  public void onHit(Ball ball) {
    ball.reverseVelX();
    ball.setVelY(getTrajectory(ball));
  }
  
  public void intersects(Ball ball) {
    if(((ball.getTop() <= y + h)) && (ball.getBottom() >= y)) {
      if(gameBoardSide == GameBoardSide.LEFT_HAND) {
        if(ball.getLeft() <= x + w && ball.getLeft() >= x + (w * contactMargins)) {
          ball.setX(x + w + (int)(ball.getSize() * .5));
          onHit(ball);
        }
      }
      else if(gameBoardSide == GameBoardSide.RIGHT_HAND) {
        if(ball.getRight() >= x  && ball.getRight() <= x + (w * contactMargins)) {
          ball.setX(x - ball.getSize()/2);
          onHit(ball);
        }
      }
    }
  }
  
  public abstract void update(Ball ball);
     
  public void reset() {
    y = (int)(height * .5);
  }
     
  public void draw(){
    noStroke();
    fill(255,255,255);
    rect(x, y, w, h);
  }
  
}

// Determines the x location based on which side the paddle is set to
// Also assists in determining the face that the ball should hit
private enum GameBoardSide {
  LEFT_HAND(.05), RIGHT_HAND(.95);
  
  private double x = 0;

  private GameBoardSide(float x){
    this.x = x;
  }
  
  public double getLocation(int screenW, GameBoardSide side, int paddleWidth) {
    
    if(side == LEFT_HAND)
      return (x * screenW);
    else
      return (x * screenW) - paddleWidth;
      
  }
}
