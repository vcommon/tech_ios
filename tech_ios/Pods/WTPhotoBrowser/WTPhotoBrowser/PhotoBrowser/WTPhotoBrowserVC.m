//
//  FirstViewController.m
//  WTPhotoBrowser
//
//  Created by 王通 on 2017/4/18.
//  Copyright © 2017年 王通. All rights reserved.
//

#import "WTPhotoBrowserVC.h"
#import "WTPhotoItemView.h"
#import "WTPBConst.h"
#import "SDAutoLayout.h"

@interface WTPhotoBrowserVC ()<UIScrollViewDelegate, WTPhotoItemViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollViewBg;

@property (nonatomic, assign) NSInteger countImgs;

@property (strong, nonatomic) UILabel *labelCount;

@property (nonatomic, assign) WTPBType photoType;

@end

@implementation WTPhotoBrowserVC

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configBaseData];
    [self setupView];
    [self setupScrollViewBig];
    [self setupLablelCountWithIndex:self.indexSelectedImg];
}

- (void)setupView {
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    //
    self.scrollViewBg.frame = CGRectMake(0, 0, WT_PB_SCREEN_WIDTH, WT_PB_SCREEN_HEIGHT);
    self.scrollViewBg.contentSize = CGSizeMake(WT_PB_SCREEN_WIDTH * self.countImgs, WT_PB_SCREEN_HEIGHT);
    //
    self.scrollViewBg.contentOffset = CGPointMake(self.indexSelectedImg * WT_PB_SCREEN_WIDTH, 0);
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (void)configBaseData {
    if (self.mArrLocalImgs) {
        self.photoType = WTPBType_Local;
    } else if (self.mArrUrlImgs) {
        self.photoType = WTPBType_Url;
    } else {
        self.photoType = WTPBType_Local;
    }
}

- (void)setupScrollViewBig {
    //
    [self.view addSubview:self.scrollViewBg];
    
    //
    [self.view addSubview:self.labelCount];
    self.labelCount.sd_layout
    .centerXEqualToView(self.view)
    .widthIs(60)
    .bottomSpaceToView(self.view, 15)
    .heightIs(25);
    
    //
    if (self.photoType == WTPBType_Local) {
        self.countImgs = self.mArrLocalImgs.count;
    } else if (self.photoType == WTPBType_Url) {//网络图片
        self.countImgs = self.mArrUrlImgs.count;   
    }
    //
    for (int i = 0; i < self.countImgs; i++) {
        WTPhotoItemView *iView = [[WTPhotoItemView alloc] initWithFrame:CGRectMake(WT_PB_SCREEN_WIDTH * i, 0, WT_PB_SCREEN_WIDTH, WT_PB_SCREEN_HEIGHT)];
        iView.delegate = self;
        if (self.imgPlaceHolder) {
            iView.imgPlaceHolder = self.imgPlaceHolder;
        }
        if (self.photoType == WTPBType_Local) {
            iView.imgLocal = self.mArrLocalImgs[i];
            iView.photoType = WTPBType_Local;
        } else if (self.photoType == WTPBType_Url) {
            iView.strImgUrl = self.mArrUrlImgs[i];
            iView.photoType = WTPBType_Url;
        }
        [self.scrollViewBg addSubview:iView];
    }
    //
    self.scrollViewBg.contentOffset = CGPointMake(self.indexSelectedImg * WT_PB_SCREEN_WIDTH, 0);
}

- (void)setupLablelCountWithIndex:(NSInteger)index {
    self.labelCount.text = [NSString stringWithFormat:@"%ld/%ld", (long)index + 1, (long)self.countImgs];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / WT_PB_SCREEN_WIDTH;
    [self setupLablelCountWithIndex:index];
}

#pragma mark - WTPhotoItemViewDelegate
- (void)actionClosePhotoBrowser {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - action
- (void)show {
    if (self.mArrLocalImgs || self.mArrUrlImgs) {
        if (self.sourceVC) {
            [self.sourceVC presentViewController:self animated:YES completion:^{
                
            }];
        } else {
            NSLog(@"没有提供目标视图控制器");
        }
    } else {
        NSLog(@"没有提供可供阅览的图片数组");
    }
}

- (void)show:(UIViewController *)sourceVC {
    [sourceVC presentViewController:self animated:YES completion:^{
        
    }];
}

#pragma mark - getter * setter
- (UIScrollView *)scrollViewBg {
    if (!_scrollViewBg) {
        _scrollViewBg = [[UIScrollView alloc] init];
        _scrollViewBg.delegate = self;
        _scrollViewBg.backgroundColor = [UIColor blackColor];
        _scrollViewBg.pagingEnabled = YES;
        _scrollViewBg.showsVerticalScrollIndicator = NO;
        _scrollViewBg.showsHorizontalScrollIndicator = NO;
    }
    return _scrollViewBg;
}

- (UILabel *)labelCount {
    if (!_labelCount) {
        _labelCount = [[UILabel alloc] init];
        _labelCount.font = [UIFont boldSystemFontOfSize:14];
        _labelCount.textColor = [UIColor whiteColor];
    }
    return _labelCount;
}

@end
