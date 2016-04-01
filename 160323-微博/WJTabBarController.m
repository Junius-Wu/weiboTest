//
//  WJTabBarController.m
//  160323-微博
//
//  Created by Jun on 16/3/23.
//  Copyright © 2016年 Jun. All rights reserved.
//  下面的tabBar 显示

#import "WJTabBarController.h"
#import "WJHomeViewController.h"
#import "WJMessageViewController.h"
#import "WJProfileViewController.h"
#import "WJDiscoverViewController.h"
#import "WJNavigationController.h"
#import "WJTabBarWithPlusBtn.h"

@interface WJTabBarController () <WJTabBarWithPlusBtnDelegate>

@end

@implementation WJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WJHomeViewController *homeVC = [[WJHomeViewController alloc] init];
    [self addChildVC:homeVC title:@"主页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    WJMessageViewController *messageVC = [[WJMessageViewController alloc] init];
    [self addChildVC:messageVC title:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    WJDiscoverViewController *discoverVC = [[WJDiscoverViewController alloc] init];
    [self addChildVC:discoverVC title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    WJProfileViewController *profileVC = [[WJProfileViewController alloc] init];
    [self addChildVC:profileVC title:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
    
    //设置自定义tabBar 加上+号
    WJTabBarWithPlusBtn *tabBar = [[WJTabBarWithPlusBtn alloc]init];
   // tabBar.delegate = self; 不用写 因为tabbar的delegate 本来就是self
     [self setValue:tabBar forKeyPath:@"tabBar"];
}

-(void)tabBarDidClickPlusButton {
    UIViewController *vc = [[UIViewController alloc] init];
    [vc.view setBackgroundColor:[UIColor redColor]];
    [self presentViewController:vc animated:YES completion:nil];
}

/**
 *  添加nav(rootView为一个tableview)到tabbarVC中
 */
- (void) addChildVC:(UIViewController *)viewController title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    
    //设置title
    viewController.title = title;
    NSMutableDictionary *attri = [NSMutableDictionary dictionary];
    attri[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [viewController.tabBarItem setTitleTextAttributes:attri forState:UIControlStateSelected];
    //设置图片
    viewController.tabBarItem.image = [UIImage imageNamed:image];
    [viewController.tabBarItem setSelectedImage:[[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
     ];
    
    WJNavigationController *nav = [[WJNavigationController alloc] initWithRootViewController:viewController];
    [self addChildViewController:nav];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
