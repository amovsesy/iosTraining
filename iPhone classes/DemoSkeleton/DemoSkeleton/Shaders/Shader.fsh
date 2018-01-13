
//====================================================================
//
//  Shader.fsh
//  DemoSkeleton
//
//  Created by Jason Riggs on 11/30/11.
//  Copyright (c) 2011 Stanford University. All rights reserved.
//
//====================================================================

varying lowp vec4 colorVarying;

void main()
{
    gl_FragColor = colorVarying;
}
