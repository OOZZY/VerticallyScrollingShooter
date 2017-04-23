class HitSpark {
  PVector pos; // position
  HitSparkParticle[] particles;
  int countDown = 30; // duration of spark in frames

  // initialize this spark with given position
  HitSpark(PVector pos_) {
    pos = pos_;

    // initialize 16 particles
    particles = new HitSparkParticle[16];
    for (int i = 0; i < particles.length; ++i) {
      particles[i] = new HitSparkParticle(pos.get());
    }
  }

  // update this spark
  void update() {
    countDown--;
    for (int i = 0; i < particles.length; ++i) {
      particles[i].update();
    }
  }

  // display this spark
  void display() {
    for (int i = 0; i < particles.length; ++i) {
      particles[i].display();
    }
  }
}

