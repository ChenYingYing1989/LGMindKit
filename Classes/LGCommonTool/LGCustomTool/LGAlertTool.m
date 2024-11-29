//
//  LGAlertTool.m
//  LGSanofiPatient
//
//  Created by 1234 on 2022/10/9.
//

#import "LGAlertTool.h"

@implementation LGAlertTool

+(void)alertWithTitle:(NSString *)title content:(NSString *)content sureAction:(void(^)(void))action{
    LGAlertView *alertView = [[LGAlertView alloc]initWithFrame:CGRectMake(0, 0, Screen_W, Screen_H)];
    alertView.titleLabel.font = LGFontWeight(18, UIFontWeightSemibold);
    alertView.titleLabel.text = title;
    alertView.contentLabel.text = content;
    alertView.sureAction = ^{
        if (action) {
            action();
        }
    };
    [[UIApplication sharedApplication].keyWindow addSubview:alertView];
}

+(void)alertWithTitle:(NSString *)title content:(NSString *)content sureTitle:(NSString *)sureTitle sureAction:(void(^)(void))action{
    LGAlertView *alertView = [[LGAlertView alloc]initWithFrame:CGRectMake(0, 0, Screen_W, Screen_H)];
    [alertView.sureBtn setTitle:sureTitle forState:UIControlStateNormal];
    alertView.titleLabel.font = LGFontWeight(18, UIFontWeightSemibold);
    alertView.titleLabel.text = title;
    alertView.contentLabel.text = content;
    alertView.sureAction = ^{
        if (action) {
            action();
        }
    };
    [[UIApplication sharedApplication].keyWindow addSubview:alertView];
}

+(void)alertWithTitle:(NSString *)title sureAction:(void(^)(void))action{
    LGAlertView *alertView = [[LGAlertView alloc]initWithFrame:CGRectMake(0, 0, Screen_W, Screen_H)];
    alertView.titleLabel.font = LGFontWeight(18, UIFontWeightMedium);
    alertView.titleLabel.text = title;
    [alertView.titleLabel lineSpacing:3];
    alertView.sureAction = ^{
        if (action) {
            action();
        }
    };
    [[UIApplication sharedApplication].keyWindow addSubview:alertView];
}

+(void)singleActionAlertWithTitle:(NSString *)title sureAction:(void(^)(void))action{
    LGSigleAlertView *alertView = [[LGSigleAlertView alloc]initWithFrame:CGRectMake(0, 0, Screen_W, Screen_H)];
    alertView.titleLabel.font = LGFontWeight(18, UIFontWeightMedium);
    alertView.titleLabel.text = title;
    [alertView.titleLabel lineSpacing:3];
    alertView.sureAction = ^{
        if (action) {
            action();
        }
    };
    [[UIApplication sharedApplication].keyWindow addSubview:alertView];
}

+(void)closeAlertWithTitle:(NSString *)title content:(NSString *)content sureTitle:(NSString *)sureTitle sureAction:(void(^)(void))action{
    LGCloseAlertView *alertView = [[LGCloseAlertView alloc]initWithFrame:CGRectMake(0, 0, Screen_W, Screen_H)];
    [alertView.sureBtn setTitle:sureTitle forState:UIControlStateNormal];
    alertView.titleLabel.text = title;
    alertView.contentLabel.text = content;
    [alertView.contentLabel lineSpacing:5];
    alertView.sureAction = ^{
        if (action) {
            action();
        }
    };
    [[UIApplication sharedApplication].keyWindow addSubview:alertView];
}


+(void)alertWithTitle:(NSString *)title attrbutContent:(NSMutableAttributedString *)content sureAction:(void(^)(void))action{
    LGAlertView *alertView = [[LGAlertView alloc]initWithFrame:CGRectMake(0, 0, Screen_W, Screen_H)];
    alertView.titleLabel.font = LGFontWeight(18, UIFontWeightSemibold);
    alertView.titleLabel.text = title;
    alertView.contentLabel.attributedText = content;
    alertView.sureAction = ^{
        if (action) {
            action();
        }
    };
    [[UIApplication sharedApplication].keyWindow addSubview:alertView];
}

