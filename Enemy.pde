class Enemy extends Spaceship {
  static final int fullHealth = 60;
  boolean active = true;

  // # frames to stay on screen after health reaches 0 and before disappearing
  int countDown = 60;

  // initializes this enemy
  Enemy() {
    // random initial position at the top of the screen
    // random velocity going downwards
    // 0 acceleration
    // random width and height
    super(new PVector(random(width), 0), new PVector(random(-1, 1), 2),
          new PVector(), random(40, 60), random(40, 60), fullHealth);
  }

  // returns whether this enemy is off the screen
  boolean offScreen() {
    return pos.x < 0 - w/2 || pos.x > width + w/2 ||
           pos.y < 0 || pos.y > height + h/2;
  }

  // updates to execute when this enemy is hit
  // overrides Spaceship's method
  void updateAfterHit() {
    if (active) {
      super.updateAfterHit();
      if (health <= 0) { active = false; }
    }
  }

  // updates this enemy
  // overrides Spaceship's method
  void update() {
    if (active) {
      pos.add(vel);
      if (offScreen()) { active = false; }
    } else {
      countDown--;
    }
  }

  // displays this enemy
  // overrides Spaceship's method
  void display() {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(PI);
    scale(w / 150, h / 200);

    // tip
    stroke(0);
    strokeWeight(2);
    line(0, 0, 0, -100);

    // thrusters
    if (active) {
      fill(255, 255, 0);
      ellipse(0, 80, 15, 40);
      ellipse(-64, 60, 12, 40);
      ellipse(64, 60, 12, 40);
    }

    // wing rect
    fill(active ? 100 : 50);
    rectMode(CENTER);
    rect(45, 50, 60, 10);
    rect(-45, 50, 60, 10);

    // wing quad
    fill(active ? 100 : 50);
    quad(-75, 55, -75, -20, -65, 30, -50, 55);
    quad(75, 55, 75, -20, 65, 30, 50, 55);

    // tail
    triangle(-25, 95, 0, 0, 25, 25);
    triangle(25, 95, 0, 0, -25, 25);

    // body
    fill(active ? 100 : 50);
    ellipse(0, -10, 75, 140);

    // center line
    line(0, -30, 0, 60);

    // front viewport
    if (active) {
      fill(255, 0, 0);
    } else {
      fill(50);
    }
    quad(-25, -40, -10, -70, 10, -70, 25, -40);

    popMatrix();
  }
}

