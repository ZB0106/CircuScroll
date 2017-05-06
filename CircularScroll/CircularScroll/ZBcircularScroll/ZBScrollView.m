//
//  ZBScrollView.m
//  CircularScroll
//
//  Created by 瞄财网 on 2017/3/31.
//  Copyright © 2017年 瞄财网. All rights reserved.
//

#import "ZBScrollView.h"


@interface ZBScrollView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) NSMutableDictionary *reuseDict;
@property (nonatomic, strong) NSMutableArray *imageViewArray;
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIImageView *centerImageView;
@property (nonatomic, strong) UIImageView *rightImageView;

@end

@implementation ZBScrollView

- (instancetype)init
{
    if (self = [super init]) {
        [self addSubViews];
        _reuseDict = [NSMutableDictionary dictionary];
        _imageViewArray = [NSMutableArray array];
        _currentPage = 0;
    }
    return self;
}

- (void)addSubViews
{
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
    [self bringSubviewToFront:_pageControl];
    [self addImageView];
    
    
    
    self.scrollView.backgroundColor = [UIColor orangeColor];
    self.pageControl.backgroundColor = [UIColor greenColor];
  
    
    
    [self layoutConstraints];
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.pagingEnabled = YES;
        _scrollView.scrollsToTop = NO;
        _scrollView.scrollEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
        
    }
    return _scrollView;
}
- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _pageControl;
}

