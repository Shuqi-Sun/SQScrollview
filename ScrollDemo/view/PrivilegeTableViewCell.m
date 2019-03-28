//
//  PrivilegeTableViewCell.m
//  ScrollDemo
//
//  Created by 孙树琪 on 2019/3/12.
//  Copyright © 2019年 琪琪. All rights reserved.
//

#import "PrivilegeTableViewCell.h"
#import "PrivilegeOneViewController.h"
#import "PrivilegeTwoViewController.h"
#import "PrivilegeThreeViewController.h"

@implementation PrivilegeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

#pragma mark Setter
//- (void)setViewControllers:(NSMutableArray *)viewControllers
//{
//    _viewControllers = viewControllers;
//}

- (void)setCellCanScroll:(BOOL)cellCanScroll
{
    _cellCanScroll = cellCanScroll;

}
//
//- (void)setIsRefresh:(BOOL)isRefresh
//{
//    _isRefresh = isRefresh;
//
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
