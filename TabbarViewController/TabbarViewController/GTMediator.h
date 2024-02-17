//
//  GTMediator.h
//  TabbarViewController
//
//  Created by 被风吹落眼泪 on 2024/2/16.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol GTDetailViewControllerProtocol <NSObject>

- (__kindof UIViewController *)detailViewControllerWithUrl:(NSString *)detailUrl;

@end

@interface GTMediator : NSObject

// target action
+ (__kindof UIViewController *)detailViewControllerWithUrl:(NSString *)detailUrl;

// urlscheme
typedef void(^GTMediatorProcessBlock)(NSDictionary *params);
+ (void)registerScheme:(NSString *)scheme processBlock:(GTMediatorProcessBlock)processBlock;
+ (void)openUrl:(NSString *)url params:(NSDictionary *)params;

// protocal class
+ (void)registerProtol:(Protocol *)proto class:(Class)cls;
+ (Class)classForProtol:(Protocol *)proto;
@end

NS_ASSUME_NONNULL_END
