//
//  LGEmptyView.m
//  haoshuimian365
//
//  Created by apple on 2017/6/21.
//  Copyright © 2017年 CYY. All rights reserved.
//

#import "LGEmptyView.h"
#import "MBProgressHUD.h"

#define viewWidth    self.bounds.size.width
#define viewHeight   self.bounds.size.height

@interface LGEmptyView()

@end

@implementation LGEmptyView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.lineSpace = 3;
        self.needBuffer = YES;
        self.margin = viewPix(5);
        [self addSubview:self.imageView];
        [self addSubview:self.contentLabel];
        [self addSubview:self.retryBtn];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_centerY).offset(self.offset);
            make.width.height.equalTo(@(viewPix(120)));
            make.centerX.equalTo(self);
        }];
        
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imageView.mas_bottom).offset(self.margin);
            make.width.equalTo(self).offset(-viewPix(50));
            make.centerX.equalTo(self);
        }];
    }
    return self;
}

-(void)setMargin:(CGFloat)margin{
    _margin = margin;
}

-(void)setLineSpace:(CGFloat)lineSpace{
    _lineSpace = lineSpace;
}

-(void)setNeedBuffer:(BOOL)needBuffer{
    _needBuffer = needBuffer;
}


-(void)showViewWithImage:(NSString *)imageName content:(NSString *)content offset:(CGFloat)offset{
    [MBProgressHUD hideHUDForView:self animated:YES];
    self.hidden = NO;
    self.contentLabel.text = content;
    [self.contentLabel lineSpacing:self.lineSpace];
    self.imageView.image = [UIImage imageNamed:imageName];
    CGSize imageSize = [UIImage imageNamed:imageName].size;//图片大小
    offset = (offset>0)?offset:self.offset;
    [self.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_centerY).offset(offset);
        make.width.equalTo(@(viewPix(imageSize.width)));
        make.height.equalTo(@(viewPix(imageSize.height)));
    }];
    [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom).offset(self.margin);
    }];
}

-(void)startBufferAction{
    [MBProgressHUD showHUDAddedTo:self animated:YES];
}

-(void)stopBufferAction{
    self.hidden = YES;
    [MBProgressHUD hideHUDForView:self animated:YES];
}

-(void)retryBtnAction{
    if ([self.delegate respondsToSelector:@selector(requestData)]) {
        [self.delegate requestData];
    }
    if (self.needBuffer == YES) {
        [MBProgressHUD showHUDAddedTo:self animated:YES];
    }
}

#pragma mark---懒加载+布局
-(UIImageView *)imageView{
    if(!_imageView){
        _imageView =  [[UIImageView alloc]init];
    }
    return _imageView;
}

-(UILabel *)contentLabel{
    if(!_contentLabel){
        _contentLabel = [UILabel lableWithText:nil colorString:@"#666666" textFont:LGFont(16) textAlignment:NSTextAlignmentCenter lines:0];
    }
    return _contentLabel;
}

-(UIButton *)retryBtn{
    if(!_retryBtn){
        _retryBtn = [UIButton  buttonWithType:UIButtonTypeCustom];
        _retryBtn.frame = CGRectMake(0, 0, viewWidth, viewHeight);
        _retryBtn.backgroundColor = [UIColor clearColor];
        [_retryBtn addTarget:self action:@selector(retryBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _retryBtn;
}


-(void)dealloc{
    self.delegate = nil;
}

@end
