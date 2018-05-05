
class SpringElement
{
  //  A spring, with two ends called alpha and beta.
  //           alpha         beta
  //              O=========O 
  
  private int endParticleIdAlpha;
  private int endParticleIdBeta;
  private float springConst;
  
  SpringElement()
  {
  }
  
  SpringElement(float springConst, int alpha, int beta)
  {
    this.springConst = springConst;
    endParticleIdAlpha = alpha;
    endParticleIdBeta  = beta;
  }
  

  int getAlpha()
  {
    return endParticleIdAlpha;
  }
  
  int getBeta()
  {
    return endParticleIdBeta;
  }
  
  Vec3 getPullForce(int particleId, float[] generalCoord) 
  {
    Vec3 force = new Vec3(0.0, 0.0, 0.0);
    
    float ax = generalCoord[6*endParticleIdAlpha+0];
    float ay = generalCoord[6*endParticleIdAlpha+1];
    float az = generalCoord[6*endParticleIdAlpha+2];
    float bx = generalCoord[6*endParticleIdBeta +0];
    float by = generalCoord[6*endParticleIdBeta +1];
    float bz = generalCoord[6*endParticleIdBeta +2];
    
    float distance = dist(ax, ay, az, bx, by, bz);
    
    float pullForceAmplitude = springConst * (distance - EDGE_LENGTH);
    
    if (particleId==endParticleIdAlpha) {
      force = new Vec3((bx-ax)/distance,
                       (by-ay)/distance,
                       (bz-az)/distance);  // unit vector from alpha to beta.
      force.multiply(pullForceAmplitude);
    }
    else if (particleId==endParticleIdBeta) {
      force = new Vec3((ax-bx)/distance,
                       (ay-by)/distance,
                       (az-bz)/distance);  // unit vector from beta to alpha.
      force.multiply(pullForceAmplitude);
    }
    else {
      println("??? SpringElement/getForce");
      exit();
    }
    return force;
  }
  
  
  void draw(float[] posx,
            float[] posy,
            float[] posz) 
  {
    
    float ax = mapx(posx[endParticleIdAlpha]);
    float ay = mapx(posy[endParticleIdAlpha]);
    float az = mapx(posz[endParticleIdAlpha]);
    float bx = mapx(posx[endParticleIdBeta]);
    float by = mapx(posy[endParticleIdBeta]);
    float bz = mapx(posz[endParticleIdBeta]);

    line(ax,ay,az,bx,by,bz);
  }
  
}
