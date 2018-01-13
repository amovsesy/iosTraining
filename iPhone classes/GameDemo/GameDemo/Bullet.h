
//====================================================================
//
//  Bullet.h
//  GameDemo
//
//  Created by Jason Riggs on 11/29/11.
//  Copyright (c) 2011 Stanford University. All rights reserved.
//
//====================================================================

#ifndef GameDemo_Bullet_h
#define GameDemo_Bullet_h

#include "Entity.h"


//===========================================================
// Class : Bullet
// Bullet projectile which gets shot every time the player
// taps on the screen
//===========================================================

class Bullet : public TouchEntity
{

public:
    
    Bullet();
    ~Bullet();
    
    void render() const;
    void update(double time_since_last_update);
    
    void handleCollisionWithEntity(Entity * entity) {}
    
    void randomizeColor();
    
protected:
    
    bool hitTest(float x, float y);
    
    float m_width;
    float m_height;
    float m_speed;
};



#endif
