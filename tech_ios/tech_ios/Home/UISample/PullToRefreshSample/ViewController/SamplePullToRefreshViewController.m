//
//  SamplePullToRefreshViewController.m
//  tech_ios
//
//  Created by peter on 2018/2/28.
//  Copyright © 2018年 peter. All rights reserved.
//

#import "SamplePullToRefreshViewController.h"
#import "MJRefresh.h"

#define WEAKSELF typeof(self) __weak weakSelf = self;

@interface SamplePullToRefreshViewController ()

@property (nonatomic,weak) IBOutlet UITableView* tableView;
@property (nonatomic,strong) IBOutlet MJRefreshNormalHeader* mjHeader;
@property (nonatomic,strong) IBOutlet MJRefreshAutoNormalFooter* mjFooter;

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger pageSize;


@property (nonatomic,strong) NSMutableArray* arrItems;

@end

@implementation SamplePullToRefreshViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configData];
    [self setupView];
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

- (void)setupView {
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.mj_header = self.mjHeader;
    self.tableView.mj_footer = self.mjFooter;
    [self.tableView.mj_header beginRefreshing];
}

- (MJRefreshNormalHeader*)mjHeader {
    WEAKSELF
    if(_mjHeader == nil) {
        _mjHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weakSelf.page = 0;
            [weakSelf getPageData];
        }];
    }
    return _mjHeader;
}

- (MJRefreshAutoNormalFooter*)mjFooter {
    WEAKSELF
    if(_mjFooter == nil) {
        _mjFooter = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            weakSelf.page++;
            [weakSelf getPageData];
        }];
    }
    return _mjFooter;
}

- (void)configData {
    
}

- (void)getPageData {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.arrItems removeAllObjects];
        
            for(int i=0;i<(self.page+1)*20;i++){
                [self.arrItems addObject:[NSString stringWithFormat:@"%d",i]];
            }
            if([self.tableView.mj_header isRefreshing]){
                [self.tableView.mj_header endRefreshing];
            }
            
            if([self.tableView.mj_footer isRefreshing]){
                [self.tableView.mj_footer endRefreshing];
            }
            
            if(self.page == 0){
                 [self.tableView.mj_footer resetNoMoreData];
            }else if(self.page > 20) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            [self.tableView reloadData];
        });
    });
}

- (NSMutableArray*)arrItems {
    if(_arrItems == nil) {
        _arrItems = [[NSMutableArray alloc]init];
    }
    return _arrItems;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* resuseId = @"resueId";
    UITableViewCell* cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:resuseId];
    cell.textLabel.textColor = [UIColor colorWithRed:0.33f green:0.33f blue:0.33f alpha:1.0f];
    cell.textLabel.text = self.arrItems[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}
@end
