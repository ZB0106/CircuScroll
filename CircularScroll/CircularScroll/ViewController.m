//
//  ViewController.m
//  CircularScroll
//
//  Created by 瞄财网 on 2017/3/31.
//  Copyright © 2017年 瞄财网. All rights reserved.
//

#import "ViewController.h"
#import "ZBScrollView.h"

@interface ViewController ()



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZBScrollView *scrollView = [[ZBScrollView alloc] init];
//    scrollView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:scrollView];
    
    scrollView.translatesAutoresizingMaskIntoConstraints=NO;
    
    NSArray *louts = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[scrollView]-0-|" options:0 metrics:nil views:@{@"scrollView":scrollView}];
    NSArray *hs = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[scrollView(==300)]" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:@{@"scrollView":scrollView}];
    [self.view addConstraints:louts];
    [self.view addConstraints:hs];
    
    
    scrollView.dataArray = nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
