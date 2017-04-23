Player player;

// stores all enemies
ArrayList<Enemy> enemies = new ArrayList<Enemy>();

// stores all bosses
ArrayList<Boss> bosses = new ArrayList<Boss>();

// stores all hitsparks
ArrayList<HitSpark> sparks = new ArrayList<HitSpark>();

// variables to keep track of HUD data
int score = 0;
int enemiesKilled = 0;
int bossesKilled = 0;
int finalElapsedTime = 0;

// points rewarded for defeating enemy/boss
final int enemyPoints = 10;
final int bossPoints = 50;

// background image
PImage bgimg;
int bgimgX = 0; // horizontal offset from center
int bgimgXLimit; // store limit of variable bgimgX

// boolean values used for keyboard input
boolean up, down, left, right, space;

// force vectors for directions up, down, left, right
final PVector fup    = new PVector(0, -1);
final PVector fdown  = new PVector(0, 1);
final PVector fleft  = new PVector(-1, 0);
final PVector fright = new PVector(1, 0);

// sets boolean values to true if corresponding key is pressed
void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP)         { up = true; }
    else if (keyCode == DOWN)  { down = true; }
    else if (keyCode == LEFT)  { left = true; }
    else if (keyCode == RIGHT) { right = true; }
  } else if (key == ' ') {
    space = true;
  }
}

// sets boolean values to false if corresponding key is released
void keyReleased() {
  if (key == CODED) {
    if (keyCode == UP)         { up = false; }
    else if (keyCode == DOWN)  { down = false; }
    else if (keyCode == LEFT)  { left = false; }
    else if (keyCode == RIGHT) { right = false; }
  }
}

// displays game over screen
void displayGameOverScreen() {
  background(0);
  textAlign(CENTER, CENTER);
  text("Game Over! Thank you for playing!", width/2, height/2);
  displayHUD(10, 20, true);
}

// displays HUD
void displayHUD(float x, float y, boolean gameOver) {
  pushMatrix();
  translate(x, y);
  // display HUD data
  textAlign(LEFT, LEFT);
  fill(0, 255, 0);
  text("Score: " + score, 0, 0);
  text("Basic enemies defeated: " + enemiesKilled, 0, 20);
  text("Bosses defeated: " + bossesKilled, 0, 40);
  if (!gameOver) {
    text("Time elapsed (s): " + millis() / 1000, 0, 60);
    text("Frame rate (fps): " + int(frameRate), 0, 80);
  } else {
    text("Time elapsed (s): " + finalElapsedTime, 0, 60);
  }
  popMatrix();
}

void setup() {
  size(600, 600);
  player = new Player(); // initialize player
  bgimg = loadImage("stars.png"); // load background image
  bgimgXLimit = (bgimg.width - width) / 2; // calculate limit of variable bgimgX
}

void draw() {
  // game over if health is <= 0
  if (player.health <= 0) {
    if (finalElapsedTime == 0) {
      finalElapsedTime = millis() / 1000; // calculate finalElapsedTime
    }
    displayGameOverScreen();
    return; // avoid executing the rest of this draw() method
  }

  // add force vectors, spawn projectiles, and move background image depending
  // on boolean values set by keypresses
  if (up) {
    player.addForce(fup);
  }
  if (down) {
    player.addForce(fdown);
  }
  if (left) {
    player.addForce(fleft);
    // update bgimgX and avoid exceeding edge of background image
    if (bgimgX < bgimgXLimit) { bgimgX++; }
  }
  if (right) {
    player.addForce(fright);
    // update bgimgX and avoid exceeding edge of background image
    if (bgimgX > -bgimgXLimit) { bgimgX--; }
  }
  if (space) {
    player.shoot();
    space = false;
  }

  // spawn enemy. spawn less enemies if bosses are present
  if (random(0, 100) < (bosses.size() == 0 ? 3 : 1)) {
    enemies.add(new Enemy());
  }

  // spawn boss enemy. spawn chance is much lower than basic enemies
  if (random(0, 100) < 0.1) {
    bosses.add(new Boss());
  }

  // make bosses shoot every 2 seconds (120 frames)
  for (int i = 0; i < bosses.size(); ++i) {
    Boss boss = bosses.get(i);
    if (boss.framesActive() % 120 == 0 && boss.active) {
      boss.shoot();
    }
  }

  // check for collisions between boss projectiles and player
  for (int i = 0; i < bosses.size(); ++i) {
    Boss boss = bosses.get(i);
    boss.checkProjectilePlayerCollisions();
  }

  // check for collisions between player projectiles and enemies/bosses
  player.checkProjectileEnemyCollisions();

  // check for collisions between player and enemies/bosses
  player.checkPlayerEnemyCollisions();

  // remove inactive enemies
  for (int i = 0; i < enemies.size(); ++i) {
    Enemy enemy = enemies.get(i);
    if (!enemy.active && enemy.countDown <= 0) {
      enemies.remove(i);
    }
  }

  // remove inactive bosses
  for (int i = 0; i < bosses.size(); ++i) {
    Boss boss = bosses.get(i);
    if (!boss.active && boss.countDown <= 0) {
      bosses.remove(i);
    }
  }

  // remove inactive boss projectiles
  for (int i = 0; i < bosses.size(); ++i) {
    Boss boss = bosses.get(i);
    for (int j = 0; j < boss.projectiles.size(); ++j) {
      Projectile projectile = boss.projectiles.get(j);
      if (!projectile.active) {
        boss.projectiles.remove(j);
      }
    }
  }

  // remove inactive player projectiles
  for (int i = 0; i < player.projectiles.size(); ++i) {
    Projectile projectile = player.projectiles.get(i);
    if (!projectile.active) {
      player.projectiles.remove(i);
    }
  }

  // remove inactive hitsparks
  for (int i = 0; i < sparks.size(); ++i) {
    HitSpark spark = sparks.get(i);
    if (spark.countDown <= 0) {
      sparks.remove(i);
    }
  }

  // display background image
  imageMode(CENTER);
  image(bgimg, width/2 + bgimgX, height/2);

  // update/display enemies
  for (int i = 0; i < enemies.size(); ++i) {
    Enemy enemy = enemies.get(i);
    enemy.update();
    enemy.display();
  }

  // update/display bosses
  for (int i = 0; i < bosses.size(); ++i) {
    Boss boss = bosses.get(i);
    boss.update();
    boss.display();
  }

  // update/display boss projectiles
  for (int i = 0; i < bosses.size(); ++i) {
    Boss boss = bosses.get(i);
    for (int j = 0; j < boss.projectiles.size(); ++j) {
      Projectile projectile = boss.projectiles.get(j);
      projectile.update();
      projectile.display();
    }
  }

  // update/display player projectiles
  for (int i = 0; i < player.projectiles.size(); ++i) {
    Projectile projectile = player.projectiles.get(i);
    projectile.update();
    projectile.display();
  }

  // update/display hitsparks
  for (int i = 0; i < sparks.size(); ++i) {
    HitSpark spark = sparks.get(i);
    spark.update();
    spark.display();
  }

  // update/display player and health
  player.update();
  player.display();
  player.displayHealth(10, height - 30);

  displayHUD(10, 20, false);
}

