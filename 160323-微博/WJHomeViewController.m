//
//  WJHomeViewController.m
//  160323-微博
//
//  Created by Jun on 16/3/23.
//  Copyright © 2016年 Jun. All rights reserved.
//

#import "WJHomeViewController.h"
#import "WJTitleButton.h"
#import "WJDropdownMenu.h"
#import "WJTitleMenuTableViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "WJAccountTool.h"
#import "MJExtension.h"
#import "WJStatus.h"
#import "WJUser.h"
#import "UIImageView+WebCache.h"
#import "WJLoadMoreFootView.h"
#import "WJStatusCell.h"

@interface WJHomeViewController () <WJDropdownMenuDelegate>
@property (nonatomic, weak) WJTitleButton *titleBtn;
@property (nonatomic, strong) NSMutableArray *statusArray;
@property (nonatomic, assign) BOOL noMore;
@end

@implementation WJHomeViewController

static WJAccount *account;

-(NSMutableArray *)statusArray {
    if (_statusArray == nil) {
        _statusArray = [[NSMutableArray alloc] init];
    }
    return _statusArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   //test
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(loadMoreStatus)];
    //test
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
//    [self.tableView setValue:UITableViewStylePlain forKey:@"style"];
    account = [WJAccountTool account];
    //获得并设置用户的name
    [self setupUserInfo];
    //设置导航栏内容
    [self setNav];
    // 上面的刷新控件
    [self setRefresh];
    // 下面的刷新footView
    [self setLoadMoreView];
    
}
/**
 *  设置下面的footView
 */
- (void)setLoadMoreView {
    self.tableView.tableFooterView = [WJLoadMoreFootView footerView];
    self.tableView.tableFooterView.hidden = YES;
}
/**
 *  下拉到最后一行时加载更多旧status
 */
- (void)loadMoreStatus {
    
    self.tableView.tableFooterView.hidden = NO;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;

//    if ([self.statusArray lastObject]) { //限制最大id不超过最后那个微博
//        WJStatus *lastStatus = [self.statusArray lastObject];
//        //必须传一个NSNumber
//        params[@"max_id"] = @(lastStatus.idstr.longLongValue - 1);
//    }
    
    @synchronized(self) {//枷锁 防止连续刷新
        //https://api.weibo.com/2/statuses/friends_timeline.json //好友微博
        [manager GET:@"https://api.weibo.com/2/statuses/public_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
            //返回的字典数组 转为 模型数组
            NSArray *moreStatuses = [WJStatus mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
            if (moreStatuses.count == 0) {//如果没有新数据则直接return
                self.noMore = YES;
                WJLog(@"------count-------%d", moreStatuses.count);
                
                return ;
            }
            //插入到当前数组之后
            [self.statusArray addObjectsFromArray:moreStatuses];
            [self.tableView reloadData];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            WJLog(@"-------LOAD_MOEW_FAILSE-------%@", error);
        }];
    }
    
}

/**
 *  刷新控件
 */
- (void)setRefresh {
    UIRefreshControl *control = [[UIRefreshControl alloc] init];
    [control addTarget:self action:@selector(refreshStateChange:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:control];
    [control beginRefreshing];
    // 刷新一次微博数据
    [self refreshStateChange:control];
}
/**
 *  刷新数据
 */
- (void)refreshStateChange:(UIRefreshControl *) control {
    //刷新title
    [self setNav];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    //请求好友微博时需要这个参数  公共微博只需要access token
//    if ([[self.statusArray firstObject] idstr] != nil) {
//        params[@"since_id"] = [[self.statusArray firstObject] idstr];
//    }
    @synchronized(self) {
        
        [manager GET:@"https://api.weibo.com/2/statuses/public_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
            //返回的字典数组 转为 模型数组
            NSArray *newStatuses = [WJStatus mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
            if (newStatuses == nil) {
                return ;
            }
            //插入到当前数组之前
            [self.statusArray insertObjects:newStatuses atIndexes:[NSIndexSet indexSetWithIndexesInRange: NSMakeRange(0, newStatuses.count)]];
            [self.tableView reloadData];
            [control endRefreshing];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            WJLog(@"-------REFRESH_STATE_FAILSE-------%@", error);
            [control endRefreshing];
        }];
    }
    
}

/**
 *  设置导航栏内容
 */
- (void) setNav{
    //设置首页按钮
    self.titleBtn = [WJTitleButton titleButtonWithTitle:account.name ? account.name : @"首页"];
    self.titleBtn.titleLabel.font = kTitleFont;
    [self.titleBtn addTarget:self action:@selector(titleButtonClick) forControlEvents:UIControlEventTouchDown];
    
    self.navigationItem.titleView = self.titleBtn;
}

/**
 *  发送请求得到用户的info
 */
- (void)setupUserInfo {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"access_token"] = account.access_token;
    param[@"uid"] = account.uid;
    
    [manager GET:@"https://api.weibo.com/2/users/show.json" parameters:param success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        self.titleBtn.titleLabel.text = responseObject[@"name"];
        //修改模型
        account.name = responseObject[@"name"];
        //保存模型
        [WJAccountTool saveAccount:account];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        WJLog(@"-------GET_USERINFO_FAILSE-------%@", error);
    }];
}
/**
 *  点击了titleBtn 显示下拉菜单
 */
- (void)titleButtonClick {
    WJDropdownMenu *menu = [WJDropdownMenu menuWithSizeOfViewController:CGSizeMake(180, 300)];
    menu.delegate = self;
    
    //把控制器给传给contentController（strong） 所以这个控制器不会死亡
    WJTitleMenuTableViewController *vc = [[WJTitleMenuTableViewController alloc] init];
    vc.view.size = CGSizeMake(180, 300);
    menu.contentController = vc;
    
    
    if (!self.titleBtn.isSelected) {
        self.titleBtn.selected = YES;
        [menu showFrom:self.titleBtn];
        
    } else {
        self.titleBtn.selected = NO;
        [menu dismiss];
        
    }
}
/**
 *  当下拉菜单消失时 取消按钮的选中状态
 */
-(void)dropdownMenuDidDismiss {
    self.titleBtn.selected = NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - tableview代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statusArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WJStatusCell *cell = [WJStatusCell cellWithTableView:tableView];
   
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //设置模型
    WJStatus *status = self.statusArray[indexPath.row];
    
    cell.status = status;
    if (indexPath.row == self.statusArray.count - 1 && !self.noMore) {//说明是最后一个 加载更多 并显示那个footView
        [self loadMoreStatus];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.statusArray[indexPath.row] cellHeight];
}

@end
