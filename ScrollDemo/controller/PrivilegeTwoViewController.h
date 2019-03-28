//
//  PrivilegeTwoViewController.h
//  ScrollDemo
//
//  Created by 孙树琪 on 2019/3/12.
//  Copyright © 2019年 琪琪. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PrivilegeTwoViewController : UIViewController

@property (nonatomic, assign) BOOL vcCanScroll;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSDictionary *dic;

@end

NS_ASSUME_NONNULL_END
