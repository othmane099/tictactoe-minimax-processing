class Drop {

  float x = random(width);
  float y = random(-200, -100);
  float yspeed = random(1, 3);
  float s = random(2);
  
  float xr = 10;


  void fall()
  {
    y+=yspeed;

    if (y>height)
      y=random(-200, -100);
  }

  void show() {
    stroke(251, 197, 49);
    strokeWeight(2);

    if (floor(s)==1) {
      noFill();
      ellipse(x, y, 20, 20);
    } else {
      line(x - xr, y - xr, x + xr, y + xr);
      line(x + xr, y - xr, x - xr, y + xr);
    }
  }
}
