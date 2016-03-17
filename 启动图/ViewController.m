//
//  ViewController.m
//  启动图
//
//  Created by 任玉飞 on 16/3/17.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#define pageCount 5
#define ScreenWidth [[UIScreen mainScreen]bounds].size.width
#define ScreenHeigh [[UIScreen mainScreen]bounds].size.height
#define picH 2330 / 2
#define padding 200
#define topPicH 70
#define topPicW 112
#define btnH 35
#define btnW 140
#import "ViewController.h"
#import "UIView+RYF.h"


@interface ViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *mainScrollView;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) UIScrollView *topScrollView;

@property (nonatomic, strong) UIImageView *bottomImg;

@property (nonatomic, strong) UIImageView *topImg;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIImageView *imageBgView = [[UIImageView alloc]initWithFrame:self.view.frame];
    imageBgView.image = [UIImage imageNamed:@"page_bg_35"];
    [self.view addSubview:imageBgView];
    
    _mainScrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
    _mainScrollView.contentSize = CGSizeMake(ScreenWidth * pageCount, ScreenHeigh);
    _mainScrollView.bounces = NO;
    _mainScrollView.showsVerticalScrollIndicator = NO;
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    _mainScrollView.delegate = self;
    _mainScrollView.pagingEnabled = YES;
    [self.view addSubview:_mainScrollView];
    
    _bottomImg = [[UIImageView alloc]init];
    _bottomImg.width = picH;
    _bottomImg.height = picH;
    _bottomImg.centerX = ScreenWidth / 2;
    _bottomImg.centerY = ScreenHeigh + padding;
    _bottomImg.layer.anchorPoint = CGPointMake(0.5, 0.5);
    _bottomImg.image = [UIImage imageNamed:@"guider_qiu_35"];
    [self.view addSubview:_bottomImg];
    
    _topImg = [[UIImageView alloc]init];
    _topImg.height = picH;
    _topImg.width = picH;
    _topImg.centerY = ScreenHeigh + padding;
    _topImg.centerX = ScreenWidth / 2;
    _topImg.layer.anchorPoint = CGPointMake(0.5, 0.5);
    _topImg.image = [UIImage imageNamed:@"guider_pai_35"];
    [self.view addSubview:_topImg];
    
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(ScreenWidth / 2 - 50, ScreenHeigh - 20, 100, 20)];
    _pageControl.numberOfPages = pageCount;
    _pageControl.currentPage = 0;
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:0.0 green:0.6706 blue:0.9373 alpha:1.0];
    [self.view addSubview:_pageControl];
    
    
    _topScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, topPicH)];
    _topScrollView.contentSize = CGSizeMake(ScreenWidth * pageCount, topPicH);
    _topScrollView.bounces = NO;
    _topScrollView.showsVerticalScrollIndicator = NO;
    _topScrollView.showsHorizontalScrollIndicator = NO;
    _topScrollView.pagingEnabled = YES;
    for (int i = 0 ; i < pageCount; i++) {
        UIImageView *topPic =  [[UIImageView alloc] init];
        topPic.width = topPicW;
        topPic.height = topPicH;
        topPic.centerX = i * ScreenWidth + ScreenWidth / 2;
        topPic.y = 0;
        NSString *picName = [NSString stringWithFormat:@"page_top_%d",i];
        topPic.image = [UIImage imageNamed:picName];
        [_topScrollView addSubview:topPic];
    }
    [self.view addSubview:_topScrollView];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    _bottomImg.layer.transform = CATransform3DMakeRotation(-offsetX *(M_PI)/ScreenWidth / 3, 0, 0, 1);
    _topImg.layer.transform = CATransform3DMakeRotation(-offsetX *(M_PI)/ScreenWidth / 3, 0, 0, 1);

    _pageControl.currentPage = scrollView.contentOffset.x / ScreenWidth;
    
    _topScrollView.contentOffset = CGPointMake(offsetX, 0);
}

@end
