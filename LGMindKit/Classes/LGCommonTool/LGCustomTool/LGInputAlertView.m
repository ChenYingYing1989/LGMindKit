//
//  LGGroupInputNameView.m
//  HeartDiseaseManage
//
//  Created by 1234 on 2023/2/24.
//  填写分组名称

#import "LGInputAlertView.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "UIColor+LGExtension.h"
#import "Masonry.h"
@interface LGInputAlertView()

/**   */
@property (nonatomic , strong)UIView *baseView;
/**   */
@property (nonatomic , strong)UIButton *cancelBtn;
/**   */
@property (nonatomic , strong)UIButton *sureBtn;
/**   */
@property (nonatomic , strong)UILabel *titleLabel;
/**   */
@property (nonatomic , strong)UITextField *contentTF;
/**   */
@property (nonatomic , strong)UILabel *unitLabel;

@end

@implementation LGInputAlertView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
        self.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:0];
        [self addSubview:self.baseView];
        [self.baseView addSubview:self.cancelBtn];
        [self.baseView addSubview:self.titleLabel];
        [self.baseView addSubview:self.sureBtn];
        [self.baseView addSubview:self.contentTF];
        [self.contentTF addSubview:self.unitLabel];
        [self.contentTF becomeFirstResponder];
        [self.unitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentTF).offset(-viewPix(9));
            make.centerY.equalTo(self.contentTF);
        }];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

-(void)setUnit:(NSString *)unit{
    _unit = unit;
    self.unitLabel.text = unit;
}

-(void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = title;
}

-(void)setPlaceHolder:(NSString *)placeHolder{
    _placeHolder = placeHolder;
    self.contentTF.placeholder = placeHolder;
}

-(void)setKeyboardType:(UIKeyboardType)keyboardType{
    _keyboardType = keyboardType;
    self.contentTF.keyboardType = keyboardType;
}

-(void)keyboardWillShow:(NSNotification *)notification{
    NSInteger duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] integerValue];
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat height = keyboardFrame.size.height;
    [UIView animateWithDuration:duration animations:^{
        self.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:0.5];
        self.baseView.frame = CGRectMake(0, Screen_H-height-viewPix(125), Screen_W, viewPix(150));
    }];
}

-(void)keyboardWillHide:(NSNotification *)notification{
    NSInteger duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] integerValue];
    [UIView animateWithDuration:duration animations:^{
        self.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:0];
        self.baseView.frame = CGRectMake(0, Screen_H, Screen_W, viewPix(150));
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(void)actionButtonTouch:(UIButton *)sender{
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    if (sender == self.sureBtn) {
        NSString *content = [self.contentTF.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        if(content.length == 0){
            [TooltipView showMessage:self.placeHolder offset:-50];
            return;
        }else if (self.groupNameFinished){
            self.groupNameFinished(self.contentTF.text);
        }
    }
    [self.contentTF resignFirstResponder];
}


#pragma mark
#pragma mark ====> 创建控件

-(UIView *)baseView{
    if(!_baseView){
        _baseView = [[UIView alloc] initWithFrame:CGRectMake(0, Screen_H, Screen_W, viewPix(150))];
        _baseView.backgroundColor = [UIColor whiteColor];
        _baseView.cornerRidus = 15;
    }
    return _baseView;
}


-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [UILabel lableWithText:@"添加分组" colorString:@"#333333" textFont:LGFontWeight(16, UIFontWeightSemibold) textAlignment:NSTextAlignmentCenter lines:1];
        _titleLabel.frame = CGRectMake(viewPix(80), viewPix(15), Screen_W-viewPix(160), viewPix(30));
    }
    return _titleLabel;
}

-(UITextField *)contentTF{
    if(!_contentTF){
        _contentTF = [[UITextField alloc]initWithFrame:CGRectMake(viewPix(25), viewPix(63), Screen_W-viewPix(50), viewPix(35))];
        _contentTF.layer.borderColor = [UIColor colorWithHexString:@"#D9D9D9"].CGColor;
        _contentTF.layer.borderWidth = 0.5;
        _contentTF.tintColor = [UIColor colorWithHexString:@"#333333"];
        _contentTF.textColor = [UIColor colorWithHexString:@"#333333"];
        _contentTF.textAlignment = NSTextAlignmentCenter;
        _contentTF.placeholder = @"请输入分组名称";
        _contentTF.font = LGFont(16);
        _contentTF.cornerRidus = 5;
    }
    return _contentTF;
}

-(UILabel *)unitLabel{
    if(!_unitLabel){
        _unitLabel = [UILabel lableWithText:@"" colorString:@"#333333" textFont:LGFont(16) textAlignment:NSTextAlignmentRight lines:1];
    }
    return _unitLabel;
}

-(UIButton *)cancelBtn{
    if(!_cancelBtn){
        _cancelBtn = [UIButton buttonWithTitle:@"取消" titleFont:LGFontWeight(16, UIFontWeightSemibold) textColor:@"#999999" imageName:@""];
        _cancelBtn.frame = CGRectMake(viewPix(10), viewPix(15), viewPix(60), viewPix(30));
        [_cancelBtn addTarget:self action:@selector(actionButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

-(UIButton *)sureBtn{
    if(!_sureBtn){
        _sureBtn = [UIButton buttonWithTitle:@"确定" titleFont:LGFontWeight(16, UIFontWeightSemibold) textColor:@"#429BFF" imageName:@""];
        _sureBtn.frame = CGRectMake(Screen_W-viewPix(70), viewPix(15), viewPix(60), viewPix(30));
        [_sureBtn addTarget:self action:@selector(actionButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}

@end
