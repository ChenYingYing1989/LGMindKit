//
//  LGShadowViewCell.m
//  BreathTrainingTool
//
//  Created by 1234 on 2024/6/5.
//  边距16 、 带阴影 、 卡片式Cell

#import "LGTableViewCardCell.h"
#import "HeaderFile.h"
#import "Masonry.h"

@interface LGTableViewCardCell()

@end

@implementation LGTableViewCardCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.baseView];
        [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(0);
            make.left.equalTo(self.contentView).offset(viewPix(16));
            make.right.equalTo(self.contentView).offset(-viewPix(16));
            make.bottom.equalTo(self.contentView).offset(0);
        }];
    }
    return  self;
}

-(void)setType:(LGPositionType)type{
    _type = type;
    if(type == LGPositionTypeTop){
        //第一个
        self.baseView.cornerRidus = 15;
        [self.baseView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(viewPix(8));
            make.bottom.equalTo(self.contentView).offset(16);
        }];
        
    }else if (type == LGPositionTypeMiddle){
        //中间
        self.baseView.cornerRidus = 0;
        [self.baseView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(-1);
            make.bottom.equalTo(self.contentView).offset(1);
        }];
        
    }else if (type == LGPositionTypeBottom){
        //底部
        self.baseView.cornerRidus = 15;
        [self.baseView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(-16);
            make.bottom.equalTo(self.contentView).offset(-viewPix(8));
        }];
        
    }else{
        self.baseView.cornerRidus = 15;
        [self.baseView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(viewPix(8));
            make.bottom.equalTo(self.contentView).offset(-viewPix(8));
        }];
    }
}

-(UIView *)baseView{
    if(!_baseView){
        _baseView = [[UIView alloc] init];
        _baseView.backgroundColor = [UIColor whiteColor];
    }
    return _baseView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
