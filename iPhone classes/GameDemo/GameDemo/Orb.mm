
//====================================================================
//
//  Orb.cpp
//  GameDemo
//
//  Created by Jason Riggs on 11/29/11.
//  Copyright (c) 2011 Stanford University. All rights reserved.
//
//====================================================================

#include <iostream>
#include "Orb.h"
#include "mo_gfx.h"
#include "Bullet.h"
#include "DrawUtils.h"

Orb::Orb(float initial_x, float initial_y)
{
    m_x = initial_x; 
    m_y = initial_y;
    m_initial_y = m_y;
    
    // set initial color : white
    m_r = 1.0;
    m_g = 1.0;
    m_b = 1.0;
    m_a = 1.0;
    
    m_radius = 0.2;
    
    m_type = ET_ORB;
    
    m_speed = 2.0;
}

Orb::~Orb()
{
    // nothing to clean up yet...
}

void Orb::render() const
{
    glColor4f(m_r, m_g, m_b, m_a);
    
    /*
     * NOTE: compiler will throw error on next line. 
     * Why? Because this method is declared const, we
     * cannot change the values of this class's member variables.
     * This is desired behavior since this method simply renders,
     * i.e. it represents the VIEW, not the MODEL (which is handled
     * by the method "update")
     */ 
     
    // m_x = 5.0;
    
    GLDrawCircle(32, m_radius, CGPointMake(m_x, m_y), true);
}

void Orb::update(double time_since_last_update)
{
    m_x = 0.7 * sin(m_speed * m_total_time);
    m_y = m_initial_y + 0.1 * sin(1.7 * m_speed * m_total_time);
    
    m_total_time += time_since_last_update;
}

bool Orb::hitTest(float x, float y)
{
    if(x < m_x - m_radius || x > m_x + m_radius) return false;
    if(y < m_y - m_radius || y > m_y + m_radius) return false;
    
    return true;
}

void Orb::handleCollisionWithEntity(Entity * entity)
{
    if(!entity || !entity->m_type == ET_BULLET || !entity->m_active) return;
    
    if(!hitTest(entity->m_x, entity->m_y)) return;
    
    // a bullet hit the orb, so handle the collision
    Bullet * bullet = (Bullet *) entity;
    
    bullet->deactivate();
    
    m_r = bullet->m_r;
    m_g = bullet->m_g;
    m_b = bullet->m_b;
    m_a = bullet->m_a;
}

void Orb::setSpeed(float speed)
{
    if(speed < 1.0) speed = 1.0;
    if(speed > 3.0) speed = 3.0;
    
    m_speed = speed;
}


