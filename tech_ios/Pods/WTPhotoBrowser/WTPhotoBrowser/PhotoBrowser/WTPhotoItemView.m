//
//  WTPhotoItemCell.m
//  WTPhotoBrowser
//
//  Created by 王通 on 2017/4/18.
//  Copyright © 2017年 王通. All rights reserved.
//

#import "WTPhotoItemView.h"
#import "YYWebImage.h"
#import "WTPBConst.h"

@interface WTPhotoItemView ()<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;

@property (nonatomic, strong) UIImageView *imgVContent;

@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@end

@implementation WTPhotoItemView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setupView];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //
    self.scrollView.frame = self.bounds;
    self.imgVContent.frame = self.bounds;
}

- (void)setupView {
    self.contentView.backgroundColor = [UIColor blackColor];
    
    //
    [self addSubview:self.scrollView];
    
    //
    [self.scrollView addSubview:self.imgVContent];
    
    //
    UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionClose)];
    [self.imgVContent addGestureRecognizer:tapG];
}

- (void)actionClose {
    NSLog(@"界面关闭");
    if ([self.delegate respondsToSelector:@selector(actionClosePhotoBrowser)]) {
        [self.delegate actionClosePhotoBrowser];
    }
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imgVContent;
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view {
    //    NSLog(@"%s", __func__);
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    //    NSLog(@"%s", __func__);
    CGFloat Ws = self.scrollView.frame.size.width - self.scrollView.contentInset.left - self.scrollView.contentInset.right;
    CGFloat Hs = self.scrollView.frame.size.height - self.scrollView.contentInset.top - self.scrollView.contentInset.bottom;
    CGFloat W = self.imgVContent.frame.size.width;
    CGFloat H = self.imgVContent.frame.size.height;
    
    CGRect rct = self.imgVContent.frame;
    rct.origin.x = MAX((Ws-W)/2, 0);
    rct.origin.y = MAX((Hs-H)/2, 0);
    self.imgVContent.frame = rct;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //    NSLog(@"%s", __func__);
}

#pragma mark - getter & setter
- (void)setPhotoType:(NSInteger)photoType {
    _photoType = photoType;
    
    if (photoType == WTPBType_Url) {
        CGFloat width = 50;
        
        UIBezierPath *circle = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, width, width)];
        
        self.shapeLayer = [CAShapeLayer layer];
        self.shapeLayer.frame = CGRectMake(0, 0, width, width);
        self.shapeLayer.position = CGPointMake([UIScreen mainScreen].bounds.size.width / 2.0, [UIScreen mainScreen].bounds.size.height / 2.0);
        self.shapeLayer.fillColor = [UIColor clearColor].CGColor;
        self.shapeLayer.lineWidth = 10.f;
        self.shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
        self.shapeLayer.strokeStart = 0.f;
        self.shapeLayer.strokeEnd = 0.f;
        self.shapeLayer.lineCap = kCALineCapRound;
        self.shapeLayer.opacity = 0.7f;
        self.shapeLayer.path = circle.CGPath;
        self.shapeLayer.transform = CATransform3DRotate(self.shapeLayer.transform, -M_PI_2, 0, 0, 1);
        [self.imgVContent.layer addSublayer:self.shapeLayer];
    }
}

- (void)setImgLocal:(UIImage *)imgLocal {
    _imgLocal = imgLocal;
    
    if (imgLocal) {
        self.imgVContent.image = imgLocal;
    }
}

- (void)setStrImgUrl:(NSString *)strImgUrl {
    _strImgUrl = strImgUrl;
    
    if (strImgUrl) {
        UIImage *placeHolderImg = nil;
        if (self.imgPlaceHolder) {
            placeHolderImg = self.imgPlaceHolder;
        } else {
            placeHolderImg = [UIImage imageNamed:@"wt_pb_placeholder"];
        }
        
        [self.imgVContent yy_setImageWithURL:[NSURL URLWithString:strImgUrl] placeholder:placeHolderImg options:(YYWebImageOptionProgressiveBlur | YYWebImageOptionSetImageWithFadeAnimation) progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//            NSLog(@"%ld, %ld", receivedSize, expectedSize);
//            NSLog(@"%f", receivedSize / (expectedSize * 1.0));
            CGFloat rate = receivedSize / expectedSize;
            if (rate <= 1.0) {
                self.shapeLayer.strokeEnd = rate;
            }
        } transform:^UIImage * _Nullable(UIImage * _Nonnull image, NSURL * _Nonnull url) {
            return image;
        } completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
            self.shapeLayer.strokeEnd = 0.f;
        }];
    }
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.maximumZoomScale = 2.0;
        _scrollView.minimumZoomScale = 0.5;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}

- (UIImageView *)imgVContent {
    if (!_imgVContent) {
        _imgVContent = [[UIImageView alloc] init];
        _imgVContent.userInteractionEnabled = YES;
        _imgVContent.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imgVContent;
}

@end
