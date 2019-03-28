//
//  TopTableViewCell.h
//  ScrollDemo
//
//  Created by 孙树琪 on 2019/3/12.
//  Copyright © 2019年 琪琪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GXLunBoView.h"
#define SCREENWIDTH       [[UIScreen mainScreen] bounds].size.width
#define SCREENHEIGHT      [[UIScreen mainScreen] bounds].size.height

NS_ASSUME_NONNULL_BEGIN

@interface TopTableViewCell : UITableViewCell

@property (nonatomic, strong) GXLunBoView *lunboView;

@property (nonatomic, strong) UIImageView *topImageView;

@property (nonatomic, strong) UIImageView *memberImageV;

@property (nonatomic, strong) UIView *privilegeView;

@property (nonatomic, strong) UIButton *joinBtn;

- (CGFloat)reloadCellWithDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