+(void)singleActionAlertWithTitle:(NSString *)title attrbutContent:(NSMutableAttributedString *)content sureAction:(void(^)(void))action{
    LGSigleAlertView *alertView = [[LGSigleAlertView alloc]initWithFrame:CGRectMake(0, 0, Screen_W, Screen_H)];
    alertView.titleLabel.font = LGFontWeight(18, UIFontWeightSemibold);
    alertView.titleLabel.text = title;
    alertView.contentLabel.attributedText = content;
    alertView.sureAction = ^{
        if (action) {
            action();
        }
    };
    [[UIApplication sharedApplication].keyWindow addSubview:alertView];
}

@end


#pragma mark
#pragma mark ====> LGAlertView

@interface LGAlertView()
/**   */
@property (nonatomic , strong)UIView *baseView;
/**   */
@property (nonatomic , strong)UIView *lineView_H;
/**   */
@property (nonatomic , strong)UIView *lineView_V;
/**   */
@property (nonatomic , strong)UIButton *cancelBtn;

@end

@implementation LGAlertView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubView];
        [self showAnimation];
    }
    return self;
}

-(void)actionButtonTouch:(UIButton *)sender{
    [self removeAnimation];
    if (sender == self.sureBtn) {
        if (self.sureAction) {
            self.sureAction();
        }
    }
}

-(void)showAnimation{
    [UIView animateWithDuration:0.4 animations:^{
        self.backgroundColor = [UIColor colorWithHexString:@"#0D0D0D" alpha:0.7];
        self.baseView.transform = CGAffineTransformScale(self.baseView.transform, 1000, 1000);
    }];
}

-(void)removeAnimation{
    [UIView animateWithDuration:0.4 animations:^{
        self.backgroundColor = [UIColor colorWithHexString:@"#0D0D0D" alpha:0];
        self.baseView.transform = CGAffineTransformScale(self.baseView.transform, 0.001, 0.001);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


#pragma mark ====> 创建控件
-(void)createSubView{
    self.backgroundColor = [UIColor colorWithHexString:@"#0D0D0D" alpha:0];
    [self addSubview:self.baseView];
    [self.baseView addSubview:self.titleLabel];
    [self.baseView addSubview:self.contentLabel];
    [self.baseView addSubview:self.lineView_H];
    [self.baseView addSubview:self.lineView_V];
    [self.baseView addSubview:self.cancelBtn];
    [self.baseView addSubview:self.sureBtn];
    [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self);
        make.width.equalTo(@(viewPix(320)));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView).offset(viewPix(27));
        make.left.equalTo(self.baseView).offset(viewPix(25));
        make.right.equalTo(self.baseView).offset(-viewPix(25));
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(viewPix(16));
        make.left.right.equalTo(self.titleLabel);
        make.bottom.equalTo(self.lineView_H.mas_top).offset(-viewPix(30));
    }];
    
    [self.lineView_H mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.baseView);
        make.bottom.equalTo(self.baseView).offset(-viewPix(55));
        make.height.equalTo(@(1));
    }];
    
    [self.lineView_V mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView_H.mas_bottom);
        make.bottom.equalTo(self.baseView);
        make.centerX.equalTo(self.baseView);
        make.width.equalTo(@(1));
    }];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView_H.mas_bottom);
        make.right.equalTo(self.lineView_V.mas_left);
        make.left.bottom.equalTo(self.baseView);
    }];
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lineView_V.mas_right);
        make.right.bottom.equalTo(self.baseView);
        make.top.equalTo(self.cancelBtn);
    }];
}
-(UIView *)baseView{
    if(!_baseView){
        _baseView = [[UIView alloc]init];//WithFrame:CGRectMake((Screen_W-viewPix(290))/2.0, (Screen_H-viewPix(154))/2.0, viewPix(290), viewPix(154))
        _baseView.transform = CGAffineTransformScale(_baseView.transform, 0.001, 0.001);
        _baseView.backgroundColor = [UIColor whiteColor];
        _baseView.cornerRidus = 20;
    }
    return _baseView;
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [UILabel lableWithText:@"" colorString:@"#333333" textFont:LGFontWeight(18, UIFontWeightSemibold) textAlignment:NSTextAlignmentCenter lines:3];
    }
    return _titleLabel;
}

-(UILabel *)contentLabel{
    if(!_contentLabel){
        _contentLabel = [UILabel lableWithText:@"" colorString:@"#333333" textFont:LGFont(16) textAlignment:NSTextAlignmentLeft lines:0];
    }
    return _contentLabel;
}

-(UIView *)lineView_H{
    if(!_lineView_H){
        _lineView_H = [[UIView alloc]init];
        _lineView_H.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
    }
    return _lineView_H;
}

