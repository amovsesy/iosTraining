//
//  FaceView.h
//  Happiness
//
//  Created by LI Admin on 6/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FaceView;

@protocol FaceViewDataSource

-(float)smileForFaceView:(FaceView*)sender;

@end

@interface FaceView : UIView

#define DEFAULT_SCALE 0.90
#define EYE_H 0.35
#define EYE_V 0.35
#define EYE_RADIUS 0.10
#define MOUTH_H 0.45
#define MOUTH_V 0.40
#define MOUTH_SMILE 0.25

@property (nonatomic) CGFloat scale;

-(void)pinch:(UIPinchGestureRecognizer *)gesture;

@property (nonatomic, weak) IBOutlet id <FaceViewDataSource> dataSource; 

@end
