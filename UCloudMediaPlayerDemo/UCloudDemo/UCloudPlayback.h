/*
 * UCloudPlayback.h
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>


@protocol UCloudPlayback;


#pragma mark UCloudPlayback

@protocol UCloudPlayback <NSObject>

- (void)prepareToPlay;
- (void)play;
- (void)pause;
- (void)stop;
- (BOOL)isPlaying;
- (void)shutdown;
- (void)setPauseInBackground:(BOOL)pause;

@property(nonatomic, readonly)  UIView *view;
@property(nonatomic)            NSTimeInterval currentPlaybackTime;
@property(nonatomic, readonly)  NSTimeInterval duration;
@property(nonatomic, readonly)  NSTimeInterval playableDuration;
@property(nonatomic, readonly)  NSInteger bufferingProgress;

@property(nonatomic, readonly)  BOOL isPreparedToPlay;
@property(nonatomic, readonly)  MPMoviePlaybackState playbackState;
@property(nonatomic, readonly)  MPMovieLoadState loadState;

@property(nonatomic, readonly) int64_t numberOfBytesTransferred;

@property(nonatomic) MPMovieControlStyle controlStyle;
@property(nonatomic) MPMovieScalingMode scalingMode;
@property(nonatomic) BOOL shouldAutoplay;

@property (nonatomic) BOOL allowsMediaAirPlay;
@property (nonatomic) BOOL isDanmakuMediaAirPlay;
@property (nonatomic, readonly) BOOL airPlayMediaActive;

- (UIImage *)thumbnailImageAtCurrentTime;

#pragma mark Notifications

#ifdef __cplusplus
#define UCLOUD_EXTERN extern "C" __attribute__((visibility ("default")))
#else
#define UCLOUD_EXTERN extern __attribute__((visibility ("default")))
#endif

UCLOUD_EXTERN NSString *const UCloudPlaybackIsPreparedToPlayDidChangeNotification;

UCLOUD_EXTERN NSString *const UCloudPlayerLoadStateDidChangeNotification;
UCLOUD_EXTERN NSString *const UCloudPlayerPlaybackDidFinishNotification;
UCLOUD_EXTERN NSString *const UCloudPlayerPlaybackStateDidChangeNotification;

UCLOUD_EXTERN NSString *const UCloudPlayerIsAirPlayVideoActiveDidChangeNotification;
UCLOUD_EXTERN NSString *const UCloudPlayerVideoDecoderOpenNotification;
@end

#pragma mark IJKMediaResource

@protocol UCloudMediaSegmentResolver <NSObject>

- (NSString *)urlOfSegment:(int)segmentPosition;

@end