-(UIView *)lineView_V{
    if(!_lineView_V){
        _lineView_V = [[UIView alloc]init];
        _lineView_V.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
    }
    return _lineView_V;
}

-(UIButton *)cancelBtn{
    if(!_cancelBtn){
        _cancelBtn = [UIButton buttonWithTitle:@"取消" titleFont:LGFont(17) textColor:@"#333333" imageName:@""];
        [_cancelBtn addTarget:self action:@selector(actionButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

-(UIButton *)sureBtn{
    if(!_sureBtn){
        _sureBtn = [UIButton buttonWithTitle:@"确定" titleFont:LGFontWeight(17, UIFontWeightMedium) textColor:@"#5E8EF5" imageName:@""];
        [_sureBtn addTarget:self action:@selector(actionButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}

@end



#pragma mark
#pragma mark ====> LGSigleAlertView
@interface LGSigleAlertView()
/**   */
@property (nonatomic , strong)UIView *baseView;
/**   */
@property (nonatomic , strong)UIView *lineView_H;
/**   */
@property (nonatomic , strong)UIButton *sureBtn;

@end

@implementation LGSigleAlertView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubView];
        [self showAnimation];
    }
    return self;
}

-(void)actionButtonTouch:(UIButton *)sender{
    [self removeAnimation];
    if (sender == self.sureBtn) {
        if (self.sureAction) {
            self.sureAction();
        }
    }
}

-(void)showAnimation{
    [UIView animateWithDuration:0.4 animations:^{
        self.backgroundColor = [UIColor colorWithHexString:@"#0D0D0D" alpha:0.7];
        self.baseView.transform = CGAffineTransformScale(self.baseView.transform, 1000, 1000);
    }];
}

-(void)removeAnimation{
    [UIView animateWithDuration:0.4 animations:^{
        self.backgroundColor = [UIColor colorWithHexString:@"#0D0D0D" alpha:0];
        self.baseView.transform = CGAffineTransformScale(self.baseView.transform, 0.001, 0.001);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


#pragma mark ====> 创建控件
-(void)createSubView{
    self.backgroundColor = [UIColor colorWithHexString:@"#0D0D0D" alpha:0];
    [self addSubview:self.baseView];
    [self.baseView addSubview:self.titleLabel];
    [self.baseView addSubview:self.contentLabel];
    [self.baseView addSubview:self.lineView_H];
    [self.baseView addSubview:self.sureBtn];
    [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self);
        make.width.equalTo(@(viewPix(290)));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView).offset(viewPix(26));
        make.left.equalTo(self.baseView).offset(viewPix(29));
        make.right.equalTo(self.baseView).offset(-viewPix(29));
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(viewPix(7));
        make.left.right.equalTo(self.titleLabel);
        make.bottom.equalTo(self.lineView_H.mas_top).offset(-viewPix(25));
    }];
    
    [self.lineView_H mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.baseView);
        make.bottom.equalTo(self.baseView).offset(-viewPix(50));
        make.height.equalTo(@(1));
    }];

    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.baseView);
        make.top.equalTo(self.lineView_H.mas_bottom);
    }];
}
-(UIView *)baseView{
    if(!_baseView){
        _baseView = [[UIView alloc]init];//WithFrame:CGRectMake((Screen_W-viewPix(290))/2.0, (Screen_H-viewPix(154))/2.0, viewPix(290), viewPix(154))
        _baseView.transform = CGAffineTransformScale(_baseView.transform, 0.001, 0.001);
        _baseView.backgroundColor = [UIColor whiteColor];
        _baseView.cornerRidus = 20;
    }
    return _baseView;
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [UILabel lableWithText:@"" colorString:@"#2B2A37" textFont:LGFontWeight(18, UIFontWeightMedium) textAlignment:NSTextAlignmentCenter lines:3];
    }
    return _titleLabel;
}

-(UILabel *)contentLabel{
    if(!_contentLabel){
        _contentLabel = [UILabel lableWithText:@"" colorString:@"#61616D" textFont:LGFont(14) textAlignment:NSTextAlignmentCenter lines:0];
    }
    return _contentLabel;
}

-(UIView *)lineView_H{
    if(!_lineView_H){
        _lineView_H = [[UIView alloc]init];
        _lineView_H.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
    }
    return _lineView_H;
}

