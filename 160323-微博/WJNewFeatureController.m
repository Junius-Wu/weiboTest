//
//  WJNewFeatureController.m
//  160323-微博
//
//  Created by Jun on 16/3/26.
//  Copyright © 2016年 Jun. All rights reserved.
//

#import "WJNewFeatureController.h"
#import "WJTabBarController.h"

@interface WJNewFeatureController () <UIScrollViewDelegate>
@property (nonatomic, weak) UIPageControl *pagecontrol;
@end

@implementation WJNewFeatureController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.delegate = self;
    scrollView.frame = [UIScreen mainScreen].bounds;
    scrollView.contentSize = CGSizeMake(scrollView.width * 4, 0);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    for (int i = 0; i < 4; i++) {
        NSString *imageName = [NSString stringWithFormat:@"new_feature_%d", i + 1];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        imageView.userInteractionEnabled = YES;
        //imageView.bounds = [UIScreen mainScreen].bounds;
        imageView.x = i * imageView.width;
        [scrollView addSubview:imageView];
        
        if (i == 3) { //在最后一个imageView加上按钮
            UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
            [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
            [startBtn setTitle:@"马上开始" forState:UIControlStateNormal];
            [startBtn addTarget:self action:@selector(startBtnClick) forControlEvents:UIControlEventTouchDown];
            startBtn.width = 105;
            startBtn.height = 36;
            startBtn.centerX = [UIScreen mainScreen].bounds.size.width / 2;
            startBtn.y = [UIScreen mainScreen].bounds.size.height * 7.5 / 10.0;
            [imageView addSubview:startBtn];
            
        }
    }
    WJLog(@"-------xxx-------%@", scrollView.subviews);
    [self.view addSubview:scrollView];
    
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2.0, [UIScreen mainScreen].bounds.size.height * 9.0 / 10.0 , 0, 0)];
    pageControl.numberOfPages = 4;
    [pageControl setPageIndicatorTintColor:[UIColor grayColor]];
    self.pagecontrol = pageControl;
    [self.view addSubview:pageControl];
    
    
}

//点击了马上开始
- (void)startBtnClick {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window setRootViewController:[[WJTabBarController alloc] init]];
}

-(void)dealloc {
    WJLog(@"-------newFeature dealloc-------");
}
//代理方法 监听滚动
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    double page = scrollView.contentOffset.x / scrollView.width;
    WJLog(@"-------page-------%d", self.pagecontrol.currentPage);
    self.pagecontrol.currentPage = (int)(page + 0.5);
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
