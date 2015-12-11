//
//  UCloudMediaPlayer.h
//

#import <Foundation/Foundation.h>
#import "UCloudMediaPlayback.h"

typedef NS_ENUM(NSInteger, DecodeMthod)
{
    DecodeMthodSoft,
    DecodeMthodHard
};

@interface UCloudMediaPlayer : NSObject
/**
 *  播放器控制器
 */
@property (strong, nonatomic) id<UCloudMediaPlayback>player;
/**
 *  支持的方向
 */
@property (assign, nonatomic) NSUInteger supportInterOrtation;

/**
 *  构造播放器实例
 *
 *  @param url    视频路径
 *  @param vc     显示视图控制器
 *  @param name   视频名字
 *  @param method 解码方式(直播流只能选择软解)
 *
 *  @return 实例
 */
- (id)initWithUrl:(NSURL *)url showInViewController:(UIViewController *)vc name:(NSString *)name decodeMthod:(DecodeMthod)method;
@end
