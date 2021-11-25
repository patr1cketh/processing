class HexagramLine {
  float start_x, start_y, end_x, end_y;
  boolean is_solid;
  
  public HexagramLine(float start_x, float start_y, float end_x, float end_y, boolean is_solid) {
    this.start_x = start_x;
    this.start_y = start_y;
    this.end_x = end_x;
    this.end_y = end_y;
    this.is_solid = is_solid;    
  }
  
  public void drawLine() {
    if (this.is_solid == true) {
      line(this.start_x, this.start_y, this.end_x, this.end_y);
    }
    else {
      line(this.start_x, this.start_y, this.end_x - 55, this.end_y);
      line(this.start_x + 55, this.start_y, this.end_x, this.end_y);
    }
  }
