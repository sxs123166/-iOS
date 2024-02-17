//
//  GTListItem.m
//  TabbarViewController
//
//  Created by 被风吹落眼泪 on 2024/1/30.
//

#import "GTListItem.h"

@implementation GTListItem

- (nullable instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if(self) {
        self.category = [coder decodeObjectForKey:@"category"];
        self.picUrl = [coder decodeObjectForKey:@"picUrl"];
        self.uniqueKey = [coder decodeObjectForKey:@"uniqueKey"];
        self.title = [coder decodeObjectForKey:@"title"];
        self.date = [coder decodeObjectForKey:@"date"];
        self.authorName = [coder decodeObjectForKey:@"authorName"];
        self.articleUrl = [coder decodeObjectForKey:@"articleUrl"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.category forKey:@"category"];
    [coder encodeObject:self.picUrl forKey:@"picUrl"];
    [coder encodeObject:self.uniqueKey forKey:@"uniqueKey"];
    [coder encodeObject:self.title forKey:@"title"];
    [coder encodeObject:self.date forKey:@"date"];
    [coder encodeObject:self.authorName forKey:@"authorName"];
    [coder encodeObject:self.articleUrl forKey:@"articleUrl"];
}

- (BOOL)supportsSecureCoding {
    return YES;
}

- (void)configWithdictionary:(NSDictionary *)dictionary {
    self.category = [dictionary objectForKey:@"category"];
    self.picUrl = [dictionary objectForKey:@"picUrl"];
    self.uniqueKey = [dictionary objectForKey:@"uniqueKey"];
    self.title = [dictionary objectForKey:@"title"];
    self.date = [dictionary objectForKey:@"date"];
    self.authorName = [dictionary objectForKey:@"authorName"];
    self.articleUrl = [dictionary objectForKey:@"articleUrl"];
}

@end
