
//====================================================================
//
//  Orb.h
//  GameDemo
//
//  Created by Jason Riggs on 11/29/11.
//  Copyright (c) 2011 Stanford University. All rights reserved.
//
//====================================================================

#ifndef GameDemo_Orb_h
#define GameDemo_Orb_h

#include "Entity.h"


//===========================================================
// Class : Orb
// Orb object which moves around to avoid getting hit
//===========================================================

class Orb : public Entity
{

public:
    
    Orb(float initial_x, float initial_y);
    ~Orb();
    
    void render() const;
    void update(double time_since_last_update);
    
    void handleCollisionWithEntity(Entity * entity);
    
    void setSpeed(float speed);
    
protected:
    
    bool hitTest(float x, float y);
    
    float m_radius;
    float m_speed;
    float m_initial_y;
};


#endif
