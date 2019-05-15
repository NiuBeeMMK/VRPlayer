//
//  SCN3DVideoAdatper.h
//  视频解析类，将视频文件解析为逐帧图像
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

/// 视频准备播放
- (void)videoPlayerIsReadyToPlayVideo:(SCN3DVideoAdatper *)videoAdatper;
/// 视频播放结束
- (void)videoPlayerDidReachEnd:(SCN3DVideoAdatper *)videoAdatper;
/// 视频当前播放时间
- (void)videoPlayer:(SCN3DVideoAdatper *)videoAdatper timeDidChange:(CMTime)cmTime;
/// 视频缓冲时长
- (void)videoPlayer:(SCN3DVideoAdatper *)videoAdatper loadedTimeRangeDidChange:(float)duration;
/// 视频错误处理
- (void)videoPlayer:(SCN3DVideoAdatper *)videoAdatper didFailWithError:(NSError *)error;
/// 视频帧图像，可用于自定义渲染
- (void)videoPlayer:(SCN3DVideoAdatper *)videoAdatper displaylinkCallbackImage:(UIImage *)videoImage;

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////

@interface SCN3DVideoAdatper : NSObject

@property (nonatomic, weak) id<SCN3DVideoAdatperDelegate> delegate;
@property (strong, nonatomic, readonly) AVPlayer     *player;
@property (strong, nonatomic, readonly) AVPlayerItem *playerItem;
@property (strong, nonatomic, readonly) AVPlayerItemVideoOutput *output;  // 视频输出流
@property (assign, nonatomic, getter=isPlaying, readonly) BOOL playing;  // 是否处于播放状态
@property (assign, nonatomic, getter=isLooping) BOOL looping;  // 是否循环播放
@property (assign, nonatomic, getter=isMuted) BOOL muted;  // 是否静音

//_________________________________________________________________________________________________
// Setting

/// 设置资源URL
- (void)setURL:(NSURL *)URL;
/// 设置资源Item
- (void)setPlayerItem:(AVPlayerItem *)playerItem;
/// 设置资源Asset
- (void)setAsset:(AVAsset *)asset;

//_________________________________________________________________________________________________
// Playback

/// 播放
- (void)play;
/// 暂停
- (void)pause;
/// 重置
- (void)reset;
/// 跳转到指定时间播放
- (void)seekToTime:(float)time completion:(void (^)(void))completion;

//_________________________________________________________________________________________________
// Volume

/// 音量设置，0.0~1.0
- (void)setVolume:(float)volume;
/// 音量增加0.1
- (void)fadeInVolume;
/// 音量减少0.1
- (void)fadeOutVolume;

//_________________________________________________________________________________________________
// Displaylink

/**
 添加屏幕刷新线程，调用屏幕的刷新率来解析视频逐帧图像
 使用 - (void)videoPlayer:(SCN3DVideoAdatper *)videoAdatper displaylinkCallbackImage:(UIImage *)videoImage 代理时必须添加
 */
- (void)addDisplaylink;
/// 移除屏幕刷新线程
- (void)removeDisplaylink;

@end
