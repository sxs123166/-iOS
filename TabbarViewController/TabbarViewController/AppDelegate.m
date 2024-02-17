//
//  AppDelegate.m
//  TabbarViewController
//
//  Created by 被风吹落眼泪 on 2023/12/31.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "SecondViewController.h"
#import "GTVedioViewController.h"
#import "GTRecommendViewController.h"
#import "GTSplashView.h"
#import <execinfo.h>
#import "GTLocation.h"
#import "GTNotification.h"

@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(nullable NSDictionary<UIApplicationLaunchOptionsKey, id> *)launchOptions {
    
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UITabBarController *tabbarController = [[UITabBarController alloc] init];
    tabbarController.tabBar.backgroundColor = [UIColor lightGrayColor];
    
    ViewController *viewController = [[ViewController alloc] init];
    viewController.tabBarItem.title = @"首页";
    
    SecondViewController *controller2 = [[SecondViewController alloc] init];
//    controller2.view.backgroundColor = [UIColor redColor];
    
    GTVedioViewController *controller3 = [[GTVedioViewController alloc] init];
    
    GTRecommendViewController *controller4 = [[GTRecommendViewController alloc] init];
    
    NSArray *viewControllers = @[viewController, controller2, controller3, controller4];
    tabbarController.viewControllers = viewControllers;
    tabbarController.delegate = self;
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:tabbarController];
    
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    [self.window addSubview:({
        GTSplashView *splashView = [[GTSplashView alloc] initWithFrame:self.window.bounds];
        splashView;
    })];
    
    [[GTLocation loactionManager] checkLocationAuthorization];
    
    [[GTNotification notificationManager] checkNotificationAuthorization];
    
//    [self _caughtException];
//
//    [@[].mutableCopy addObject:nil];
    
    return YES;
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}
- (void)applicationWillResignActive:(UIApplication *)application {
        
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}


#pragma mark - click

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    NSLog(@"tab点击");
}


#pragma mark - scheme

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
    NSLog(@"");
    
    return YES;
}

#pragma mark - crash

- (void)_caughtException {
    // NSException
    NSSetUncaughtExceptionHandler(HandleNSException);
    
    // signal
    signal(SIGABRT, SignalExceptionHandler);
    signal(SIGILL, SignalExceptionHandler);
    signal(SIGSEGV, SignalExceptionHandler);
    signal(SIGFPE, SignalExceptionHandler);
    signal(SIGBUS, SignalExceptionHandler);
    signal(SIGPIPE, SignalExceptionHandler);
}

void SignalExceptionHandler(int signal) {
    void* callstack[128];
    int frames = backtrace(callstack, 128);
    char **strs = backtrace_symbols(callstack, frames);
    NSMutableArray *backtrace = [NSMutableArray arrayWithCapacity:frames];
    for (int i = 0; i < frames; i++) {
        [backtrace addObject:[NSString stringWithUTF8String:strs[i]]];
    }
    free(strs);
}

void HandleNSException(NSException *exception) {
    __unused NSString *reason = [exception reason];
    __unused NSString *name = [exception name];
    // 存储crash信息
    
}

@end
