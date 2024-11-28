//
//  LGCornerHeaderView.m
//  HeartDiseaseManage
//
//  Created by 1234 on 2023/2/16.
//  高度:viewPix(16)+15

#import "LGCornerHeaderView.h"
@implementation LGCornerHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.shadowView];
        [self.shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(self).offset(viewPix(16));
            make.right.equalTo(self).offset(-viewPix(16));
        }];
    }
    return self;
}

-(void)setTopMargin:(CGFloat)topMargin{
    _topMargin = topMargin;
    [self.shadowView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(topMargin);
    }];
}

-(UIView *)shadowView{
    if(!_shadowView){
        _shadowView = [UIView shadowViewWithColor:@"#B3C5D9" offset:CGSizeMake(0, 2) opacity:0.15 radius:10];
        _shadowView.backgroundColor = [UIColor whiteColor];
    }
    return _shadowView;
}

@end
