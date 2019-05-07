//
//  SCN3DVideoAdatper.h
//  OtusWifiCamera
//
//  Created by tat on 16/8/30.
//  Copyright © 2016年 tat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

/////////////////////////////////////////////////////////////////////////////////////////////////////////

@class SCN3DVideoAdatper;

@protocol SCN3DVideoAdatperDelegate <NSObject>

@optional

- (void)videoPlayerIsReadyToPlayVideo:(SCN3DVideoAdatper *)videoAdatper;
- (void)videoPlayerDidReachEnd:(SCN3DVideoAdatper *)videoAdatper;
- (void)videoPlayer:(SCN3DVideoAdatper *)videoAdatper timeDidChange:(CMTime)cmTime;
- (void)videoPlayer:(SCN3DVideoAdatper *)videoAdatper loadedTimeRangeDidChange:(float)duration;
- (void)videoPlayer:(SCN3DVideoAdatper *)videoAdatper didFailWithError:(NSError *)error;

- (void)videoPlayer:(SCN3DVideoAdatper *)videoAdatper displaylinkCallbackImage:(UIImage *)videoImage;

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////

@interface SCN3DVideoAdatper : NSObject

@property (nonatomic, weak) id<SCN3DVideoAdatperDelegate> delegate;
@property (nonatomic, strong, readonly) AVPlayer     *player;
@property (nonatomic, strong, readonly) AVPlayerItem *playerItem;
@property (nonatomic, strong, readonly) AVPlayerItemVideoOutput *output;
@property (nonatomic, assign, getter=isPlaying, readonly) BOOL playing;
@property (nonatomic, assign, getter=isLooping) BOOL looping;
@property (nonatomic, assign, getter=isMuted) BOOL muted;

// Setting

- (void)setURL:(NSURL *)URL;
- (void)setPlayerItem:(AVPlayerItem *)playerItem;
- (void)setAsset:(AVAsset *)asset;

// Playback

- (void)play;
- (void)pause;
- (void)reset;
- (void)seekToTime:(float)time completion:(void (^)(void))completion;

// Volume

- (void)setVolume:(float)volume;
- (void)fadeInVolume;
- (void)fadeOutVolume;

// Displaylink

- (void)addDisplaylink;
- (void)removeDisplaylink;

@end
