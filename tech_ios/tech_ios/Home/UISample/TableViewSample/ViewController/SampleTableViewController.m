//
//  SampleTableViewController.m
//  tech_ios
//
//  Created by peter on 2018/2/27.
//  Copyright © 2018年 peter. All rights reserved.
//

#import "SampleTableViewController.h"
#import "NewsCell.h"
#import "NewsHeader.h"

#define kCellId @"NewsCell"
#define kCellHeader @"NewsHeader"

@interface SampleTableViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,weak) IBOutlet UITableView* tableView;
@property (nonatomic,strong) NSMutableArray* arrItems;
@end

@implementation SampleTableViewController

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
    viewHeader.labelTitle.text = @"焦点";
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
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId forIndexPath:indexPath];
    cell.model = self.arrItems[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)configData {
    self.arrItems = [NSMutableArray arrayWithArray:@[@"第一则新闻",
                                                     @"新时代新气象，人们纷纷点赞现在的幸福生活，期盼在党的领导下，通过努力奋斗，创造更加美好的未来。马上就要召开全国两会了，百姓们的期待都是什么，今天我们继续来听。",
                                                     @"山东济南市中区综合行政执法局女子中队副中队长许淑华 ：期待是希望通过我们的工作，让业户包括群众都能理解我们、认同我们，我们共同创建美好的泉城。",
                                                     @"乌鲁木齐退休职工米加 ：“新一年，我想在咱们这个习近平主席领导下，咱们党的政策越来越好，确实是日子一年比一年好，我们就是说身体健健康康，要多活几年。",
                                                     @"江苏连云港市海州区江浦村村民赵祥余 ：“希望能借助乡村战略的东风，把我们的大棚建成一个旅游的大棚。城市来旅游的人，特别的多。旅游采摘的特别的多，我的菜不够采摘。”"]];
}
@end
