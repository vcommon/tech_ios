//
//  SampleTableViewController.m
//  tech_ios
//
//  Created by peter on 2018/2/27.
//  Copyright © 2018年 peter. All rights reserved.
//

#import "SampleListViewController.h"
#import "NewsCell.h"
#import "NewsHeader.h"
#import "SampleTableViewController.h"
#import "SamplePullToRefreshViewController.h"

#define kCellId @"NewsCell"
#define kCellHeader @"NewsHeader"

@interface SampleListViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,weak) IBOutlet UITableView* tableView;
@property (nonatomic,strong) NSMutableArray* arrItems;
@end

@implementation SampleListViewController

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
    [self.tableView registerNib:[UINib nibWithNibName:kCellId bundle:nil] forCellReuseIdentifier:kCellId];
    [self.tableView registerNib:[UINib nibWithNibName:kCellHeader bundle:nil] forHeaderFooterViewReuseIdentifier:kCellHeader];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [NewsHeader getViewHeight];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString *iden = kCellHeader;
    NewsHeader *viewHeader = [tableView dequeueReusableHeaderFooterViewWithIdentifier:iden];
    if (!viewHeader) {
        viewHeader = [[NewsHeader alloc] initWithReuseIdentifier:iden];
    }
    viewHeader.labelTitle.text = @"演示";
    return viewHeader;
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
    static NSString* resuseId = kCellId;
    UITableViewCell* cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:resuseId];
    cell.textLabel.textColor = [UIColor colorWithRed:0.33f green:0.33f blue:0.33f alpha:1.0f];
    cell.textLabel.text = self.arrItems[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row == 0){
        SampleTableViewController* vc = [[SampleTableViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if(indexPath.row == 1) {
        SamplePullToRefreshViewController* vc = [[SamplePullToRefreshViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)configData {
    self.arrItems = [NSMutableArray arrayWithArray:@[@"列表",@"下拉刷新",@"空白列表"]];
}
@end
