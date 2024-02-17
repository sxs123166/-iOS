//
//  GTListLoader.m
//  TabbarViewController
//
//  Created by 被风吹落眼泪 on 2024/1/28.
//
#define DxmURL @"https://app.duxiaoman.com/walletapp/home/home_config"

#import "GTListLoader.h"
#import <AFNetworking.h>
#import "GTListItem.h"

@implementation GTListLoader

- (void)loadListDataWithFinishBlock:(GTListLoaderFinishBlock)finishBlock {
    
    NSArray<GTListItem *> *listdata = [self readDataFromLocal];
    if(listdata) {
        finishBlock(YES, listdata.copy);
    }
    
    NSString *urlString = DxmURL;
    NSURL *listURL = [NSURL URLWithString:urlString];

    NSURLRequest *listRequest = [NSURLRequest requestWithURL:listURL];

    NSURLSession *session = [NSURLSession sharedSession];

//    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:listRequest];
    __weak typeof(self) weakSelf = self;
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:listURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"处理response");
        
        __strong typeof(self) strongSelf = weakSelf;
        
        NSError *jsonError;
        id jsonObj = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError]; //二进制流转换成对象
#warning 类型检查
        NSArray *dataArray = [((NSDictionary *)[((NSDictionary *)jsonObj) objectForKey:@"result"]) objectForKey:@"data"];
        NSMutableArray *listItemArray = @[].mutableCopy;
        for (NSDictionary *info in dataArray) {
            GTListItem *listItem = [[GTListItem alloc] init];
            [listItem configWithdictionary:info];
            [listItemArray addObject:listItem];
        }
        
        [strongSelf _archiveListDataWithArray:listItemArray.copy];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if(finishBlock) {
                finishBlock(error == nil, listItemArray.copy);
            }
        });
    }];

    // 默认是挂起状态，调用resume开始执行
    [dataTask resume];

    NSLog(@"");
    
    
    
    // AFNetworking
//    [[AFHTTPSessionManager manager] GET:DxmURL parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"succeed");
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"fail");
//    }];
    
    
}

- (NSArray<GTListItem *> *)readDataFromLocal {
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [pathArray firstObject];
    NSString *listDataPath = [cachePath stringByAppendingPathComponent:@"GTData/list"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSData *readListData = [fileManager contentsAtPath:listDataPath];
    
    id unarchiveObj = [NSKeyedUnarchiver unarchivedObjectOfClasses:[NSSet setWithObjects:[NSArray class], [GTListItem class], nil] fromData:readListData error:nil];
    
    if([unarchiveObj isKindOfClass:[NSArray class]] && [unarchiveObj count] > 0) {
        return (NSArray<GTListItem *> *)unarchiveObj;
    }
    
    return nil;
    
}

- (void) _archiveListDataWithArray:(NSArray<GTListItem *> *) array{
    // 是个宏， 第一个参数的含义是获取相应文件的地址（可以选择document library也可使library下的cache）, 第二个参数的含义是用户维度的文件夹还是系统维度的文件夹，
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [pathArray firstObject];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *dataPath = [cachePath stringByAppendingPathComponent:@"GTData"];
    // 创建文件夹
    NSError *createError;
    [fileManager createDirectoryAtPath:dataPath withIntermediateDirectories:YES attributes:nil error:&createError];
    // 创建文件
    NSString *listDataPath = [dataPath stringByAppendingPathComponent:@"list"];
    //    NSData *listData = [@"abc" dataUsingEncoding:NSUTF8StringEncoding];
    // 序列化
    NSData *listData = [NSKeyedArchiver archivedDataWithRootObject:array requiringSecureCoding:YES error:nil];
    
    [fileManager createFileAtPath:listDataPath contents:listData attributes:nil];
    
    // 反序列化
    NSData *readListData = [fileManager contentsAtPath:listDataPath];
    id unarchiveObj = [NSKeyedUnarchiver unarchivedObjectOfClasses:[NSSet setWithObjects:[NSArray class], [GTListItem class], nil] fromData:readListData error:nil];
    
    // 查询文件
    BOOL fileExist = [fileManager fileExistsAtPath:listDataPath];
    
//     删除
//        if(fileExist) {
//            [fileManager removeItemAtPath:listDataPath error:nil];
//        }
    
    
//    [[NSUserDefaults standardUserDefaults] setObject:listData forKey:@"listData"];
//
//    NSData *testListData = [[NSUserDefaults standardUserDefaults] dataForKey:@"listData"];
//
//    id userDefaultsUnarchiveObj = [NSKeyedUnarchiver unarchivedObjectOfClasses:[NSSet setWithObjects:[NSArray class], [GTListItem class], nil] fromData:testListData error:nil];
    
    NSLog(@"");
    
    
    // 追加
    //    NSFileHandle *fileHandler = [NSFileHandle fileHandleForUpdatingAtPath:listDataPath];
    //
    //    [fileHandler seekToEndOfFile];
    //    [fileHandler writeData:[@"def" dataUsingEncoding:NSUTF8StringEncoding]];
    //
    //    [fileHandler synchronizeFile];
    //    [fileHandler closeFile];
    //}
}


@end
