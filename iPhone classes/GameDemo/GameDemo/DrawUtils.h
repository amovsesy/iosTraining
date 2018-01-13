
//====================================================================
//
//  DrawUtils.h
//  GameDemo
//
//  Created by Jason Riggs on 11/29/11.
//  Copyright (c) 2011 Stanford University. All rights reserved.
//
//====================================================================

#ifndef GameDemo_DrawUtils_h
#define GameDemo_DrawUtils_h

// Simple drawing helpers. Source Below.
// http://iphonedevelopment.blogspot.com/2008/10/circles-and-ellipses-in-opengl-es.html

float degreesToRadians(float degrees)
{
    return degrees*(M_PI/180.0);
}

void GLDrawEllipse (int segments, CGFloat width, CGFloat height, CGPoint center, bool filled)
{
    glTranslatef(center.x, center.y, 0.0);
    GLfloat vertices[segments*2];
    int count=0;
    for (GLfloat i = 0; i < 360.0f; i+=(360.0f/segments))
    {
        vertices[count++] = (cos(degreesToRadians(i))*width);
        vertices[count++] = (sin(degreesToRadians(i))*height);
    }
    glVertexPointer (2, GL_FLOAT , 0, vertices);
    
    glEnableClientState(GL_VERTEX_ARRAY); 
    glDrawArrays ((filled) ? GL_TRIANGLE_FAN : GL_LINE_LOOP, 0, segments);
    glTranslatef(-center.x, -center.y, 0.0);
}

void GLDrawCircle(int circleSegments, CGFloat radius, CGPoint center, bool filled) 
{
    GLDrawEllipse(circleSegments, radius, radius, center, filled);
}

#endif
