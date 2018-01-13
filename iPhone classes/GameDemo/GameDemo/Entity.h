
//====================================================================
//
//  Entity.h
//  GameDemo
//
//  Created by Jason Riggs on 11/29/11.
//  Copyright (c) 2011 Stanford University. All rights reserved.
//
//====================================================================

#ifndef GameDemo_Entity_h
#define GameDemo_Entity_h


typedef enum et {
    ET_NONE = 0,
    ET_ORB,
    ET_BULLET
} EntityType;


//===========================================================
// Class : Entity
// Abstract base class for all entities in the world
//===========================================================

class Entity
{

public:

    // member functions
    Entity() {}
    
    // remember: setting a C++ function equal to 0 means it's 
    // purely abstract (and therefore, the entire class becomes 
    // abstract because it contains a purely abstract method)
    virtual void render() const = 0;
    virtual void update(double time_since_last_update) = 0;
    virtual void handleCollisionWithEntity(Entity * entity) = 0;
    
    // member vars
    bool m_active;
    
    float m_x, m_y; // location
    float m_r, m_g, m_b, m_a; // color
    float m_total_time; // time elapsed since creation
    
    EntityType m_type;
    
protected:

    virtual bool hitTest(float x, float y) = 0;
    
};


//===========================================================
// Class : TouchEntity
// Encapsulates a touchable entity (fingers on screen)
//===========================================================

class TouchEntity : public Entity
{

public:

    void deactivate()
    {
        m_active = false;
        m_touch_ref = NULL;
    }

    UITouch * m_touch_ref;
    
};


#endif
