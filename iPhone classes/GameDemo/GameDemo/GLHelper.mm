
//====================================================================
//
//  GLHelper.mm
//  GameDemo
//
//  Created by Jason Riggs on 11/29/11.
//  Copyright (c) 2011 Stanford University. All rights reserved.
//
//====================================================================

#include "GLHelper.h"
#include <iostream>
#include <vector>

#include "mo_gfx.h"
#include "mo_touch.h"

#include "World.h"
#include "Orb.h"


//===========================================================
// Globals
//===========================================================

World * g_world;

static bool g_initialized = false;

// iPhone screen dimensions
static const unsigned int SCREEN_WIDTH  = 320;
static const unsigned int SCREEN_HEIGHT = 480;

// game difficulties as ints in range [1, 3]
typedef enum df {
    DIFFICULTY_NONE = 0,
    DIFFICULTY_EASY,   // 1
    DIFFICULTY_MEDIUM, // 2
    DIFFICULTY_HARD    // 3
} Difficulty;

static Difficulty DIFFICULTY = DIFFICULTY_MEDIUM;


//===========================================================
// Input Handling Callbacks (touches, accelerometer, etc.)
//===========================================================

void touchCallback( NSSet * touches, UIView * view, const std::vector<MoTouchTrack> & touchPts, void * data)
{
    // iterate over all touch points
    for( UITouch * touch in touches )
    {
        // get the location
        CGPoint location = [touch locationInView:nil];
		
        if( touch.phase == UITouchPhaseBegan )
        {
            // convert screen coords each to range [-1.0, 1.0]
            float touch_x_pos =    2.0 * (float(location.x) /  SCREEN_WIDTH) - 1.0;
            float touch_y_pos = - (2.0 * (float(location.y) / SCREEN_HEIGHT) - 1.0);
        
            // find inactive bullet
            Bullet * bullet = g_world->findInactiveBullet(touch);
            
            if( bullet != NULL )
            {
                bullet->m_active = true;
                bullet->m_touch_ref = touch;
                bullet->m_x = touch_x_pos;
                bullet->m_y = touch_y_pos;
                bullet->randomizeColor();
            }
        }
        else if( touch.phase == UITouchPhaseMoved )
        {
            // no need for this in this app...
        }
        else if( (touch.phase == UITouchPhaseEnded) || (touch.phase == UITouchPhaseCancelled) )
        {
            // no need for this in this app...
        }
    }
}


//===========================================================
// GLHelper : Public API Implementation
//===========================================================

void GLHelper_init()
{
    if(g_initialized) {
        printf("GLHelper.mm -- ERROR: initializing GLHelper when already initialized\n");
        return;
    }
    
    g_world = new World();
    
    Orb * orb = new Orb(0, 0.6);
    orb->setSpeed(float(DIFFICULTY));
    
    g_world->addEntity(orb);
    
    MoTouch::addCallback( touchCallback, NULL );
    
    g_initialized = true;
}

void GLHelper_cleanup()
{
    if(!g_initialized) {
        printf("GLHelper.mm -- ERROR: attempt to cleanup uninitialized GLHelper\n");
        return;
    }
    
    if(g_world) delete g_world;
}

void GLHelper_render()
{
    if(!g_initialized) {
        printf("GLHelper.mm -- ERROR: attempt to render uninitialized GLHelper\n");
        return;
    }
    
    glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    if(g_world) g_world->render();
}

void GLHelper_update(double time_since_last_update)
{
    if(!g_initialized) {
        printf("GLHelper.mm -- ERROR: attempt to update uninitialized GLHelper\n");
        return;
    }
    
    if(g_world) g_world->update(time_since_last_update);
}


