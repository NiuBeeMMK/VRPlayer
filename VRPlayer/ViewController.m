//
//  ViewController.m
//  VRPlayer
//
//  Created by Metagem on 2019/5/7.
//  Copyright © 2019 SevenNine. All rights reserved.
//

#import "ViewController.h"
#import "SCN3DPlayer/SCN3DPlayerView.h"
#import "SCN3DPlayer/SCN3DVideoAdatper.h"

@interface ViewController () <SCN3DVideoAdatperDelegate> {
    UIInterfaceOrientation currentInterfaceOrientation;
}

@property (weak, nonatomic) IBOutlet UIView *videoView;
@property (strong, nonatomic) SCN3DPlayerView *scn3DView;
@property (strong, nonatomic) SCN3DVideoAdatper *scn3DAdatper;
@property (strong, nonatomic) UIImage *image;


@property (weak, nonatomic) IBOutlet UISlider *videoSlider;
@property (weak, nonatomic) IBOutlet UILabel *curTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *allTimeLab;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sourceSegment;
@property (weak, nonatomic) IBOutlet UISegmentedControl *displaySegment;

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.title = NSLocalizedString(@"VRPlayer", nil);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 生成渲染视图
    self.scn3DView = [[SCN3DPlayerView alloc] initWithFrame:self.videoView.bounds];
    self.scn3DView.backgroundColor = [UIColor blackColor];
    [self.videoView addSubview:self.scn3DView];
    
    
    
    [self changeDataSource:self.sourceSegment];
    [self changeDisplayMode:self.displaySegment];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.scn3DView.frame = self.videoView.bounds;
}

- (IBAction)changeDataSource:(id)sender {
    UISegmentedControl *segment = (UISegmentedControl *)sender;
    if (segment.selectedSegmentIndex == 0) {
        // 删除解码器
        if (self.scn3DAdatper.isPlaying) {
            [self.scn3DAdatper removeDisplaylink];
            [self.scn3DAdatper pause];
        }
        self.scn3DAdatper = nil;
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"vr_image" ofType:@"jpg"];
        self.image = [UIImage imageWithContentsOfFile:filePath];
        [self.scn3DView setFramesPerVideoImage:self.image];
    }
    else {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"vr_video" ofType:@"mp4"];
        self.image = nil;
        [self.scn3DView setFramesPerVideoImage:self.image];
        
        // 初始化解码器
        self.scn3DAdatper = [[SCN3DVideoAdatper alloc] init];
        self.scn3DAdatper.delegate = self;
        [self.scn3DAdatper setURL:[NSURL fileURLWithPath:filePath]];
    }
    
    self.videoSlider.value = 0;
    self.curTimeLab.text = @"--:--";
    self.allTimeLab.text = @"--:--";
}

