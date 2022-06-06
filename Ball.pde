import processing.sound.*;

public class Ball extends GameObject {
 
  private int size;
  private static final int MIN_VELX = 3, MAX_VELX = 5, MIN_VELY = 0, MAX_VELY = 10;
  private double velX = MIN_VELX, velY = MIN_VELY;
  
  private Paddle[] paddles;
  private ScoreKeeper scoreKeeper;
  
  private SoundFile[] sounds;
  
  public Ball(SoundFile[] sounds, int x, int y, int size, Paddle[] paddles, ScoreKeeper scoreKeeper){
    super(x, y);
    
    this.sounds = sounds;
    
    setX(x);
    setY(y);
    
    this.size = size;
    
    this.paddles = paddles;
    this.scoreKeeper = scoreKeeper;
    
    setVelX();
    setVelY();
    
  }
  
  public int getSize() {
    return size;
  }
  
  // TOP OF BALL
  public int getTop() {
    return y - size/2;
  }
  
  // BOTTOM OF BALL
  public int getBottom() {
    return y + (size / 2);
  }
  
  // LEFT OF BALL
  public int getLeft() {
    return x - size/2;
  }
  
  // RIGHT OF BALL
  public int getRight() {
    return x + (size / 2);
  }
  
  // INITIALIZATION VELX SET
  public void setVelX(){
    
    float dir = random(-1, 1);
    if(dir < 0)
      dir = -1;
    else
      dir = 1;
    velX = random(MIN_VELX, MAX_VELX) * dir;
    
  }
  
  public double getVelX() {
    return velX;
  }
  
  // PADDLE HIT VELX CHANGE
  public void reverseVelX() {
    velX *= -1;
    
    if(velX < 0) {
      if(abs((float)--velX) > MAX_VELX)
        velX = MAX_VELX * -1;
    } else {
      if((float)++velX > MAX_VELX)
        velX = MAX_VELX;
    }
    
    sounds[1].play();
  }
    
  // USED ON INITIALIZATION
  public void setVelY(){
    float dir = random(-1, 1);
    if(dir < 0)
      dir = -1;
    else
      dir = 1;
    velY = random(MIN_VELY, MAX_VELY) * dir;
  }
  
  // USED ON PADDLE HIT
  public void setVelY(double range){
    this.velY = (MAX_VELY * range) * -1;
  }
  
  // USED ON BOUNCES
  public void reverseVelY() {
    velY *= -1;
    sounds[2].play();
  }
  
  // RESETS INFORMATION
  private void reset() {
    setX((int)(width * .5));
    setY((int)(height * .5));
    
    setVelX();
    setVelY();
    
    for(Paddle p: paddles)
      p.reset();
      
    sounds[0].play();
  }
  
  public void update(){
    x += velX;
    y += velY;
    
    if(y - (size * .5) < 0){
      y = (int)(size * .5);
      reverseVelY();
    }
    else if(y + (size * .5) > height) {
      y = (int)(height - (size * .5));
      reverseVelY();
    }
    
    if(x < 0) {
      scoreKeeper.incrementScore(GameBoardSide.RIGHT_HAND);
      reset();
    }
    else if(x + (int)(size * .5) > width) {
      scoreKeeper.incrementScore(GameBoardSide.LEFT_HAND);
      reset();
    }
   
  }
  
  public void draw() {
    
    fill(255, 255, 255);
    square(x - (size * .5), y - (size * .5), size);
    
  }
  
}
