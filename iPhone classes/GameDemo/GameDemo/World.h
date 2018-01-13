
//====================================================================
//
//  World.h
//  GameDemo
//
//  Created by Jason Riggs on 11/29/11.
//  Copyright (c) 2011 Stanford University. All rights reserved.
//
//====================================================================

#ifndef GameDemo_World_h
#define GameDemo_World_h

#include "Entity.h"
#include "Bullet.h"
#include <vector>

using namespace std;


//===========================================================
// Class : World
// The entire world in which all entities exist
//===========================================================

class World
{

public:

    World();
    ~World();

    void render() const;
    void update(double time_since_last_update);
    
    void addEntity(Entity * entity);
    
    Bullet * findInactiveBullet(UITouch * touch);

private:
    
    void handleCollisions(Entity * entity);
    
    double m_total_time;
    vector<Entity *> m_entities;
};


#endif
