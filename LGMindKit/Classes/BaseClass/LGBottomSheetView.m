//
//  LGBottomSheetView.m
//  XieHeHeartDisease
//
//  Created by 1234 on 2024/6/20.
//

#import "LGBottomSheetView.h"
#import <Masonry/Masonry.h>
@interface LGBottomSheetView()<LGBottomButtonDelegate>
/**   */
@property (nonatomic , strong)UIButton *hiddenBtn;
/**   */
@property (nonatomic , strong)UILabel *titleLabel;
/**   */
@property (nonatomic , strong)UIButton *closeBtn;

@end

@implementation LGBottomSheetView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubView];
    }
    return self;
}

//无底部按钮
-(instancetype)initWithTitle:(NSString *)title baseHeight:(CGFloat)baseHeight{
    self = [super initWithFrame:CGRectMake(0, 0, Screen_W, Screen_H)];
    if (self) {
        [self createSubView];
        self.titleLabel.text = title;
        self.baseView.frame = CGRectMake(0, Screen_H, Screen_W, baseHeight+bottomSafeBarHeight/4.0);
        [self showViewAnimation];
    }
    return self;
}


//有底部按钮
-(instancetype)initWithTitle:(NSString *)title bottomBtn:(NSArray *)btnArray baseHeight:(CGFloat)baseHeight{
    self = [super initWithFrame:CGRectMake(0, 0, Screen_W, Screen_H)];
    if (self) {
        [self createSubView];
        self.titleLabel.text = title;
        self.baseView.frame = CGRectMake(0, Screen_H, Screen_W, baseHeight+bottomSafeBarHeight/4.0);
        self.buttonView.frame = CGRectMake(0, baseHeight-viewPix(20)-bottomSafeBarHeight/4.0-viewPix(60), Screen_W, viewPix(60));
        self.buttonView.itemArray = btnArray;
        [self.baseView addSubview:self.buttonView];
        [self showViewAnimation];
    }
    return self;
}

-(void)setBaseHeight:(CGFloat)baseHeight{
    _baseHeight = baseHeight;
    CGFloat top = (self.baseView.frame.origin.y<Screen_H)?self.baseView.frame.origin.y:Screen_H;
    self.baseView.frame = CGRectMake(0, top, Screen_W, baseHeight+bottomSafeBarHeight/4.0);
    if (_buttonView) {
        self.buttonView.frame = CGRectMake(0, baseHeight-viewPix(20)-bottomSafeBarHeight/4.0-viewPix(60), Screen_W, viewPix(60));
    }
}

//底部按钮点击事件
-(void)bottomButtonTouchedWithIndex:(NSInteger)index{
    if (self.bottomButtonSelect) {
        self.bottomButtonSelect(index);
    }
}



-(void)showViewAnimation{
    CGFloat baseHeight = self.baseView.bounds.size.height;
    [UIView animateWithDuration:0.4 animations:^{
        self.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:0.8];
        self.baseView.frame = CGRectMake(0, Screen_H-baseHeight+viewPix(20), Screen_W, baseHeight);
    }];
}

-(void)hiddenViewAnmation{
    CGFloat baseHeight = self.baseView.bounds.size.height;
    [UIView animateWithDuration:0.4 animations:^{
        self.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:0];
        self.baseView.frame = CGRectMake(0, Screen_H, Screen_W, baseHeight);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


#pragma mark
#pragma mark ====> 创建控件
-(void)createSubView{
    self.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:0];
    [self addSubview:self.hiddenBtn];
    [self addSubview:self.baseView];
    [self.baseView addSubview:self.titleLabel];
    [self.baseView addSubview:self.closeBtn];
    [self.hiddenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.bottom.equalTo(self.baseView.mas_top);
    }];
}

//点击空白区域 -- 收起弹框
-(UIButton *)hiddenBtn{
    if(!_hiddenBtn){
        _hiddenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_hiddenBtn addTarget:self action:@selector(hiddenViewAnmation) forControlEvents:UIControlEventTouchUpInside];
    }
    return _hiddenBtn;
}

-(UIView *)baseView{
    if(!_baseView){
        _baseView = [[UIView alloc]initWithFrame:CGRectMake(0, Screen_H, Screen_W, viewPix(490)+bottomSafeBarHeight/4.0)];
        _baseView.backgroundColor = [UIColor whiteColor];
        _baseView.cornerRidus = 15;
    }
    return _baseView;
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [UILabel lableWithText:@"标题" colorString:@"#282828" textFont:LGFontWeight(16, UIFontWeightMedium) textAlignment:NSTextAlignmentCenter lines:1];
        _titleLabel.frame = CGRectMake(viewPix(100), viewPix(20), Screen_W-viewPix(200), viewPix(20));
    }
    return _titleLabel;
}

-(UIButton *)closeBtn{
    if(!_closeBtn){
        _closeBtn = [UIButton buttonWithImage:@"closeGray16" frame:CGRectMake(Screen_W-viewPix(50), viewPix(10), viewPix(40), viewPix(40))];
        [_closeBtn addTarget:self action:@selector(hiddenViewAnmation) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

-(LGBottomButtonView *)buttonView{
    if(!_buttonView){
        _buttonView = [[LGBottomButtonView alloc]initWithFrame:CGRectMake(0, 0, Screen_W, viewPix(65))];
        _buttonView.delegate = self;
    }
    return _buttonView;
}


@end
