public abstract class GameObject {

  protected int x, y;
  
  protected GameObject(int x, int y) {
     this.x = x;
     this.y = y;
  }
  
  public void setX(int x) {
    this.x = x;
  }
  
  public void setY(int y) {
    this.y = y;
  }
  
  public int getX() {
    return x; 
  }
  
  public int getY() {
    return y; 
  }
  
  public abstract int getTop();
  
  public abstract int getBottom();
  
  public abstract int getLeft();
  
  public abstract int getRight();
  
}
