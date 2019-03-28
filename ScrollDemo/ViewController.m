//
//  ViewController.m
//  ScrollDemo
//
//  Created by 孙树琪 on 2019/3/12.
//  Copyright © 2019年 琪琪. All rights reserved.
//

#import "ViewController.h"
#import "GXTableView.h"
#import "GXLunBoView.h"
#import "TopTableViewCell.h"
#import "GXSegmentTitleView.h"
#import "PrivilegeTableViewCell.h"
#import "PrivilegeOneViewController.h"
#import "PrivilegeTwoViewController.h"
#import "PrivilegeThreeViewController.h"
#import "AFNetworking/AFNetworking.h"
#import "AFNetworking/AFHTTPRequestOperationManager.h"
#import "AFNetworking/AFHTTPRequestOperation.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource,GXLunBoViewDelegate,GXSegmentTitleViewDelegate,GXPageContentViewDelegate>

@property (nonatomic, strong) GXTableView *mainTableView;

@property (nonatomic, strong) GXSegmentTitleView *titleView;

@property (nonatomic, strong) PrivilegeTableViewCell *pageCell;

@property (nonatomic, assign) BOOL canScroll;

@property (nonatomic, strong) NSDictionary *dataDic;

@property (nonatomic, strong) NSArray *cellArr;

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.canScroll = YES;
    [self request];
    self.mainTableView = [[GXTableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.view addSubview:self.mainTableView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeScrollStatus) name:@"leaveTop" object:nil];

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)createTopView{
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return 1;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 580;
        }
        return 50;
    }
    return CGRectGetHeight(self.view.bounds);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    self.titleView = [[GXSegmentTitleView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 50) titles:@[@"专享课程",@"涂鸦计划",@"分手服务",@"常见问题"] delegate:self indicatorType:GXIndicatorTypeEqualTitle];
    self.titleView.backgroundColor = [UIColor lightGrayColor];
    return self.titleView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *topIdentifier = @"TopTableViewCell";
    
    
    if (indexPath.section == 1) {
        self.pageCell = [tableView dequeueReusableCellWithIdentifier:@"PrivilegeTableViewCell"];
        if (!_pageCell) {
            _pageCell = [[PrivilegeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PrivilegeTableViewCell"];
            NSArray *titles = @[@"专享课程",@"涂鸦计划",@"分手服务",@"常见问题"];
            NSMutableArray *contentVCs = [NSMutableArray array];
            for (int i = 0; i < titles.count; i++) {
                if (i == 0) {
                    PrivilegeOneViewController *vc = [[PrivilegeOneViewController alloc] init];
                    [contentVCs addObject:vc];
                } else if (i == 1) {
                    PrivilegeTwoViewController *vc = [[PrivilegeTwoViewController alloc] init];
                    [contentVCs addObject:vc];
                } else if (i == 2) {
                    PrivilegeThreeViewController *vc = [[PrivilegeThreeViewController alloc] init];
                    [contentVCs addObject:vc];
                } else if (i == 3) {
                    PrivilegeThreeViewController *vc = [[PrivilegeThreeViewController alloc] init];
                    [contentVCs addObject:vc];
                }
            }
            self.pageCell.pageContentView = [[GXPageContentView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64) childVCs:contentVCs parentVC:self delegate:self];
            [self.pageCell.contentView addSubview:self.pageCell.pageContentView];
        }
        return self.pageCell;
    }
    if (indexPath.row == 0) {
        TopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:topIdentifier];
        if (!cell) {
            cell = [[TopTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:topIdentifier];
        }
        [cell reloadCellWithDic:self.dataDic];
        return cell;
    }
    
    return nil;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat bottomCellOffset = [self.mainTableView rectForSection:1].origin.y;
    if (scrollView.contentOffset.y >= bottomCellOffset) {
        scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
        if (self.canScroll) {
            self.canScroll = NO;
            self.pageCell.cellCanScroll = YES;
        }
    }else{
        if (!self.canScroll) {//子视图没到顶部
            scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
        }
    }
    self.mainTableView.showsVerticalScrollIndicator = _canScroll?YES:NO;
}

- (void)tapImageClick:(NSDictionary *)dic{
    
}

- (void)GXSegmentTitleView:(GXSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex{
    self.pageCell.pageContentView.contentViewCurrentIndex = endIndex;

}

- (void)GXContenViewDidEndDecelerating:(GXPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex{
    self.titleView.selectIndex = endIndex;
    self.mainTableView.scrollEnabled = YES;
}

- (void)GXContentViewDidScroll:(GXPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex progress:(CGFloat)progress{
    self.mainTableView.scrollEnabled = NO;
}
- (void)changeScrollStatus//改变主视图的状态
{
    self.canScroll = YES;
    self.pageCell.cellCanScroll = NO;
}

- (void)request{
    
    NSURL *URL = [NSURL URLWithString:@"https://v.guixue.com/apiielts/vip?v=3.5.0"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:URL.absoluteString parameters:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        self.dataDic = responseObject;
        self.cellArr = responseObject[@"royalty"];
        [self.mainTableView reloadData];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
 
}
@end
