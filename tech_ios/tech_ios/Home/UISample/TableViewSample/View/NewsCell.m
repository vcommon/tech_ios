//
//  NewsCell.m
//  tech_ios
//
//  Created by peter on 2018/2/28.
//  Copyright © 2018年 peter. All rights reserved.
//

#import "NewsCell.h"

@interface NewsCell()
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelContent;

@end

@implementation NewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(NSString *)model {
    _model = model;
    self.labelContent.text = model;
}
@end
