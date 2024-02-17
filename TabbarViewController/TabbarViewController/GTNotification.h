//
//  GTNotification.h
//  TabbarViewController
//
//  Created by 被风吹落眼泪 on 2024/2/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
 APP推送管理
 */

@interface GTNotification : NSObject

+ (GTNotification *)notificationManager;

- (void)checkNotificationAuthorization;

@end

NS_ASSUME_NONNULL_END
