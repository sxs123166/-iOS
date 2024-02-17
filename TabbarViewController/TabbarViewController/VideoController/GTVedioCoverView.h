//
//  GTVedioCoverView.h
//  TabbarViewController
//
//  Created by 被风吹落眼泪 on 2024/2/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTVedioCoverView : UICollectionViewCell

- (void)layoutWithVedioCoverUrl:(NSString *)videoCoverUrl videoUrl:(NSString *)videoUrl;

@end

NS_ASSUME_NONNULL_END
