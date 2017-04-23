class Player extends Spaceship {
  static final int fullHealth = 200;

  // stores all of player's projectiles
  ArrayList<Projectile> projectiles;

  // force vectors for player's projectiles
  final PVector fprojectile1 = new PVector(0, -16);
  final PVector fprojectile2 = new PVector(-0.5, -16);
  final PVector fprojectile3 = new PVector(0.5, -16);

  // initializes this player
  Player() {
    // initial position at bottom center of screen
    super(new PVector(width / 2, height), 50, 50, fullHealth);
    projectiles = new ArrayList<Projectile>();
  }

  // fires three projectiles from player
  void shoot() {
    projectiles.add(new Projectile(this.pos.get(), fprojectile1));
    projectiles.add(new Projectile(this.pos.get(), fprojectile2));
    projectiles.add(new Projectile(this.pos.get(), fprojectile3));
  }

  // check for collisions between player projectiles and enemies/bosses
  // update projectile/enemy/bosses and spawn hitsparks if they collide
  // update score if enemies/bosses turn inactive
  void checkProjectileEnemyCollisions() {
    // basic enemies
    for (int i = 0; i < projectiles.size(); ++i) {
      for (int j = 0; j < enemies.size(); ++j) {
        Projectile projectile = projectiles.get(i);
        Enemy enemy = enemies.get(j);
        if (projectile.hitSpaceship(enemy) && enemy.active) {
          projectile.updateAfterHit();
          enemy.updateAfterHit();
          if (!enemy.active) {
            score += enemyPoints;
            enemiesKilled++;
          }
          sparks.add(new HitSpark(projectile.pos.get()));
        }
      }
    }

    // bosses
    for (int i = 0; i < projectiles.size(); ++i) {
      for (int j = 0; j < bosses.size(); ++j) {
        Projectile projectile = projectiles.get(i);
        Boss boss = bosses.get(j);
        if (projectile.hitSpaceship(boss) && boss.active) {
          projectile.updateAfterHit();
          boss.updateAfterHit();
          if (!boss.active) {
            score += bossPoints;
            bossesKilled++;
          }
          sparks.add(new HitSpark(projectile.pos.get()));
        }
      }
    }
  }

  // check for collisions between player and enemies/bosses
  // update player/enemy/bosses and spawn hitsparks if they collide
  // update score if enemies/bosses turn inactive
  void checkPlayerEnemyCollisions() {
    // basic enemies
    for (int i = 0; i < enemies.size(); ++i) {
      Enemy enemy = enemies.get(i);
      if (hitSpaceship(enemy) && enemy.active) {
        updateAfterHit();
        enemy.updateAfterHit();
        if (!enemy.active) {
          score += enemyPoints;
          enemiesKilled++;
        }
        sparks.add(new HitSpark(pos.get()));
      }
    }

    // bosses
    for (int i = 0; i < bosses.size(); ++i) {
      Boss boss = bosses.get(i);
      if (hitSpaceship(boss) && boss.active) {
        updateAfterHit();
        boss.updateAfterHit();
        if (!boss.active) {
          score += bossPoints;
          bossesKilled++;
        }
        sparks.add(new HitSpark(pos.get()));
      }
    }
  }

  // displays this player's health at given position. given position will be
  // upper-left corner of the health bar
  void displayHealth(float x, float y) {
    pushMatrix();
    translate(x, y);
    rectMode(CORNER);
    fill(255, 0, 0);
    rect(0, 0, fullHealth, 20);
    fill(0, 255, 0);
    rect(0, 0, health, 20);
    popMatrix();
  }

  // displays this player
  void display() {
    pushMatrix();
    translate(pos.x, pos.y);
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

    popMatrix();
  }
}

