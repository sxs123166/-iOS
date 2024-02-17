//
//  GTNotification.m
//  TabbarViewController
//
//  Created by 被风吹落眼泪 on 2024/2/17.
//

#import "GTNotification.h"
#import <UserNotifications/UserNotifications.h>

@implementation GTNotification


+ (GTNotification *)notificationManager {
    static GTNotification *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[GTNotification alloc] init];
    });
    return manager;
}

- (void)checkNotificationAuthorization {
    [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:UNAuthorizationOptionBadge | UNAuthorizationOptionSound completionHandler:^(BOOL granted, NSError * _Nullable error) {
            NSLog(@"");
    }];
}


@end
