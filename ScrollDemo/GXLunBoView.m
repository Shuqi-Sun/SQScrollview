//
//  GXLunBoView.m
//  guixueapp
//
//  Created by guixue0001 on 16/5/23.
//  Copyright © 2016年 秦智博. All rights reserved.
//

#import "GXLunBoView.h"
//#import "UIImageView+WebCache.h"

@implementation GXLunBoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)createView
{
    self.imageArray = [NSMutableArray array];
    self.pagingEnabled = true;
    self.showsHorizontalScrollIndicator = false;
    self.delegate = self;
    self.isTimer = NO;
}

- (void)setLunBoArray:(NSArray *)lunBoArray
{
    if (_lunBoArray != lunBoArray) {
        _lunBoArray = lunBoArray;
        if (self.imageArray.count == lunBoArray.count + 2) {
            for (int i = 0; i < lunBoArray.count + 2; i ++) {
                UIImageView *imageView = self.imageArray[i];
                NSDictionary *dic = [self getDicWithIndex:i];
//                [imageView sd_setImageWithURL:[NSURL URLWithString:dic[@"image"]]placeholderImage:self.placeholderImage];
            }
        }  else if (lunBoArray.count == 1)
        {
            self.contentSize = CGSizeMake(self.frame.size.width, 0);
            for (UIImageView *imageView in self.imageArray) {
                [imageView removeFromSuperview];
            }
            [self.imageArray removeAllObjects];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, self.frame.size.width - 30, self.frame.size.height)];
            imageView.userInteractionEnabled = YES;
            imageView.tag = 2000;
            imageView.clipsToBounds = YES;
            imageView.layer.cornerRadius = 8;
            NSDictionary *dic = [_lunBoArray firstObject];
//            [imageView sd_setImageWithURL:[NSURL URLWithString:dic[@"image"]]placeholderImage:self.placeholderImage];
            [self addSubview:imageView];
            [self.imageArray addObject:imageView];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick:)];
            [imageView addGestureRecognizer:tap];
        }  else if (lunBoArray.count)
        {
            self.contentSize = CGSizeMake(self.frame.size.width * (lunBoArray.count + 2), 0);
            for (UIImageView *imageView in self.imageArray) {
                [imageView removeFromSuperview];
            }
            [self.imageArray removeAllObjects];
            for (int i = 0; i < lunBoArray.count + 2; i ++) {
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * self.frame.size.width + 15, 0, self.frame.size.width - 30, self.frame.size.height)];
                imageView.userInteractionEnabled = YES;
                imageView.tag = 2000 + i;
                imageView.clipsToBounds = YES;
                imageView.layer.cornerRadius = 8;
                NSDictionary *dic = [self getDicWithIndex:i];
//                [imageView sd_setImageWithURL:[NSURL URLWithString:dic[@"image"]]placeholderImage:self.placeholderImage];
                [self addSubview:imageView];
                [self.imageArray addObject:imageView];
                
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick:)];
                [imageView addGestureRecognizer:tap];
            }
        }
        if (lunBoArray.count > 1) {
            self.scrollEnabled = YES;
            [self setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
            [self addScrolTimer];
            self.isTimer = YES;
        } else
        {
            self.scrollEnabled = NO;
            [self setContentOffset:CGPointMake(0, 0) animated:NO];
            [self removeScrolTimer];
            self.isTimer = NO;
        }
    }
}

- (void)disappearCurrView
{
    if (self.lunBoArray.count > 1 && self.isTimer) {
        self.isTimer = NO;
    }
}

- (void)imageClick:(UITapGestureRecognizer *)tap
{
    UIImageView *imageView = (UIImageView*)tap.view;
    NSDictionary *dic;
    if (self.imageArray.count == 1) {
        dic = [_lunBoArray firstObject];
    } else
    {
        dic = [self getDicWithIndex:imageView.tag - 2000];
    }
    if (self.lunDelegate) {
        [self.lunDelegate tapImageClick:dic];
    } else {
        self.callBlock(dic);
    }
    
}

- (NSDictionary*)getDicWithIndex:(NSInteger)i
{
    NSDictionary *dic;
    if (i == 0) {
        dic  = [_lunBoArray lastObject];
    } else if (i == _lunBoArray.count + 1)
    {
        dic  = [_lunBoArray firstObject];
    } else
    {
        dic = _lunBoArray[i - 1];
    }
    return dic;
}

- (void)runTimePage
{
    NSInteger index = self.contentOffset.x/self.frame.size.width;
    if (index == 0) {
        index = _lunBoArray.count;
        self.contentOffset = CGPointMake(index*self.frame.size.width, 0);
    }else if (index == _lunBoArray.count+1)
    {
        index = 1;
        self.contentOffset = CGPointMake(index*self.frame.size.width, 0);
    }
    index++;
    [self setContentOffset:CGPointMake(index*self.frame.size.width, 0) animated:true];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeScrolTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addScrolTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x/self.frame.size.width;
    if (index == 0 && _lunBoArray.count > 1) {
        index = _lunBoArray.count;
        self.contentOffset = CGPointMake(index*self.frame.size.width, 0);
    }else if(index == _lunBoArray.count+1)
    {
        index = 1;
        self.contentOffset = CGPointMake(index*self.frame.size.width, 0);
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (!self.isTimer) {
        [self removeScrolTimer];
    }
}

- (void)addScrolTimer
{
    [self.lunboTimer invalidate];
    self.lunboTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(runTimePage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.lunboTimer forMode:NSRunLoopCommonModes];

}

- (void)removeScrolTimer
{
    [self.lunboTimer invalidate];
}


@end
