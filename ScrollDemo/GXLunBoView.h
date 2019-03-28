//
//  GXLunBoView.h
//  guixueapp
//
//  Created by guixue0001 on 16/5/23.
//  Copyright © 2016年 秦智博. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol GXLunBoViewDelegate <NSObject>

- (void)tapImageClick:(NSDictionary*)dic;

@end

@interface GXLunBoView : UIScrollView<UIScrollViewDelegate>

@property (nonatomic, strong) NSTimer *lunboTimer;

@property (nonatomic, strong) NSArray *lunBoArray;

@property (nonatomic, strong) NSMutableArray *imageArray;

@property (nonatomic, assign) BOOL isTimer;

@property (nonatomic, weak) id<GXLunBoViewDelegate> lunDelegate;

@property (nonatomic, strong) UIImage *placeholderImage;

@property (nonatomic, copy) void (^callBlock)(NSDictionary *dic);

- (void)disappearCurrView;

@end
