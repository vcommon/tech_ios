//
//  NavTechViewController.m
//  tech_ios
//
//  Created by peter on 2018/1/26.
//  Copyright © 2018年 peter. All rights reserved.
//

#import "NavTechViewController.h"
#import "tech_ios-Swift.h"

@interface NavTechViewController ()

@end

@implementation NavTechViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    if(self.titleText == nil){
//        self.titleText =  @"居中";
//    }
//    self.title = self.titleText;
//    [self addLeftBtn];
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

- (void)addLeftBtn {
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"左边" style:UIBarButtonItemStylePlain target:self action:@selector(clickLeftButton)];
//    self.navigationItem.leftBarButtonItem = leftButton;
    UIBarButtonItem *leftButton2 = [[UIBarButtonItem alloc] initWithTitle:@"左边2" style:UIBarButtonItemStylePlain target:self action:@selector(clickLeftButton)];
    self.navigationItem.leftBarButtonItems = @[leftButton,leftButton2,leftButton2];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"右边" style:UIBarButtonItemStylePlain target:self action:@selector(clickRightButton)];
    self.navigationItem.rightBarButtonItem = rightButton;
    //问题：点击进入一个新页面，返回的时候，该按钮有一层白色遮罩。一直处于高亮状态。
    //注意：必须使用self.title才起作用。
//    self.navigationController.navigationBar.titleTextAttributes = @{ NSForegroundColorAttributeName: [UIColor blueColor]};
    self.navigationController.navigationBar.tintColor = [UIColor blueColor];
    //问题：标题如果左边按钮和右边按钮不一致，会无法居中
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width-60, self.navigationController.navigationBar.frame.size.height)];
//    titleLabel.text = @"标题栏章节居中";
//    titleLabel.textColor = [UIColor blackColor];
//    titleLabel.textAlignment = UITextAlignmentCenter;
//    [titleLabel setAdjustsFontSizeToFitWidth:YES];
//    self.navigationItem.titleView = titleLabel;
    
    //小标题在标题上边，并且会增大标题栏的高度，不好
//    self.navigationItem.prompt = @"小标题";

}

- (void)clickLeftButton {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickRightButton {
    SwiftViewController* vc = [[SwiftViewController alloc]init];
//    vc.titleText = @"标题栏章节居中测试";
    [self.navigationController pushViewController:vc animated:YES];
}
@end