- (void)addTimer
{
    if (!_timer) {
        _timer = [NSTimer timerWithTimeInterval:3.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
//        [_timer fire];
    }
}

- (void)removeTimer
{
    [_timer invalidate];
    _timer = nil;
}

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = @[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg",@"6.jpg",@"7.jpg"];
    if (_dataArray.count > 1) {
        [self removeTimer];
        [self addTimer];
    } else {
        [self removeTimer];
    }
    self.centerImageView.image = [UIImage imageNamed:_dataArray[0]];
   
    
    
    self.leftImageView.image = [UIImage imageNamed:_dataArray[_dataArray.count -1]];
    
    if (_dataArray.count > 1) {
        self.rightImageView.image = [UIImage imageNamed:_dataArray[1]];
        
    } else {
        self.rightImageView.image = [UIImage imageNamed:_dataArray[0]];
        

    }
    
    self.pageControl.numberOfPages = dataArray.count;
}

- (void)addImageView
{
    self.leftImageView = [[UIImageView alloc] init];
//    self.leftImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.leftImageView.userInteractionEnabled = YES;
    [self.scrollView addSubview:self.leftImageView];
    self.leftImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.leftImageView.backgroundColor = [UIColor colorWithRed:arc4random()%225 / 255.0 green:arc4random()%225 / 255.0 blue:arc4random()%225 / 255.0 alpha:1.0f];
    
    
    self.centerImageView = [[UIImageView alloc] init];
//    self.centerImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.centerImageView.userInteractionEnabled = YES;
    [self.scrollView addSubview:self.centerImageView];
    self.centerImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.centerImageView.backgroundColor = [UIColor colorWithRed:arc4random()%225 / 255.0 green:arc4random()%225 / 255.0 blue:arc4random()%225 / 255.0 alpha:1.0f];


    self.rightImageView = [[UIImageView alloc] init];
//    self.rightImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.rightImageView.userInteractionEnabled = YES;
    [self.scrollView addSubview:self.rightImageView];
    self.rightImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.rightImageView.backgroundColor = [UIColor colorWithRed:arc4random()%225 / 255.0 green:arc4random()%225 / 255.0 blue:arc4random()%225 / 255.0 alpha:1.0f];
    
}


- (void)layoutConstraints
{
    
    NSArray *scrollV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_scrollView]-0-|" options:0 metrics:nil views:@{@"_scrollView":_scrollView}];
    NSArray *scrollH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_scrollView]-0-|" options:0 metrics:nil views:@{@"_scrollView":_scrollView}];
    
    
    NSArray *pageH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[_pageControl(100)]-20-|" options:0 metrics:nil views:@{@"_pageControl":_pageControl}];
    NSArray *pageV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_pageControl(20)]-10-|" options:0 metrics:nil views:@{@"_pageControl":_pageControl}];
    
    
    NSArray *arrayV3 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_leftImageView]-0-|" options:0 metrics:nil views:@{@"_leftImageView":_leftImageView}];
    NSArray *arrayV4 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_centerImageView(==_leftImageView)]" options:0 metrics:nil views:@{@"_centerImageView":_centerImageView,@"_leftImageView":_leftImageView}];
    NSArray *arrayV5 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_rightImageView(==_leftImageView)]" options:0 metrics:nil views:@{@"_rightImageView":_rightImageView,@"_leftImageView":_leftImageView}];
    NSArray *arrayH4 = [NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[_leftImageView]-0-[_centerImageView(==_leftImageView)]-0-[_rightImageView(==_centerImageView)]-0-|" options:0 metrics:nil views:@{@"_leftImageView":_leftImageView,@"_centerImageView":_centerImageView,@"_rightImageView":_rightImageView}];
    NSLayoutConstraint *constraintW = [NSLayoutConstraint constraintWithItem:_leftImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_scrollView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
    NSLayoutConstraint *constraintH = [NSLayoutConstraint constraintWithItem:_leftImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_scrollView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];

    
    [self addConstraints:pageH];
    [self addConstraints:pageV];
    
    [self addConstraints:scrollV];
    [self addConstraints:scrollH];
    
    [_scrollView addConstraints:arrayV3];
    [_scrollView addConstraints:arrayV4];
    [_scrollView addConstraints:arrayV5];
    [_scrollView addConstraints:arrayH4];
    [_scrollView addConstraint:constraintW];
    [_scrollView addConstraint:constraintH];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{

}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //此处需做判断，避免拖动过少也会翻页的情况
    if (fabs((scrollView.contentOffset.x - scrollView.frame.size.width) / scrollView.frame.size.width) >= 0.5) {
        [self updateImage];
        scrollView.contentOffset = CGPointMake(scrollView.frame.size.width, 0);
    }
    [self addTimer];
   
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    NSLog(@"%@",NSStringFromCGPoint(velocity));
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
     [self updateImage];
    scrollView.contentOffset = CGPointMake(scrollView.frame.size.width, 0);
}
- (void)updateImage
{
    if (_scrollView.contentOffset.x > _scrollView.frame.size.width) {
        self.currentPage ++;
        self.currentPage = self.currentPage % _dataArray.count;
    } else {
//        self.currentPage --;
//
        if (self.currentPage == 0) {
            self.currentPage = _dataArray.count - 1;
        } else {
            self.currentPage --;
        }
       self.currentPage = self.currentPage % _dataArray.count;
    }
    
    self.centerImageView.image = [UIImage imageNamed:_dataArray[self.currentPage]];
    
    
    if (self.currentPage == 0) {
        self.leftImageView.image = [UIImage imageNamed:_dataArray[_dataArray.count -1]];
        
    } else {
        self.leftImageView.image = [UIImage imageNamed:_dataArray[self.currentPage -1]];
        
        
    }

    if (self.currentPage == _dataArray.count - 1) {
        self.rightImageView.image = [UIImage imageNamed:_dataArray[0]];
    } else {
        self.rightImageView.image = [UIImage imageNamed:_dataArray[self.currentPage + 1]];

    }
    
}
- (void)nextPage
{
    if (_scrollView.contentOffset.x == 2 * _scrollView.frame.size.width) {
        _scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
    }
    CGFloat x = _scrollView.contentOffset.x;
    [_scrollView setContentOffset:CGPointMake(x + self.scrollView.frame.size.width, 0) animated:YES];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    

}
@end
