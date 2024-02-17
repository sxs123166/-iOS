//
//  GTListLoader.h
//  TabbarViewController
//
//  Created by 被风吹落眼泪 on 2024/1/28.
//

#import <Foundation/Foundation.h>
@class GTListItem;
NS_ASSUME_NONNULL_BEGIN

typedef void(^GTListLoaderFinishBlock)(BOOL success, NSArray<GTListItem *> *dataArray);
/**
 列表请求
 */

@interface GTListLoader : NSObject


- (void)loadListDate;

- (void)loadListDataWithFinishBlock:(GTListLoaderFinishBlock)finishBlock;

@end

NS_ASSUME_NONNULL_END
