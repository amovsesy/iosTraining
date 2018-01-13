//
//  Shader.fsh
//  GameDemo
//
//  Created by Jason Riggs on 11/29/11.
//  Copyright (c) 2011 Stanford University. All rights reserved.
//

varying lowp vec4 colorVarying;

void main()
{
    gl_FragColor = colorVarying;
}
