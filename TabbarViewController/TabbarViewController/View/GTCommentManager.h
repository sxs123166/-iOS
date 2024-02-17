//
//  GTCommentManager.h
//  TabbarViewController
//
//  Created by 被风吹落眼泪 on 2024/2/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTCommentManager : UIView

+ (GTCommentManager *)sharedManager;

- (void)showCommentView;


@end

NS_ASSUME_NONNULL_END
