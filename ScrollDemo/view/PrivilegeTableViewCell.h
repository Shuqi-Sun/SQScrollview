//
//  PrivilegeTableViewCell.h
//  ScrollDemo
//
//  Created by 孙树琪 on 2019/3/12.
//  Copyright © 2019年 琪琪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GXPageContentView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PrivilegeTableViewCell : UITableViewCell

@property (nonatomic, strong) GXPageContentView *pageContentView;
//@property (nonatomic, strong) NSMutableArray *viewControllers;
@property (nonatomic, assign) BOOL cellCanScroll;
//@property (nonatomic, assign) BOOL isRefresh;

//@property (nonatomic, strong) NSString *currentTagStr;

@end

NS_ASSUME_NONNULL_END
