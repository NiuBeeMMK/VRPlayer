//
//  SCN3DPlayerView.h
//  OpenGLTest
//
//  Created by tat on 16/8/23.
//  Copyright © 2016年 tat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SceneKit/SceneKit.h>
#import <GLKit/GLKit.h>

/////////////////////////////////////////////////////////////////////////////////////////////////////////

typedef NS_ENUM(NSInteger, SCN3DInteractive_) {
    SCN3DInteractive_Touch,
    SCN3DInteractive_Motion,
    SCN3DInteractive_MotionAndTouch,
};

typedef NS_ENUM(NSUInteger, SCN3DDisplayMode_) {
    SCN3DDisplayMode_Plane_Normal = 0,
    SCN3DDisplayMode_Plane_Slide,
    SCN3DDisplayMode_Tube,
    SCN3DDisplayMode_Sphere,
    SCN3DDisplayMode_VR360,
    SCN3DDisplayMode_VRGlass,
};

/////////////////////////////////////////////////////////////////////////////////////////////////////////

@interface SCN3DPlayerView : UIView

@property (nonatomic, strong) SCNScene *scene;
@property (nonatomic, strong) SCNView  *scViewLeft;
@property (nonatomic, strong) SCNView  *scViewRight;
@property (nonatomic, strong) SCNNode  *shapeNode;
@property (nonatomic, strong) SCNNode  *cameraNode;

//_________________________________________________________________________________________________

- (void)setInteractiveMode:(SCN3DInteractive_)interactive;
- (void)setVideoDisplayMode:(SCN3DDisplayMode_)displayMode;
- (void)setHorizontalEnabled:(BOOL)horEnabled verticalEnabled:(BOOL)verEnabled;
- (void)setGSensorMotionEnabled:(BOOL)GSensorEnabled;
- (void)setPinchScaleEnabled:(BOOL)pinchEnabled;
- (void)setMinScale:(float)minScale maxScale:(float)maxScale;
- (void)setVerticalMinRotate:(float)minRotate maxRotate:(float)maxRotate;
- (void)setTextureOffsetX:(float)x offsetY:(float)y;
- (void)setTextureScaleX:(float)x ScaleY:(float)y;

//_________________________________________________________________________________________________

- (void)setVideoAspectRatio:(float)aspectRatio;
- (void)setCurrentOrientation:(UIInterfaceOrientation)orientation;
- (void)setCurrentScale:(float)curScale;
- (void)setCurrentRotateX:(float)rotateX rotateY:(float)rotateY;

//_________________________________________________________________________________________________

- (void)setFramesPerVideoImage:(UIImage *)image;

@end
