//
//  GTVideoPlayer.h
//  TabbarViewController
//
//  Created by 被风吹落眼泪 on 2024/2/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTVideoPlayer : UIView

+ (GTVideoPlayer *)Player;

- (void)playVideoWithUrl:(NSURL *)videoUrl attachView:(UIView *)attachView;

@end

NS_ASSUME_NONNULL_END