-(UIButton *)sureBtn{
    if(!_sureBtn){
        _sureBtn = [UIButton buttonWithTitle:@"确定" titleFont:LGFontWeight(16, UIFontWeightMedium) textColor:@"#5E8EF5" imageName:@""];
        [_sureBtn addTarget:self action:@selector(actionButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}

@end

#pragma mark
#pragma mark ====> LGCloseAlertView

@interface LGCloseAlertView()
/**   */
@property (nonatomic , strong)UIView *baseView;
/**   */
@property (nonatomic , strong)UIButton *closeBtn;

@end

@implementation LGCloseAlertView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubView];
        [self showAnimation];
    }
    return self;
}

-(void)actionButtonTouch:(UIButton *)sender{
    [self removeAnimation];
    if (sender == self.sureBtn) {
        if (self.sureAction) {
            self.sureAction();
        }
    }
}

-(void)showAnimation{
    [UIView animateWithDuration:0.4 animations:^{
        self.backgroundColor = [UIColor colorWithHexString:@"#0D0D0D" alpha:0.7];
        self.baseView.transform = CGAffineTransformScale(self.baseView.transform, 1000, 1000);
    }];
}

-(void)removeAnimation{
    [UIView animateWithDuration:0.4 animations:^{
        self.backgroundColor = [UIColor colorWithHexString:@"#0D0D0D" alpha:0];
        self.baseView.transform = CGAffineTransformScale(self.baseView.transform, 0.001, 0.001);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

//关闭
-(void)closeBtnAction{
    
}

#pragma mark ====> 创建控件
-(void)createSubView{
    self.backgroundColor = [UIColor colorWithHexString:@"#0D0D0D" alpha:0];
    [self addSubview:self.baseView];
    [self.baseView addSubview:self.titleLabel];
    [self.baseView addSubview:self.contentLabel];
    [self.baseView addSubview:self.sureBtn];
    [self.baseView addSubview:self.closeBtn];
    [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self);
        make.width.equalTo(@(viewPix(290)));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView).offset(viewPix(24));
        make.left.equalTo(self.baseView).offset(viewPix(29));
        make.right.equalTo(self.baseView).offset(-viewPix(29));
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(viewPix(20));
        make.left.right.equalTo(self.titleLabel);
        make.bottom.equalTo(self.baseView).offset(-viewPix(95));
    }];
    
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(viewPix(48)));
        make.left.equalTo(self.baseView).offset(viewPix(24));
        make.right.equalTo(self.baseView).offset(-viewPix(24));
        make.bottom.equalTo(self.baseView).offset(-viewPix(20));
    }];
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.baseView).offset(-viewPix(5));
        make.centerY.equalTo(self.titleLabel);
        make.width.height.equalTo(@(viewPix(40)));
    }];
}
-(UIView *)baseView{
    if(!_baseView){
        _baseView = [[UIView alloc]init];//WithFrame:CGRectMake((Screen_W-viewPix(290))/2.0, (Screen_H-viewPix(154))/2.0, viewPix(290), viewPix(154))
        _baseView.transform = CGAffineTransformScale(_baseView.transform, 0.001, 0.001);
        _baseView.backgroundColor = [UIColor whiteColor];
        _baseView.cornerRidus = 20;
    }
    return _baseView;
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [UILabel lableWithText:@"" colorString:@"#333333" textFont:LGFontWeight(17, UIFontWeightMedium) textAlignment:NSTextAlignmentCenter lines:3];
    }
    return _titleLabel;
}

-(UILabel *)contentLabel{
    if(!_contentLabel){
        _contentLabel = [UILabel lableWithText:@"" colorString:@"#61616D" textFont:LGFont(16) textAlignment:NSTextAlignmentCenter lines:2];
    }
    return _contentLabel;
}

-(UIButton *)sureBtn{
    if(!_sureBtn){
        _sureBtn = [UIButton buttonWithTitle:@"确定" titleFont:LGFontWeight(16, UIFontWeightMedium) textColor:@"#FFFFFF" imageName:@""];
        [_sureBtn addTarget:self action:@selector(actionButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
        _sureBtn.backgroundColor = [UIColor colorWithHexString:@"#5E8EF5"];
        _sureBtn.cornerRidus = 10;
    }
    return _sureBtn;
}

-(UIButton *)closeBtn{
    if(!_closeBtn){
        _closeBtn = [UIButton buttonWithImage:@"closeGray16" selectImage:@"closeGray16"];
        [_closeBtn addTarget:self action:@selector(removeAnimation) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}
@end
