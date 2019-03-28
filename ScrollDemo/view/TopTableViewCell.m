//
//  TopTableViewCell.m
//  ScrollDemo
//
//  Created by 孙树琪 on 2019/3/12.
//  Copyright © 2019年 琪琪. All rights reserved.
//

#import "TopTableViewCell.h"

@implementation TopTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createView];
    }
    return self;
    
}

- (instancetype)init
{
    if (self = [super init]) {
        [self createView];
    }
    return self;
}

- (void)createView
{
    self.lunboView = [[GXLunBoView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 96*SCREENWIDTH/375)];
//    self.lunboView.backgroundColor = [UIColor cyanColor];
    [self.contentView addSubview:self.lunboView];
    
    self.topImageView = [[UIImageView alloc] init];
    self.topImageView.backgroundColor = [UIColor colorWithRed:43.0 / 255.0 green:43.0 / 255.0 blue:43.0 / 255.0 alpha:1];
    [self.contentView addSubview:self.topImageView];
    
    self.memberImageV = [[UIImageView alloc] init];
    [self.topImageView addSubview:self.memberImageV];
    
    self.privilegeView = [[UIView alloc] init];
    [self.topImageView addSubview:self.privilegeView];
    
    self.joinBtn = [[UIButton alloc] init];
    self.joinBtn.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.joinBtn];
}

- (CGFloat)reloadCellWithDic:(NSDictionary *)dic{
    self.lunboView.lunBoArray = dic[@"banner"];
    
    self.topImageView.frame = CGRectMake(0, CGRectGetMaxY(self.lunboView.frame), SCREENWIDTH, 306);
    [self cornerRadius:self.topImageView andType:2];
    
    self.memberImageV.image = [UIImage imageNamed:@"ielts_vip_banner"];
    self.memberImageV.frame = CGRectMake(30, 30, SCREENWIDTH - 60, 125);
    
    self.privilegeView.frame = CGRectMake(0, CGRectGetMaxY(self.memberImageV.frame), SCREENWIDTH, 92);
    [self reloadPrivilegeViewWithArr:dic[@"privilege"]];
    NSDictionary *memberDic = dic[@"member"];
    
    self.joinBtn.frame = CGRectMake(18, CGRectGetMaxY(self.topImageView.frame) + 32, SCREENWIDTH - 36, 50);
    self.joinBtn.layer.cornerRadius = 25;
    [self.joinBtn setTitle:memberDic[@"btn"] forState:UIControlStateNormal];
    [self.joinBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    return CGRectGetMaxY(self.joinBtn.frame) + 40;
}

- (void)reloadPrivilegeViewWithArr:(NSArray *)arr{
    [self.privilegeView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGFloat itemWidth = (SCREENWIDTH - 2 * 23) / 3;
    CGFloat itemHeight = 60;
    for (int i = 0; i < arr.count; i++) {
        NSDictionary *dic = arr[i];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(23 + i * itemWidth, 12, itemWidth, itemHeight)];
        view.backgroundColor = [UIColor clearColor];
        [self.privilegeView addSubview:view];
        
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(itemWidth / 2 - 15, 20, 30, 30)];
        NSURL *url = [NSURL URLWithString:dic[@"image"]];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        imageV.image = image;
        [view addSubview:imageV];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageV.frame) + 11, itemWidth, 16)];
        label.text = dic[@"title"];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:16];
        [view addSubview:label];
    }
}
- (void)cornerRadius:(UIView*)view andType:(NSInteger)type
{
    if (type == 1) {
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = view.bounds;
        maskLayer.path = maskPath.CGPath;
        view.layer.mask = maskLayer;
    }else if (type == 2)
    {
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(SCREENWIDTH / 8, SCREENWIDTH / 8)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = view.bounds;
        maskLayer.path = maskPath.CGPath;
        view.layer.mask = maskLayer;
    }else if (type == 3)
    {
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = view.bounds;
        maskLayer.path = maskPath.CGPath;
        view.layer.mask = maskLayer;
    }else
    {
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(0, 0)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = view.bounds;
        maskLayer.path = maskPath.CGPath;
        view.layer.mask = maskLayer;
    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
