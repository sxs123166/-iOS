//
//  GTVideoPlayer.m
//  TabbarViewController
//
//  Created by 被风吹落眼泪 on 2024/2/14.
//

#import "GTVideoPlayer.h"
#import <AVFoundation/AVFoundation.h>

@interface GTVideoPlayer()

@property (nonatomic, strong, readwrite) AVPlayerItem *videoItem;
@property (nonatomic, strong, readwrite) AVPlayer *avPlayer;
@property (nonatomic, strong, readwrite) AVPlayerLayer *playerLayer;

@end

@implementation GTVideoPlayer

+ (GTVideoPlayer *)Player {
    static GTVideoPlayer *player;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        player = [[GTVideoPlayer alloc] init];
    });
    return player;
}

- (void)playVideoWithUrl:(NSURL *)videoUrl attachView:(UIView *)attachView {
    
    [self _stopPlay];
    
    AVAsset *asset = [AVAsset assetWithURL:videoUrl];

    _videoItem = [AVPlayerItem playerItemWithAsset:asset];
    
    [_videoItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    // 缓冲进度
    [_videoItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    
    CMTime duration = _videoItem.duration;
    CGFloat videoDuration = CMTimeGetSeconds(duration);
    
    _avPlayer = [AVPlayer playerWithPlayerItem:_videoItem];
    // 1s回调一次，value/timescale为1即可
    [_avPlayer addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        NSLog(@"播放进度：%@", @(CMTimeGetSeconds(time)));
    }];
    
//    AVPlayer *avPlayer = [AVPlayer playerWithURL:videoUrl];
    
    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_avPlayer];
    
    _playerLayer.frame = attachView.bounds;
    [attachView.layer addSublayer:_playerLayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_handlePlayEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}


#pragma mark -
- (void)_stopPlay {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"");
    [_playerLayer removeFromSuperlayer];
    [_videoItem removeObserver:self forKeyPath:@"status"];
    [_videoItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    _videoItem = nil;
    _avPlayer = nil;
}

- (void)_handlePlayEnd {
//    NSLog(@"");

    
    [_avPlayer seekToTime:CMTimeMake(0, 1)];
    [_avPlayer play];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if([keyPath isEqualToString:@"status"]) {
        if(((NSNumber *)[change objectForKey:NSKeyValueChangeNewKey]).integerValue == AVPlayerItemStatusReadyToPlay) {
            [_avPlayer play];
        } else {
            NSLog(@"");
        }
        
    } else if([keyPath isEqualToString:@"loadedTimeRanges"]) {
        NSLog(@"缓冲：%@", [change objectForKey:NSKeyValueChangeNewKey]);
    }
    
}

@end
