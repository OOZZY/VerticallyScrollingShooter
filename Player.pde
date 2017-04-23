class Player extends Spaceship {
  // stores all of player's projectiles
  ArrayList<Projectile> projectiles;

  // force vectors for player's projectiles
  final PVector fprojectile1 = new PVector(0, -16);
  final PVector fprojectile2 = new PVector(-0.5, -16);
  final PVector fprojectile3 = new PVector(0.5, -16);

  // initializes this player
  Player() {
    super(new PVector(width / 2, height), 20, 20, 100);
    projectiles = new ArrayList<Projectile>();
  }

  // fires three projectiles from player
  void shoot() {
    projectiles.add(new Projectile(player.pos.get(), fprojectile1));
    projectiles.add(new Projectile(player.pos.get(), fprojectile2));
    projectiles.add(new Projectile(player.pos.get(), fprojectile3));
  }

  // displays this player
  void display() {
    pushMatrix();
    translate(pos.x, pos.y);
    pushMatrix();
    scale(w / 150, h / 200);

    // tip
    stroke(0);
    strokeWeight(2);
    line(0, 0, 0, -100);

    // thrusters
    fill(255, 255, 0);
    ellipse(0, 80, 15, 40);
    ellipse(-64, 60, 12, 40);
    ellipse(64, 60, 12, 40);

    // wing rect
    fill(150, 150, 255);
    rectMode(CENTER);
    rect(45, 50, 60, 10);
    rect(-45, 50, 60, 10);

    // wing quad
    fill(255, 200, 200);
    quad(-75, 55, -75, -20, -65, 30, -50, 55);
    quad(75, 55, 75, -20, 65, 30, 50, 55);

    // tail
    triangle(-25, 95, 0, 0, 25, 25);
    triangle(25, 95, 0, 0, -25, 25);

    // body
    fill(200, 200, 255);
    ellipse(0, -10, 75, 140);

    // center line
    line(0, -30, 0, 60);

    // front viewport
    fill(100);
    quad(-25, -40, -10, -70, 10, -70, 25, -40);

    // viewports
    fill(200);
    ellipse(-20, -10, 15, 15);
    ellipse(-18, 10, 15, 15);
    ellipse(-14, 30, 15, 15);
    ellipse(20, -10, 15, 15);
    ellipse(18, 10, 15, 15);
    ellipse(14, 30, 15, 15);

    popMatrix();
    fill(0, 0, 255);
    text(health, 10, 0);
    popMatrix();
  }
}

