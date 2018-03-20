//
//  WTPhotoItemCell.h
//  WTPhotoBrowser
//
//  Created by 王通 on 2017/4/18.
//  Copyright © 2017年 王通. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WTPhotoItemViewDelegate <NSObject>

/**
 关闭 图片浏览器
 */
- (void)actionClosePhotoBrowser;

@end

@interface WTPhotoItemView : UICollectionViewCell

@property (nonatomic, strong) UIImage *imgLocal;

@property (nonatomic, strong) NSString *strImgUrl;

@property (nonatomic, assign) NSInteger photoType;

@property (nonatomic, strong) UIImage *imgPlaceHolder;

@property (nonatomic, assign) id<WTPhotoItemViewDelegate> delegate;

@end
