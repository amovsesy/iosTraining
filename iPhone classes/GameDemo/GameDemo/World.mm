
//====================================================================
//
//  World.cpp
//  GameDemo
//
//  Created by Jason Riggs on 11/29/11.
//  Copyright (c) 2011 Stanford University. All rights reserved.
//
//====================================================================

#include <iostream>
#include "World.h"
#include "mo_gfx.h"

static const unsigned int MAX_BULLETS = 5; // up to 5 on iPhone, 11 on iPad


World::World()
{
    // world always has fixed number of bullet objects
    for(int i = 0; i < MAX_BULLETS; i++)
    {
        Bullet * bullet = new Bullet();
        m_entities.push_back(bullet);
    }
}

World::~World()
{
    for(int i = 0; i < m_entities.size(); i++)
    {
        Entity * curr = m_entities.at(i);
        if(curr) delete curr;
    }
}

void World::render() const
{
    for(int i = 0; i < m_entities.size(); i++)
    {
        Entity * curr = m_entities.at(i);
        if(curr) curr->render();
    }
}

void World::update(double time_since_last_update)
{
    for(int i = 0; i < m_entities.size(); i++)
    {
        Entity * curr = m_entities.at(i);
        
        if(!curr) continue;
        
        handleCollisions(curr);
        curr->update(time_since_last_update);
    }
}

void World::addEntity(Entity * entity)
{
    m_entities.push_back(entity);
}

Bullet * World::findInactiveBullet(UITouch * touch)
{
    for(int i = 0; i < m_entities.size(); i++)
    {
        Entity * curr = m_entities.at(i);
        
        if(!curr) continue;
        
        if(curr->m_type == ET_BULLET)
        {
            Bullet * bullet = (Bullet *) curr;
            
            if(bullet->m_touch_ref == touch) break;
            if(!bullet->m_active) return bullet;
        }
    }
    
    return NULL;
}


// private methods

void World::handleCollisions(Entity * entity)
{
    for(int i = 0; i < m_entities.size(); i++)
    {
        Entity * curr = m_entities.at(i);
        
        if(!curr) continue;
        
        if(curr == entity) continue; // don't collide with self
        
        curr->handleCollisionWithEntity(entity);
    }
}


