public class UserPaddle extends Paddle {
  
  public UserPaddle(GameBoardSide side, int w, int h) {
    super(side, w, h);
  }

  public void update(Ball ball) {
    setY(mouseY - (int)(h * .5));
  }
  
}
