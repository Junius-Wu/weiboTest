//
//  WJComposeController.m
//  160323-微博
//
//  Created by Jun on 16/4/6.
//  Copyright © 2016年 Jun. All rights reserved.
//

#import "WJComposeController.h"
#import "WJTextView.h"
#import "WJComposeToolBar.h"

@interface WJComposeController () <UIScrollViewDelegate, UITextViewDelegate>
@property (nonatomic, weak) WJTextView *textView;
@property (nonatomic, weak) WJComposeToolBar *toolbar;
@end

@implementation WJComposeController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置navgation
    [self setNav];
    //设置自定义textView
    [self setTextView];
    //设置底部工具条
    [self setToolBar];
}



-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    //奇怪的问题 ，把这句放在viewdidLoad中就没有主题效果
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //必须在这里设置第一响应者 在viewdidload中设置 toolbar不会跟着键盘弹上来
    [self.textView becomeFirstResponder];
}

#pragma mark - 滚动时退出键盘
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

#pragma mark - 底部工具条
- (void)setToolBar {
    WJComposeToolBar *toolbar = [[WJComposeToolBar alloc] init];
    self.toolbar = toolbar;
    [self.view addSubview:toolbar];
}
/**
 *  接受到键盘frame改变时 toolbar跟随键盘移动
 */
- (void)keyboardWillChangeFrame: (NSNotification *)notification {
    /*
     UIKeyboardAnimationCurveUserInfoKey = 7;
     UIKeyboardAnimationDurationUserInfoKey = "0.25";
     UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {320, 253}}";
     
     UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 352}, {320, 216}}";
     UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 315}, {320, 253}}";
     UIKeyboardIsLocalUserInfoKey = 1;
     */
    WJLog(@"-------start-------%f", self.toolbar.y);
    
    NSDictionary *userinfo = notification.userInfo;
    double duration = [userinfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardF = [userinfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.y = keyboardF.origin.y - WJComposeToolBarHeight;
    }completion:^(BOOL finished) {
        WJLog(@"-------end-------%f", self.toolbar.y);
    }];
    
}
#pragma mark - 输入框
- (void)setTextView {
    WJTextView *textView = [[WJTextView alloc] init];
    textView.frame = [UIScreen mainScreen].bounds;
    textView.placeHolder = @"分享新鲜事...";
    textView.alwaysBounceVertical = YES;
    textView.delegate = self;
    [self.view addSubview:textView];
    self.textView = textView;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

//监听textView有没有文字的通知 设置@“发送“是否可用
- (void)textDidChange {
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
}
#pragma mark - 设置导航栏
//设置navigationItem
- (void)setNav {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
}


//取消返回主页
- (void)cancel {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
//发送微博
- (void)send {
    
}

@end
