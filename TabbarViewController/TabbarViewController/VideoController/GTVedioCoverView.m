//
//  GTVedioCoverView.m
//  TabbarViewController
//
//  Created by 被风吹落眼泪 on 2024/2/13.
//

#import "GTVedioCoverView.h"
#import "GTVideoPlayer.h"
#import "GTVideoToolbar.h"

@interface GTVedioCoverView()

@property (nonatomic, strong, readwrite) UIImageView *coverView;
@property (nonatomic, strong, readwrite) UIImageView *playButton;
@property (nonatomic, copy, readwrite) NSString *videoUrl;
@property (nonatomic, strong, readwrite) GTVideoToolbar *toolbar;

@end

@implementation GTVedioCoverView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self addSubview:({
            _coverView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,frame.size.width,frame.size.height)];
            _coverView;
        })];
        
        [_coverView addSubview:({
            _playButton = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - 50)/2, (frame.size.height - 50)/2, frame.size.width, frame.size.height)];
            _playButton.image = [UIImage imageNamed:@"icon.bundle/vedioPlay@3x.png"];
            _playButton;
        })];
        
        [self addSubview:({
            _toolbar = [[GTVideoToolbar alloc] initWithFrame:CGRectMake(0, _coverView.bounds.size.height, frame.size.width, GTVideoToolbarHeight)];
            _toolbar;
        })];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_tapToPlay)];
        [self addGestureRecognizer:tapGesture];
        
    }
    return self;
}

- (void)dealloc {

}

#pragma mark - public method
- (void)layoutWithVedioCoverUrl:(NSString *)videoCoverUrl videoUrl:(NSString *)videoUrl {
    _coverView.image = [UIImage imageNamed:videoCoverUrl];
    _playButton.image = [UIImage imageNamed:@"icon.bundle/vedioPlay@3x.png"];
    _videoUrl = videoUrl;
    [_toolbar layoutWithModel:nil];
}

#pragma mark -
- (void)_tapToPlay {
    NSLog(@"");
    
    NSURL *videoUrl = [NSURL URLWithString:_videoUrl];
    
    [[GTVideoPlayer Player] playVideoWithUrl:videoUrl attachView:_coverView];
    
}





@end
