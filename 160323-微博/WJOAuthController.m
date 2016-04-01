//
//  WJOAuthController.m
//  160323-微博
//
//  Created by Jun on 16/3/25.
//  Copyright © 2016年 Jun. All rights reserved.
//

#import "WJOAuthController.h"
#import "AFNetworking.h"
#import "WJAccountTool.h"
#import "WJTabBarController.h"
#import "UIWindow+WJExtension.h"

@interface WJOAuthController () <UIWebViewDelegate>

@end

@implementation WJOAuthController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建webview
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    [self.view addSubview:webView];
    
    
    //创建url请求
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=3626437027&redirect_uri=http://"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}
//webView 开始载入数据 从sina获取code
- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //http://www.baidu.com/?code=7dbb0ff8df717cdede6dbba223215640
    NSURL *url = request.URL.absoluteURL;
    NSString *strURL = [url absoluteString];
    
    WJLog(@"-------a-------%@", strURL);
    NSRange range = [strURL rangeOfString:@"code="];
    if (range.length != 0) {
        int fromIndex = range.location;
        NSString *code = [strURL substringFromIndex:fromIndex + 5];
        [self accessTokenWithCode:code];
        
        //禁止加载回调地址
        return NO;
    }
    
    return YES;
}
/**
 *  使用code和app id 获得accesstoken
 *
 *  @param code <#code description#>
 */
- (void) accessTokenWithCode:(NSString *)code {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = @"3626437027";
    params[@"client_secret"] = @"c12304bb723e93341f3d9b10bbcb48d3";
    params[@"code"] = code;
    params[@"redirect_uri"] = @"http://";
    
    [manager POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(NSURLSessionDataTask *task, NSDictionary * responseObject) {
        //保存账号信息
        WJAccount *account = [WJAccount accountWithDict:responseObject];
        [WJAccountTool saveAccount:account];
        //切换控制器到tabbarcontroller
        [[UIApplication sharedApplication].keyWindow showNewFeatureOrNot];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        WJLog(@"-------TAKE_ACCESS_TOKEN_FALSE-------%@", error);
    }];
    


}


-(void)dealloc {
    WJLog(@"-------OAuthController dealloc-------");
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
