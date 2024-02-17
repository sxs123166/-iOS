//
//  GTDeleteCellView.h
//  TabbarViewController
//
//  Created by 被风吹落眼泪 on 2024/1/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTDeleteCellView : UIView

- (void)showDeleteViewFromPoint:(CGPoint)point clickBlock:(dispatch_block_t)clickBlock;

- (void)dismissDeleteView;

@end

NS_ASSUME_NONNULL_END
