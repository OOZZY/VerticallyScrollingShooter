Player player;

// stores all enemies
ArrayList<Spaceship> enemies = new ArrayList<Spaceship>();

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

void setup() {
  size(600, 600);
  background(0);
  player = new Player(); // initialize player
}

void draw() {
  background(0);

  // add force vectors and spawn projectiles depending on boolean values set by
  // keypresses
  if (up)    { player.addForce(fup); }
  if (down)  { player.addForce(fdown); }
  if (left)  { player.addForce(fleft); }
  if (right) { player.addForce(fright); }
  if (space) {
    player.shoot();
    space = false;
  }

  // spawn enemy
  if (random(0, 100) < 3) {
    enemies.add(new Enemy());
  }

  // spawn boss enemy
  if (random(0, 100) < 0.1) {
    enemies.add(new Boss());
  }

  // check for collisions between player projectiles and enemies
  for (int i = 0; i < player.projectiles.size(); ++i) {
    for (int j = 0; j < enemies.size(); ++j) {
      if (player.projectiles.get(i).hitSpaceship(enemies.get(j)) &&
          enemies.get(j).active) {
        player.projectiles.get(i).updateAfterHit();
        enemies.get(j).updateAfterHit();
      }
    }
  }

  // check for collisions between player and enemies
  for (int i = 0; i < enemies.size(); ++i) {
    if (player.hitSpaceship(enemies.get(i)) && enemies.get(i).active) {
      player.updateAfterHit();
      enemies.get(i).updateAfterHit();
    }
  }

  // remove inactive enemies
  for (int i = 0; i < enemies.size(); ++i) {
    if (!enemies.get(i).active && enemies.get(i).countDown <= 0) {
      enemies.remove(i);
    }
  }

  // remove inactive player projectiles
  for (int i = 0; i < player.projectiles.size(); ++i) {
    if (!player.projectiles.get(i).active) {
      player.projectiles.remove(i);
    }
  }

  // update/display enemies
  for (int i = 0; i < enemies.size(); ++i) {
    enemies.get(i).update();
    enemies.get(i).display();
  }

  // update/display player projectiles
  for (int i = 0; i < player.projectiles.size(); ++i) {
    player.projectiles.get(i).update();
    player.projectiles.get(i).display();
  }

  // update/display player
  player.update();
  player.display();

  // display number or enemies and projectiles on screen
  text("enemies.size(): " + enemies.size(), 10, 20);
  text("player.projectiles.size(): " + player.projectiles.size(), 10, 40);
}

