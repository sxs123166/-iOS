//
//  GTVedioViewController.m
//  TabbarViewController
//
//  Created by 被风吹落眼泪 on 2024/1/1.
//

#import "GTVedioViewController.h"
#import "GTVedioCoverView.h"
#import "GTVideoToolbar.h"

@interface GTVedioViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation GTVedioViewController

- (instancetype)init {
    self = [super init];
    if(self) {
        self.view.backgroundColor = [UIColor yellowColor];
        self.tabBarItem.title = @"视频";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.itemSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.width / 16 * 9 + GTVideoToolbarHeight);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    // ios 11及以上系统自动设置contentInset     UIScrollView UITableView UICollectionView我们不需要适配iphoneX
//    collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:[GTVedioCoverView class] forCellWithReuseIdentifier:@"GTVedioCoverView"];
    
    
    [self.view addSubview:collectionView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidScroll");
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GTVedioCoverView" forIndexPath:indexPath];
    if([cell isKindOfClass:[GTVedioCoverView class]]) {
        [((GTVedioCoverView *)cell) layoutWithVedioCoverUrl:@"icon.bundle/videoCover@3x.png" videoUrl:@"test"];
    }
    return cell;
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    if(indexPath.item % 3 == 0) {
//        return CGSizeMake(self.view.frame.size.width, 100);
//    } else {
//        return CGSizeMake((self.view.frame.size.width - 10)/2, 300);
//    }
//
//}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.navigationItem.title = [NSString stringWithFormat:@"%@", @(indexPath.row)];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
