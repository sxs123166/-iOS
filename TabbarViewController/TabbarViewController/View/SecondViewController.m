//
//  SecondViewController.m
//  TabbarViewController
//
//  Created by 被风吹落眼泪 on 2023/12/31.
//

#import "SecondViewController.h"
#import "GTNormalTableViewCell.h"
#import "GTDeleteCellView.h"
#import "GTListLoader.h"
#import "GTMediator.h"

@interface SecondViewController ()<UITableViewDataSource, UITableViewDelegate, GTNormalTableViewCellDelegate>

@property (nonatomic, strong, readwrite) UITableView *tableView;

@property (nonatomic, strong, readwrite) NSArray *dataArray;

@property (nonatomic, strong, readwrite) GTListLoader *listLoader;

@end

@implementation SecondViewController

- (instancetype)init {
    self = [super init];
    if(self){
        self.tabBarItem.title = @"新闻";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    [self.view addSubview:_tableView];
    
    self.listLoader = [[GTListLoader alloc] init];
    __weak typeof(self) wself = self;
    [self.listLoader loadListDataWithFinishBlock:^(BOOL success, NSArray<GTListItem *> * _Nonnull dataArray) {
        __strong typeof(self) strongSelf = wself;
        strongSelf.dataArray = dataArray;
        [strongSelf.tableView reloadData];
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GTListItem *item = [self.dataArray objectAtIndex:indexPath.row];
//    __kindof UIViewController *detailController = [GTMediator detailViewControllerWithUrl:item.articleUrl];
//    detailController.view.backgroundColor = [UIColor whiteColor];
//    detailController.navigationItem.title = [NSString stringWithFormat:@"%@", @(indexPath.row)];
//    [self.navigationController pushViewController:detailController animated:YES];
    
//    [GTMediator openUrl:@"detail://" params:@{@"url":item.articleUrl, @"controller":self.navigationController}];
    
    Class cls = [GTMediator classForProtol:@protocol(GTDetailViewControllerProtocol)];
    [self.navigationController pushViewController:[[cls alloc] detailViewControllerWithUrl:item.articleUrl] animated:YES];
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:item.uniqueKey];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 从回收池中复用
    GTNormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    if(!cell) {
        cell = [[GTNormalTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"id"];
    }
    cell.delegate = self;
    [cell layoutTableViewCellWithItem:[self.dataArray objectAtIndex:indexPath.row]];
//    cell.textLabel.text = [NSString stringWithFormat:@"主标题 - %@",@(indexPath.row)];
//    cell.detailTextLabel.text = @"副标题";
//    cell.imageView.image = [UIImage imageNamed:@"icon.bundle/vedio@2x.png"];
    return cell;
}


- (void)tableViewCell:(UITableViewCell *)tableViewCell clickDeleteButton:(UIButton *)deleteButton {
    NSLog(@"cell的deleteButton点击");
    GTDeleteCellView *deleteView = [[GTDeleteCellView alloc] initWithFrame:self.view.bounds];
    
    __weak typeof(self) wself = self;
    CGRect rect = [tableViewCell convertRect:deleteButton.frame toView:nil];
    [deleteView showDeleteViewFromPoint:rect.origin clickBlock:^{
        __strong typeof(self) strongself = wself;
        NSIndexPath *path = [strongself.tableView indexPathForCell:tableViewCell];
        if(path) {
//            [strongself.dataArray removeObjectAtIndex:path.row];
        }
        [strongself.tableView deleteRowsAtIndexPaths:@[[strongself.tableView indexPathForCell:tableViewCell]] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
}


@end
