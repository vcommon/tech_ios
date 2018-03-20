//
//  WTPBConst.h
//  WTPhotoBrowser
//
//  Created by 王通 on 2017/4/19.
//  Copyright © 2017年 王通. All rights reserved.
//

#import <Foundation/Foundation.h>

#define WT_PB_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define WT_PB_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

/**
 图片类型
 
 - WTPBType_Local: 本地图片
 - WTPBType_Url: 网络图片
 */
typedef NS_ENUM(NSUInteger, WTPBType) {
    WTPBType_Local,
    WTPBType_Url
};

@interface WTPBConst : NSObject

@end
