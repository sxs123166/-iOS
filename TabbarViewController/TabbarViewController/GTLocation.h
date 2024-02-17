//
//  GTLocation.h
//  TabbarViewController
//
//  Created by 被风吹落眼泪 on 2024/2/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
 App中位置信息统一管理
 */

@interface GTLocation : NSObject

+ (GTLocation *)loactionManager;

- (void)checkLocationAuthorization;

@end

NS_ASSUME_NONNULL_END
