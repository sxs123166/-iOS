//
//  GTListItem.h
//  TabbarViewController
//
//  Created by 被风吹落眼泪 on 2024/1/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTListItem : NSObject<NSSecureCoding>

@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *picUrl;
@property (nonatomic, copy) NSString *uniqueKey;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *authorName;
@property (nonatomic, copy) NSString *articleUrl;


- (void)configWithdictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
