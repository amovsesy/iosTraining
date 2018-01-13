
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




//===========================================================
// GLHelper : Public API Implementation
//===========================================================



