public class ScoreKeeper {
  
  private Paddle[] paddles;
  private int scoreP1, scoreP2;
  
  private boolean isFlipped = false;
  
  public ScoreKeeper(Paddle[] paddles){
    this.paddles = paddles;
  }
  
  public void setFlipped(boolean isFlipped){
    this.isFlipped = isFlipped;
    
    int temp = scoreP1;
    scoreP1 = scoreP2;
    scoreP2 = temp;
    
  }
  
  public void incrementScore(GameBoardSide gameBoardSide){
    System.out.println("Incrementing Score " + gameBoardSide + " , isFlipped = " + isFlipped);
    
    if(isFlipped)
      if(gameBoardSide == GameBoardSide.LEFT_HAND)
        gameBoardSide = GameBoardSide.RIGHT_HAND;
      else
        gameBoardSide = GameBoardSide.LEFT_HAND;
    
    for(Paddle p: paddles)
      if(p.getGameBoardSide() == gameBoardSide) {
        if(gameBoardSide == GameBoardSide.LEFT_HAND) {
          scoreP1++;
          return;
        }
        else {
          scoreP2++;
          return;
        }
      }
  }
  
  public int getScore(GameBoardSide gameBoardSide){
    
    if(isFlipped)
      if(gameBoardSide == GameBoardSide.LEFT_HAND)
        gameBoardSide = GameBoardSide.RIGHT_HAND;
      else
        gameBoardSide = GameBoardSide.LEFT_HAND;
    
    for(Paddle p: paddles)
      if(p.getGameBoardSide() == gameBoardSide)
        return scoreP1;
      else
        return scoreP2;
    return 0;
  }
  
}
