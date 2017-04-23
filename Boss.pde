class Boss extends Spaceship {
  static final int fullHealth = 300;
  boolean active = true;
  int spawnFrame; // records the frame when this boss was spawned

  // # frames to stay on screen after health reaches 0 and before disappearing
  int countDown = 180;

  // stores all of boss's projectiles
  ArrayList<Projectile> projectiles;

  // initializes this boss enemy
  Boss() {
    // random initial position at the top of the screen
    // random velocity going downwards
    // 0 acceleration
    // random width and height
    super(new PVector(random(width), 0), new PVector(random(-2, 2), 3),
          new PVector(), random(140, 160), random(140, 160), fullHealth);
    spawnFrame = frameCount; // record spawnFrame
    projectiles = new ArrayList<Projectile>();
  }

  // returns the number of frames this boss has been active
  int framesActive() { return frameCount - spawnFrame; }

  // fires projectiles from boss. fires 16 projectiles in 16 different
  // directions
  void shoot() {
    int num = 16; // number of projectiles to fire
    int speed = 8; // speed of all projectiles to fire
    float inc = TWO_PI / num; // calculate amount to increment angle in the loop
    for (float a = 0; a < TWO_PI; a += inc) {
      // spawn new projectile. calculate direction with angle a
      projectiles.add(
        new Projectile(this.pos.get(), new PVector(speed*cos(a), speed*sin(a)))
      );
    }
  }

  // check for collisions between boss projectiles and player
  // update projectile/player and spawn hitsparks if they collide
  void checkProjectilePlayerCollisions() {
    for (int i = 0; i < projectiles.size(); ++i) {
      Projectile projectile = projectiles.get(i);
      if (projectile.hitSpaceship(player)) {
        projectile.updateAfterHit();
        player.updateAfterHit();
        sparks.add(new HitSpark(projectile.pos.get()));
      }
    }
  }

  // updates to execute when this boss enemy is hit
  // overrides Spaceship's method
  void updateAfterHit() {
    if (active) {
      super.updateAfterHit();
      if (health <= 0) { active = false; }
    }
  }

  // updates this boss enemy
  // overrides Spaceship's method
  void update() {
    if (active) {
      pos.add(vel);
      // make boss bounce around top half of the screen
      if (pos.x < 0 || pos.x > width) {
        vel.x *= -1;
      }
      if (pos.y < 0 || pos.y > height/2) {
        vel.y *= -1;
      }
    } else {
      countDown--;
    }
  }

  // displays this boss enemy
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

    // viewports
    fill(active ? 200 : 50);
    ellipse(-20, -10, 15, 15);
    ellipse(-18, 10, 15, 15);
    ellipse(-14, 30, 15, 15);
    ellipse(20, -10, 15, 15);
    ellipse(18, 10, 15, 15);
    ellipse(14, 30, 15, 15);

    popMatrix();
  }
}

