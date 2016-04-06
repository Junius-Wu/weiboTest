//
//  WJNavigationController.m
//  160323-微博
//
//  Created by Jun on 16/3/23.
//  Copyright © 2016年 Jun. All rights reserved.
//

#import "WJNavigationController.h"
#import "UIBarButtonItem+Extension.h"

@interface WJNavigationController ()

@end

@implementation WJNavigationController
//设置主题
+(void)initialize {
    
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    //设置不可用状态
    NSMutableDictionary *disableAttrs = [NSMutableDictionary dictionary];
    disableAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    disableAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:disableAttrs forState:UIControlStateDisabled];
    //设置普通状态
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    
  
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//重写push 在push之前设置navigationitem
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    [super pushViewController:viewController animated:YES];
    
    if (self.viewControllers.count >1) {//说明不是第一个控制器（根控制器）
        //添加左上的箭头按钮 和右边的...按钮
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(backClick) image:@"navigationbar_back" highImage:@"navigationbar_back_highlighted"];
        
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(more) image:@"navigationbar_more" highImage:@"navigationbar_more_highlighted"];
    }
    

 
    
}


- (void) backClick {
    [self popViewControllerAnimated:YES];
    
}
- (void) more {
    [self popToRootViewControllerAnimated:YES];
    
}

@end
