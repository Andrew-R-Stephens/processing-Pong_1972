public class GameBoard {
  
  private ScoreKeeper scoreKeeper;
  private Difficulty difficulty; 
    
  public GameBoard(Difficulty difficulty, ScoreKeeper scoreKeeper) {
    this.scoreKeeper = scoreKeeper;
    setDifficulty(difficulty);
  }
    
  public void setDifficulty(Difficulty difficulty) {
    this.difficulty = difficulty;
  }
    
  void draw(){
    
    background(0,0,0);
    
    int lineWeight = 10;
    strokeWeight(lineWeight);
    stroke(50, 50, 50);
    line(width * .5, 0, width * .5, height);
    
    stroke(0, 0, 0);
    int numDashes = height/lineWeight/2;
    for(int i = 0; i < numDashes; i++)
      line((width * .5) - lineWeight, i*lineWeight*2, (width * .5) + lineWeight, i * lineWeight*2);
    noStroke();
    strokeWeight(1);
    
    text("PLAYER 1: " + scoreKeeper.getScore(GameBoardSide.LEFT_HAND), width * .2, height * .1);
    text("PLAYER 2: " + scoreKeeper.getScore(GameBoardSide.RIGHT_HAND), width * .8, height * .1);
    
    text("DIFFICULTY " + difficulty.name(), width * .5, height * .1);
    
    text("SHIFT TO PAUSE", width * .5, height * .04);
    
  }
  
}
