class Projectile {
  PVector pos, vel; // position, velocity
  float diameter = 8;
  boolean active = true;

  // sets fields with given arguments
  Projectile(PVector pos_, PVector vel_) {
    pos = pos_;
    vel = vel_;
  }

  // returns wether this projectile is colliding with given spaceship
  boolean hitSpaceship(Spaceship spaceship) {
    if (PVector.dist(pos, spaceship.pos) < radius() + spaceship.radius()) {
      return true;
    }
    return false;
  }

  // updates to execute when this projectile hits something
  void updateAfterHit() {
    active = false;
  }

  // returns whether this projectile is off the screen
  boolean offScreen() {
    return pos.x < 0 || pos.x > width || pos.y < 0 || pos.y > height;
  }

  // returns this projectile's radius
  float radius() { return diameter/2; }

  // updates this projectile
  void update() {
    pos.add(vel);
    if (offScreen()) { active = false; }
  }

  // displays this projectile
  void display() {
    if (active) {
      pushMatrix();
      translate(pos.x, pos.y);
      fill(255, 255, 0);
      ellipse(0, 0, diameter, diameter);
      popMatrix();
    }
  }
}

