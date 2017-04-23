class Projectile {
  PVector pos, vel; // position, velocity
  float radius = 5;
  boolean active = true;

  // sets fields with given arguments
  Projectile(final PVector pos_, final PVector vel_) {
    pos = pos_;
    vel = vel_;
  }

  // returns wether this projectile is colliding with given spaceship
  boolean hitSpaceship(final Spaceship spaceship) {
    if (PVector.dist(pos, spaceship.pos) < spaceship.radius()) {
      return true;
    }
    return false;
  }

  // updates to execute when this projectile hits something
  void updateAfterHit() {
    active = false;
  }

  // returns wether this enemy is off the screen
  boolean offScreen() {
    return pos.x < 0 || pos.x > width || pos.y < 0 || pos.y > height;
  }

  // returns this projectile's radius
  float radius() { return radius; }

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
      ellipse(0, 0, radius, radius);
      popMatrix();
    }
  }
}

