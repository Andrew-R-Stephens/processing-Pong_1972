

public class PauseMenu {
  
  public void draw() {
    background(0);
    text("GAME PAUSED", width * .5, height * .2);
    text("SHIFT: Pause / Unpause", width * .5, height * .4);
    text("UP / DOWN: Increment / Decrement Difficulty", width * .5, height * .45);
    text("LEFT: Change Paddle Side", width * .5, height * .5);
    text("RIGHT: Toggle AI UI", width * .5, height * .55);
    text("R: Reset Game", width * .5, height * .65);
    text("A: AI Battle", width * .5, height * .7);
  }
  
}
