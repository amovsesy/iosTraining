
//====================================================================
//
//  Bullet.cpp
//  GameDemo
//
//  Created by Jason Riggs on 11/29/11.
//  Copyright (c) 2011 Stanford University. All rights reserved.
//
//====================================================================

#include <iostream>

#include "Bullet.h"
#include "mo_gfx.h"

Bullet::Bullet()
{
    m_type = ET_BULLET;
    
    m_active = false;
    m_touch_ref = NULL;
    
    m_width = 0.08;
    m_height = 0.12;
    m_speed = 150.0;
    
    randomizeColor();
}

Bullet::~Bullet()
{
    // clean up...
}

void Bullet::render() const
{
    if(!m_active) return;
    
    glColor4f(m_r, m_g, m_b, m_a);
    
    float hw = 0.5 * m_width;
    float hh = 0.5 * m_height;
    
    const GLfloat vertices[] = { 
        m_x - hw, m_y - hh, 0.0f,
        m_x + hw, m_y - hh, 0.0f,            
        m_x     , m_y + hh, 0.0f
    }; 
    
    glEnableClientState(GL_VERTEX_ARRAY);
    glVertexPointer(3, GL_FLOAT, 0, vertices);
    glDrawArrays(GL_TRIANGLES, 0, 3);
}

void Bullet::update(double time_since_last_update)
{
    if(!m_active) return;
    
    m_y += 0.02 * m_speed * time_since_last_update;
    
    // when bullet leaves top of screen
    if(m_y > 1.1) deactivate();
    
    m_total_time += time_since_last_update;
}
    
bool Bullet::hitTest(float x, float y)
{
    // if we wanted to test things colliding with bullets
    // we would implement this method.
    // but we don't need anything for this app, so we
    // just return false
    return false;
}

void Bullet::randomizeColor()
{
    m_r = 0.4 + 0.5 * (double)rand()/RAND_MAX;
    m_g = 0.4 + 0.5 * (double)rand()/RAND_MAX;
    m_b = 0.4 + 0.5 * (double)rand()/RAND_MAX;
    m_a = 1.0;
}




