class Boss extends Spaceship {
  // initializes this boss enemy
  Boss() {
    super(new PVector(random(width), 0), new PVector(0, 1), new PVector(),
          100, 100, 120, 180);
  }

  // updates to execute when this boss enemy is hit
  // overrides Spaceship's method
  void updateAfterHit() {
    if (active) {
      super.updateAfterHit();
      if (health <= 0) { active = false; }
    }
  }

  // returns wether this boss enemy is off the screen
  boolean offScreen() {
    return pos.x < 0 || pos.x > width || pos.y < 0 || pos.y > height + h/2;
  }

  // updates this boss enemy
  // overrides Spaceship's method
  void update() {
    if (active) {
      pos.add(vel);
      if (offScreen()) { active = false; }
    } else {
      --countDown;
    }
  }

  // displays this boss enemy
  // overrides Spaceship's method
  void display() {
    pushMatrix();
    translate(pos.x, pos.y);
    if (active) {
      fill(255, 0, 0);
    } else {
      fill(127);
    }
    ellipse(0, 0, w, h);
    text(health, 50, 0);
    popMatrix();
  }
}

