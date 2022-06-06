
private Difficulty difficulty = Difficulty.EASY;
private boolean flipBoard = false;
private boolean isAIBattle = false;

private PauseMenu pauseMenu;

private GameBoard board;
private ScoreKeeper scoreKeeper;

private Ball ball;
private Paddle[] paddles;

private SoundFile[] sounds;

private boolean isPaused = false;

void setup() {
  
  // SET THE WINDOW SIZE
  size(960, 540);
  
  pauseMenu = new PauseMenu();
  
  // PONG SOUNDS
  sounds = new SoundFile[] {
    new SoundFile(this, "pong_reset.mp3"),
    new SoundFile(this, "pong_hit.mp3"),
    new SoundFile(this, "pong_bounce.mp3")
  };
  
  build();
  
}

// BUILD PONG
void build() {
  paddles = new Paddle[2];
  if(!flipBoard) { // THE UNFLIPPED PADDLE POSITIONS
    paddles[0] = new AutoPaddle(GameBoardSide.LEFT_HAND, 15, 65, difficulty);
    paddles[1] = new UserPaddle(GameBoardSide.RIGHT_HAND, 15, 65);
    if(isAIBattle)
      paddles[1] = new AutoPaddle(GameBoardSide.RIGHT_HAND, 15, 65, difficulty);
  } else { // THE FLIPPED PADDLE POSITIONS
    paddles[0] = new AutoPaddle(GameBoardSide.RIGHT_HAND, 15, 65, difficulty);
    paddles[1] = new UserPaddle(GameBoardSide.LEFT_HAND, 15, 65);
    if(isAIBattle)
      paddles[1] = new AutoPaddle(GameBoardSide.LEFT_HAND, 15, 65, difficulty);
  }
 
  scoreKeeper = new ScoreKeeper(paddles);
  scoreKeeper.setFlipped(flipBoard);
  board = new GameBoard(difficulty, scoreKeeper);
  
  ball = new Ball(sounds, (int)(width * .5), (int)(height * .5), 12, paddles, scoreKeeper);
}

void update() {
    
  ball.update();
  for(Paddle p: paddles) {
    p.update(ball);
  }
  
  // ALLOWS CORRECT PADDLE TO TEST FOR INTERSECTION BASED ON BALL X DIRECTION
  // BALL MOVING LEFT
  if(ball.getVelX() <= 0) {
    for(Paddle p: paddles) {
      if(p.getGameBoardSide() == GameBoardSide.LEFT_HAND)
        if(p instanceof AutoPaddle) {
          AutoPaddle ap = (AutoPaddle)p;
          ap.intersects(ball);
        } else
        if(p instanceof UserPaddle) {
          UserPaddle up = (UserPaddle)p;
          up.intersects(ball);
        }
    }
  }
  // BALL MOVING RIGHT
  else {
    for(Paddle p: paddles) {
      if(p.getGameBoardSide() == GameBoardSide.RIGHT_HAND)
        if(p instanceof AutoPaddle) {
          AutoPaddle ap = (AutoPaddle)p;
          ap.intersects(ball);
        } else
        if(p instanceof UserPaddle) {
          UserPaddle up = (UserPaddle)p;
          up.intersects(ball);
        }
    }
  }
  
}

void keyPressed(){
  
  if (key == CODED) {
    
    // INCREMENT DIFFICULTY SELECTION
    if (keyCode == UP) {
      int index = 0;
      for(int i = 0; i < Difficulty.values().length; i++)
        if(difficulty == Difficulty.values()[i])
          index = i;
      if(++index >= Difficulty.values().length)
        index = 0;
      difficulty = Difficulty.values()[index];
      board.setDifficulty(difficulty);
      for(Paddle p: paddles)
        if(p instanceof AutoPaddle) {
          ((AutoPaddle)p).setDifficulty(difficulty);
        }
    } 
    // DECREMENT DIFFICULTY SELECTION
    else if (keyCode == DOWN) {
      int index = 0;
      for(int i = 0; i < Difficulty.values().length; i++)
        if(difficulty == Difficulty.values()[i])
          index = i;
      if(--index < 0)
        index = Difficulty.values().length - 1;
      difficulty = Difficulty.values()[index];
      board.setDifficulty(difficulty);
      for(Paddle p: paddles)
        if(p instanceof AutoPaddle) {
          ((AutoPaddle)p).setDifficulty(difficulty);
        }
    } 
    // FLIP USER PADDLE SIDE
    // NOTE: SCORE DOES NOT PROPERLY REPRESENT THE PADDLE SIDE
    else if (keyCode == LEFT) {
      flipBoard = !flipBoard;
      build();
    } 
    // TOGGLE AI UI
    else if (keyCode == RIGHT) {
    for(Paddle p: paddles)
      if(p instanceof AutoPaddle) {
        ((AutoPaddle)p).toggleExtra();
      }
    }
    // PAUSE MENU
    else if (keyCode == SHIFT) {
      isPaused = !isPaused;
    }
  } 
  // RESET GAME
  else if (key == 'r') {
    build();
  }
  // SWITCH TO AI GAME
  else if (key == 'a') {
    isAIBattle = !isAIBattle;
    build();
  }
}

void draw() {
  
  textAlign(CENTER, CENTER);
  PFont font = loadFont("Unispace-Bold-20.vlw");
  textFont(font);
  
  // SHOW PAUSE MENU AND PAUSE GAME
  if(isPaused) {
    pauseMenu.draw();
    return;
  }
  
  // UPDATE ELEMENTS
  update();
 
  // DRAW ELEMENTS
  board.draw();
  for(Paddle p: paddles)
    p.draw();
  ball.draw();
  
}
