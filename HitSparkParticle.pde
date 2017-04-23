class HitSparkParticle {
  PVector pos, vel; // position, velocity
  float w, h; // width, height
  color col;

  // initialize this particle with given position
  HitSparkParticle(PVector pos_) {
    pos = pos_;

    // random velocity, width, height
    vel = new PVector(random(-3, 3), random(-3, 3));
    w = random(5);
    h = random(5);

    // pick random color
    if (int(random(10)) % 2 == 0) {
      col = color(0, 127, 255); // light blue
    } else {
      col = color(255, 127, 0); // orange
    }
  }

  // update this particle
  void update() {
    pos.add(vel);
  }

  // display this particle
  void display() {
    pushMatrix();
    translate(pos.x, pos.y);
    noStroke();
    fill(col);
    ellipse(0, 0, w, h);
    popMatrix();
  }
}

