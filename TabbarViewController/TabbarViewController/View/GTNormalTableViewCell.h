//
//  GTNormalTableViewCell.h
//  TabbarViewController
//
//  Created by 被风吹落眼泪 on 2024/1/1.
//

#import <UIKit/UIKit.h>
#import "GTListItem.h"

NS_ASSUME_NONNULL_BEGIN

@protocol GTNormalTableViewCellDelegate <NSObject>

- (void)tableViewCell:(UITableViewCell *)tableViewCell clickDeleteButton:(UIButton *)deleteButton;

@end


@interface GTNormalTableViewCell : UITableViewCell

@property (nonatomic, weak, readwrite) id<GTNormalTableViewCellDelegate> delegate;

- (void)layoutTableViewCellWithItem:(GTListItem *)item;

@end

NS_ASSUME_NONNULL_END
