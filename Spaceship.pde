class Spaceship {
  PVector pos, vel, acc; // position, velocity, acceleration
  float w, h; // width, height
  int health; // health
  int countDown;
  boolean active = true;
  static final float DAMP = 0.9; // dampening factor

  // sets fields with given arguments
  Spaceship(PVector pos_, PVector vel_, PVector acc_, float w_, float h_,
            int health_, int countDown_) {
    pos = pos_;
    vel = vel_;
    acc = acc_;
    w = w_;
    h = h_;
    health = health_;
    countDown = countDown_;
  }

  // sets fields with given arguments
  // velocity and acceleration are set to 0
  // countDown is set to 60
  Spaceship(PVector pos_, float w_, float h_, int health_) {
    pos = pos_;
    vel = new PVector();
    acc = new PVector();
    w = w_;
    h = h_;
    health = health_;
    countDown = 60;
  }

  // returns wether this spaceship is colliding with given spaceship
  boolean hitSpaceship(final Spaceship spaceship) {
    if (PVector.dist(pos, spaceship.pos) < spaceship.radius()) {
      return true;
    }
    return false;
  }

  // updates to execute when this spaceship is hit
  void updateAfterHit() {
    decreaseHealth(10);
  }

  // decreases this spaceship's health by given amount
  void decreaseHealth(final int amount) {
    health -= amount;
  }

  // adds given force to this spaceship's acceleration vector
  void addForce(final PVector force) {
    acc.add(force);
  }

  // returns this spaceship's radius
  float radius() {
    return (w + h) / 4;
  }

  // updates this spaceship
  void update() {
    vel.add(acc);   // update velocity
    vel.mult(DAMP); // dampen velocity
    pos.add(vel);   // update position
    acc.mult(0);    // clear acceleration

    // when this spaceship leaves the edge of the screen, make it reappear on
    // the opposite side of the screen
    if (pos.x > width) { pos.x = 0; }
    if (pos.x < 0) { pos.x = width; }
    if (pos.y > height) { pos.y = 0; }
    if (pos.y < 0) { pos.y = height; }
  }

  // displays this spaceship as a black-filled ellipse
  void display() {
    pushMatrix();
    translate(pos.x, pos.y);
    fill(0);
    ellipse(0, 0, w, h);
    popMatrix();
  }
}

