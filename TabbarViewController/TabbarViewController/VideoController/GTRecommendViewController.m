//
//  GTRecommendViewController.m
//  TabbarViewController
//
//  Created by 被风吹落眼泪 on 2024/1/1.
//

#import "GTRecommendViewController.h"

@interface GTRecommendViewController ()<UIScrollViewDelegate, UIGestureRecognizerDelegate>

@end

@implementation GTRecommendViewController

- (instancetype)init {
    self = [super init];
    if(self){
        self.tabBarItem.title = @"推荐";
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.backgroundColor = [UIColor lightGrayColor];
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 5, self.view.bounds.size.height);
    
    NSArray *colorArray = @[[UIColor redColor], [UIColor blueColor], [UIColor yellowColor], [UIColor lightGrayColor], [UIColor grayColor]];
    for (int i = 0; i < 5; i++) {
        [scrollView addSubview:({
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(scrollView.bounds.size.width * i, 0, scrollView.bounds.size.width, scrollView.bounds.size.height)];
            view.backgroundColor = [colorArray objectAtIndex:i];
            [view addSubview:({
                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 200, 100, 100)];
                view.backgroundColor = [UIColor yellowColor];
                UITapGestureRecognizer *tapGesure = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewClick)];
                tapGesure.delegate = self;
                [view addGestureRecognizer:tapGesure];
                view;
            })];
            view;
        })];
    }
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
}

- (void)viewClick {
    NSLog(@"viewClick");
    
    NSURL *urlScheme = [NSURL URLWithString:@"testScheme://"];
    
    BOOL canOpenURL = [[UIApplication sharedApplication] canOpenURL:urlScheme];
    
    [[UIApplication sharedApplication] openURL:urlScheme options:nil completionHandler:^(BOOL success) {
        NSLog(@"");
    }];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"scrollviewDidScroll - %@", @(scrollView.contentOffset.x));
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    NSLog(@"Begin Dragging");
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    NSLog(@"EndDragging");
}
// 开始减速
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    NSLog(@"BeginDecelerating");
}
// 停止减速
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"EndDecelerating");
}

@end
