
//====================================================================
//
//  ViewController.mm
//  GameDemo
//
//  Created by Jason Riggs on 11/29/11.
//  Copyright (c) 2011 Stanford University. All rights reserved.
//
//====================================================================

#import "ViewController.h"
#import "GLHelper.h"

@interface ViewController () {}

@property (strong, nonatomic) EAGLContext * context;
@property (strong, nonatomic) GLKBaseEffect * effect;

@end

@implementation ViewController

@synthesize context = _context;
@synthesize effect = _effect;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Force to use OpenGL ES 1 rather than ES 2
    // (see <OpenGLES/EAGL.h> for API enum information)
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
    
    if (!self.context) {
        NSLog(@"Failed to create ES context");
    }
    
    GLKView * view = (GLKView *)self.view;
    view.context = self.context;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    
    [EAGLContext setCurrentContext:self.context];
    
    GLHelper_init();
}

- (void)viewDidUnload
{    
    [super viewDidUnload];
    
    [EAGLContext setCurrentContext:self.context];
    
    GLHelper_cleanup();
    
    if ([EAGLContext currentContext] == self.context) {
        [EAGLContext setCurrentContext:nil];
    }
	self.context = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - GLKView and GLKViewController delegate methods

- (void)update
{
    GLHelper_update(self.timeSinceLastUpdate);
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    GLHelper_render();
}

@end
