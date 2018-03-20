//
//  NewsHeader.h
//  tech_ios
//
//  Created by peter on 2018/2/28.
//  Copyright © 2018年 peter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsHeader : UITableViewHeaderFooterView

@property (nonatomic,strong) IBOutlet UILabel* labelTitle;

+ (float)getViewHeight;
@end
