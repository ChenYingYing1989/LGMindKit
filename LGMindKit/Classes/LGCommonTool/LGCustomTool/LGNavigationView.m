//
//  LGNavigationView.m
//  HyperactivityPatient
//
//  Created by mac on 2021/3/24.
//

#import "LGNavigationView.h"
#import "UIColor+LGExtension.h"
@implementation LGNavigationView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.backBtn];
        [self addSubview:self.titleLabel];
        [self addSubview:self.rightBtn];
        self.backgroundColor = [UIColor colorWithHexString:@"#E5F1FF"];
    }
    return self;
}

-(void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = title;
}

-(void)setType:(LGNavigationType)type{
    _type = type;
    if (type == LGNavigationTypeDark) {
        self.titleLabel.textColor = kNavTitleColor;
        [self.backBtn setImage:kNavBackImage forState:UIControlStateNormal];
        [self.backBtn setImage:kNavBackImage forState:UIControlStateHighlighted];
    }else{
        self.titleLabel.textColor = kNavTitleColorWhite;
        [self.backBtn setImage:kNavBackImageWhite forState:UIControlStateNormal];
        [self.backBtn setImage:kNavBackImageWhite forState:UIControlStateHighlighted];
    }
}

-(UIButton *)backBtn{
    if(!_backBtn){
        _backBtn= [UIButton buttonWithType:UIButtonTypeCustom];
        _backBtn.frame = CGRectMake(5, statusBarHeight, 44, 44);
        [_backBtn setImage:kNavBackImage forState:UIControlStateNormal];
        [_backBtn setImage:kNavBackImage forState:UIControlStateHighlighted];
    }
    return _backBtn;
}

-(UIButton *)rightBtn{
    if(!_rightBtn){
        _rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _rightBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
        _rightBtn.frame = CGRectMake(Screen_W-150, statusBarHeight, 144, 44);
    }
    return _rightBtn;
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel =  [UILabel lableWithText:@"" colorString:@"2C2C2C" textFont:kNavTitleFont textAlignment:NSTextAlignmentCenter lines:1];
        _titleLabel.frame = CGRectMake(60, statusBarHeight, Screen_W-120, 44);
    }
    return _titleLabel;
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
