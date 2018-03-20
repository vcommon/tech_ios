//
//  FirstViewController.h
//  WTPhotoBrowser
//
//  Created by 王通 on 2017/4/18.
//  Copyright © 2017年 王通. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 图片浏览器
 */
@interface WTPhotoBrowserVC : UIViewController

/**
 本地图片
 */
@property (nonatomic, strong) NSMutableArray<UIImage *> *mArrLocalImgs;

/**
 服务器图片
 */
@property (nonatomic, strong) NSMutableArray<NSString *> *mArrUrlImgs;

/**
 选中的图片下标
 */
@property (nonatomic, assign) NSInteger indexSelectedImg;

/**
 占位图片
 */
@property (nonatomic, strong) UIImage *imgPlaceHolder;

/**
 目标视图控制器
 */
@property (nonatomic, strong) UIViewController *sourceVC;

/**
 显示图片浏览器
 */
- (void)show;

@end
