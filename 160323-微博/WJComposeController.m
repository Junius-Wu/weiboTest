//
//  WJComposeController.m
//  160323-微博
//
//  Created by Jun on 16/4/6.
//  Copyright © 2016年 Jun. All rights reserved.
//

#import "WJComposeController.h"

@interface WJComposeController ()

@end

@implementation WJComposeController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置navgation
    [self setNav];
}
//设置navigationItem
- (void)setNav {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
}


-(void)viewWillAppear:(BOOL)animated {
    //奇怪的问题 ，把这句放在viewdidLoad中就没有主题效果 
    self.navigationItem.rightBarButtonItem.enabled = NO;
}
//取消返回主页
- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}
//发送微博
- (void)send {
    
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
