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

@end
