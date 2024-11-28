//
//  LGShadowButton.m
//  HyperactivityPatient
//
//  Created by mac on 2021/3/30.
//

#import "LGShadowButton.h"

@interface LGShadowButton()
/**   */
@property (nonatomic , strong)CAGradientLayer *gradLayer;

@end

@implementation LGShadowButton
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        self.titleLabel.font = LGFont(18);
        self.layer.cornerRadius = frame.size.height/2.0;
        self.layer.shadowColor = [UIColor colorWithHexString:@"#4085F1"].CGColor;
        self.layer.shadowOffset = CGSizeMake(0,2.5);
        self.layer.shadowOpacity = 1;
        self.layer.shadowRadius = 5;
//        [self.layer addSublayer:self.gradLayer];
        [self.layer insertSublayer:self.gradLayer atIndex:0];
    }
    return self;
}

-(void)setShadowColor:(NSString *)shadowColor{
    _shadowColor = shadowColor;
    self.layer.shadowColor = [UIColor colorWithHexString:shadowColor].CGColor;
    
}

-(void)setLayerColors:(NSArray *)layerColors{
    _layerColors = layerColors;
    self.gradLayer.colors = @[(__bridge id)[UIColor colorWithHexString:layerColors[0]].CGColor, (__bridge id)[UIColor colorWithHexString:layerColors[1]].CGColor];
}

-(void)setRadius:(CGFloat)radius{
    _radius = radius;
    self.gradLayer.cornerRadius = radius;
    self.layer.cornerRadius = radius;
}

-(CAGradientLayer *)gradLayer{
    if(!_gradLayer){
        _gradLayer = [[CAGradientLayer alloc]init];
        _gradLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        _gradLayer.startPoint = CGPointMake(1, 0.5);
        _gradLayer.endPoint = CGPointMake(0, 0.5);
        _gradLayer.colors = @[(__bridge id)[UIColor colorWithHexString:@"#68A2FD"].CGColor, (__bridge id)[UIColor colorWithHexString:@"#4085F1"].CGColor];
        _gradLayer.locations = @[@(0), @(1.0f)];
        _gradLayer.cornerRadius = self.frame.size.height/2.0;
    }
    return _gradLayer;
}



@end
