//
//  LGCornerFooterView.m
//  HeartDiseaseManage
//
//  Created by 1234 on 2023/2/16.
//  高度:viewPix(16)+15

#import "LGCornerFooterView.h"

@interface LGCornerFooterView()

@end

@implementation LGCornerFooterView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.shadowView];
        [self.shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(viewPix(16));
            make.right.top.bottom.equalTo(self).offset(-viewPix(16));
        }];
    }
    return self;
}

-(void)setBottomMargin:(CGFloat)bottomMargin{
    _bottomMargin = bottomMargin;
    [self.shadowView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-bottomMargin);
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