- (IBAction)changeDisplayMode:(id)sender {
    UISegmentedControl *segment = (UISegmentedControl *)sender;
    SCN3DDisplayMode mode = segment.selectedSegmentIndex;
    switch (mode) {
        case SCN3DDisplayModePlaneNormal:
            [self.scn3DView setVideoDisplayMode:SCN3DDisplayModePlaneNormal];
            [self.scn3DView setHorizontalEnabled:YES verticalEnabled:YES];
            [self.scn3DView setGSensorMotionEnabled:NO];
            [self.scn3DView setPinchScaleEnabled:NO];
            break;
        case SCN3DDisplayModePlaneSlide:
            [self.scn3DView setVideoDisplayMode:SCN3DDisplayModePlaneSlide];
            [self.scn3DView setHorizontalEnabled:YES verticalEnabled:NO];
            [self.scn3DView setGSensorMotionEnabled:NO];
            [self.scn3DView setPinchScaleEnabled:NO];
            break;
        case SCN3DDisplayModeShapeTube:
            [self.scn3DView setVideoDisplayMode:SCN3DDisplayModeShapeTube];
            [self.scn3DView setHorizontalEnabled:YES verticalEnabled:YES];
            [self.scn3DView setGSensorMotionEnabled:NO];
            [self.scn3DView setPinchScaleEnabled:YES];
            [self.scn3DView setMinScale:1.0 maxScale:1.3];  // 设定最大最小缩放值
            [self.scn3DView setCurrentRotateX:30 rotateY:0];  // 设定当前旋转角度
            [self.scn3DView setVerticalMinRotate:-30 maxRotate:30];  // 设定上下旋转角度
            break;
        case SCN3DDisplayModeShapeBall:
            [self.scn3DView setVideoDisplayMode:SCN3DDisplayModeShapeBall];
            [self.scn3DView setHorizontalEnabled:YES verticalEnabled:YES];
            [self.scn3DView setGSensorMotionEnabled:NO];
            [self.scn3DView setPinchScaleEnabled:YES];
            [self.scn3DView setVerticalMinRotate:-90 maxRotate:90];
            [self.scn3DView setCurrentRotateX:0 rotateY:0];
            break;
        case SCN3DDisplayModeVR360Full:
            [self.scn3DView setVideoDisplayMode:SCN3DDisplayModeVR360Full];
            [self.scn3DView setHorizontalEnabled:YES verticalEnabled:YES];
            [self.scn3DView setGSensorMotionEnabled:YES];
            [self.scn3DView setPinchScaleEnabled:YES];
            [self.scn3DView setVerticalMinRotate:-90 maxRotate:90];
            [self.scn3DView setCurrentRotateX:0 rotateY:0];
            break;
        case SCN3DDisplayModeVRGlasses:
            [self.scn3DView setVideoDisplayMode:SCN3DDisplayModeVRGlasses];
            [self.scn3DView setHorizontalEnabled:YES verticalEnabled:YES];
            [self.scn3DView setGSensorMotionEnabled:YES];
            [self.scn3DView setPinchScaleEnabled:YES];
            [self.scn3DView setVerticalMinRotate:-90 maxRotate:90];
            [self.scn3DView setCurrentRotateX:0 rotateY:0];
            break;
        case SCN3DDisplayModeVRPlanet:
            [self.scn3DView setVideoDisplayMode:SCN3DDisplayModeVRPlanet];
            [self.scn3DView setHorizontalEnabled:YES verticalEnabled:YES];
            [self.scn3DView setGSensorMotionEnabled:YES];
            [self.scn3DView setPinchScaleEnabled:YES];
            break;
        default:
            break;
    }
    [self.scn3DView setFramesPerVideoImage:self.image];
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark SCN3DVideoAdatperDelegate
/////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)videoPlayerIsReadyToPlayVideo:(SCN3DVideoAdatper *)videoAdatper {  // 准备播放
    int totalTime = CMTimeGetSeconds(videoAdatper.playerItem.duration);
    int min = totalTime / 60;
    int sec = totalTime - min * 60;
    self.videoSlider.maximumValue = totalTime;
    self.allTimeLab.text = [NSString stringWithFormat:@"%02d:%02d", min, sec];
    
    [videoAdatper addDisplaylink];  // 添加回调线程
    [self.scn3DAdatper play];
}

- (void)videoPlayerDidReachEnd:(SCN3DVideoAdatper *)videoAdatper {  // 播放结束
    [self.scn3DAdatper play];
}

- (void)videoPlayer:(SCN3DVideoAdatper *)videoAdatper timeDidChange:(CMTime)cmTime {  // 当前播放时间
    int curTime = CMTimeGetSeconds(cmTime);
    int min = curTime / 60;
    int sec = curTime - min * 60;
    self.videoSlider.value = curTime;
    self.curTimeLab.text = [NSString stringWithFormat:@"%02d:%02d", min, sec];
}

- (void)videoPlayer:(SCN3DVideoAdatper *)videoAdatper loadedTimeRangeDidChange:(float)duration {  // 视频缓冲长度
    int totalTime = CMTimeGetSeconds(videoAdatper.playerItem.duration);
    if (totalTime != 0) {
        // 设置缓冲时间，可以用progress控件显示
    }
}

- (void)videoPlayer:(SCN3DVideoAdatper *)videoAdatper displaylinkCallbackImage:(UIImage *)videoImage {  // 每帧回调图像
    self.image = videoImage;
    [self.scn3DView setFramesPerVideoImage:videoImage];
}

- (IBAction)timeSliderValueChanged:(UISlider *)sender {  // 滑动播放进度
    float seekTime = sender.value;
    if (self.scn3DAdatper.isPlaying) {
        [self.scn3DAdatper pause];
    }
    [self.scn3DAdatper seekToTime:seekTime completion:^{
        [self.scn3DAdatper play];
    }];
}

@end
