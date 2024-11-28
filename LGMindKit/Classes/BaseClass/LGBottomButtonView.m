//
//  LGBottomButtonView.m
//  XieHeHeartDisease
//
//  Created by 1234 on 2024/6/20.
//  底部ButtonView

#import "LGBottomButtonView.h"
#import "UIColor+LGExtension.h"
@interface LGBottomButtonView()
/**   */
@property (nonatomic , strong)UIButton *button1;
/**   */
@property (nonatomic , strong)UIButton *button2;
/**   */
@property (nonatomic , strong)UIButton *button3;

@end

@implementation LGBottomButtonView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.margin = viewPix(8);
        self.buttonH = viewPix(46);
        [self addSubview:self.button1];
        [self addSubview:self.button2];
        [self addSubview:self.button3];
    }
    return self;
}

-(instancetype)initWithTitle:(NSString *)title color:(NSString *)color type:(LGBottomButtonType)type frame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.margin = viewPix(8);
        self.buttonH = viewPix(46);
        [self addSubview:self.button1];
        self.backgroundColor = [UIColor whiteColor];
        NSString *buttonType = (type == LGBottomButtonTypeBack)?@"back":@"bolder";
        self.itemArray = @[@{@"title":title,@"color":color,@"type":buttonType}];
    }
    return self;
}

-(instancetype)initWithItemArray:(NSArray *)itemArray frame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.margin = viewPix(8);
        self.buttonH = viewPix(46);
        self.backgroundColor = [UIColor whiteColor];
        if (itemArray.count == 3) {
            [self addSubview:self.button1];
            [self addSubview:self.button2];
            [self addSubview:self.button3];
            
        }else if (itemArray.count == 2){
            [self addSubview:self.button1];
            [self addSubview:self.button2];
            
        }else if (itemArray.count == 1){
            [self addSubview:self.button1];
        }
        self.itemArray = itemArray;
    }
    return self;
}

-(void)setButtonH:(CGFloat)buttonH{
    _buttonH = buttonH;
    CGFloat itemW = (CGFloat)(self.bounds.size.width-viewPix(32)-self.margin*(self.itemArray.count-1))/self.itemArray.count;
    if (self.itemArray.count == 3) {
        self.button1.frame = CGRectMake(viewPix(16), viewPix(5), itemW, self.buttonH);
        self.button2.frame = CGRectMake(kMaxX(self.button1.frame)+self.margin, viewPix(5), itemW, self.buttonH);
        self.button3.frame = CGRectMake(kMaxX(self.button2.frame)+self.margin, viewPix(5), itemW, self.buttonH);
        
    }else if (self.itemArray.count == 2){
        self.button1.frame = CGRectMake(viewPix(16), viewPix(5), itemW, self.buttonH);
        self.button2.frame = CGRectMake(kMaxX(self.button1.frame)+self.margin, viewPix(5), itemW, self.buttonH);
        
    }else if (self.itemArray.count == 1){
        self.button1.frame = CGRectMake(viewPix(16), viewPix(5), itemW, self.buttonH);
    }
}

-(void)setRadius:(CGFloat)radius{
    _radius = radius;
    if (self.itemArray.count == 3) {
        self.button1.cornerRidus = radius;
        self.button2.cornerRidus = radius;
        self.button3.cornerRidus = radius;
        
    }else if (self.itemArray.count == 2){
        self.button1.cornerRidus = radius;
        self.button2.cornerRidus = radius;
        
    }else if (self.itemArray.count == 1){
        self.button1.cornerRidus = radius;
    }
}

-(void)setItemArray:(NSArray *)itemArray{
    _itemArray = itemArray;
    if (_button1) _button1.hidden = YES;
    if (_button2) _button2.hidden = YES;
    if (_button3) _button3.hidden = YES;
    
    CGFloat itemW = (CGFloat)(self.bounds.size.width-viewPix(32)-self.margin*(itemArray.count-1))/itemArray.count;
    for (NSInteger i=0; i<itemArray.count; i++) {
        NSDictionary *tempDic = itemArray[i];
        NSString *type = LGNSString(tempDic[@"type"]);
        NSString *color = LGNSString(tempDic[@"color"]);
        if (i==0) {
            self.button1.hidden = NO;
            self.button1.frame = CGRectMake(viewPix(16), viewPix(5), itemW, self.buttonH);
            [self.button1 setTitle:LGNSString(tempDic[@"title"]) forState:UIControlStateNormal];
            if ([type isEqualToString:@"bolder"]) {
                //带边框的
                self.button1.backgroundColor = [UIColor clearColor];
                [self.button1 addBorder:color lineWidth:1 cornerRidus:10];
                [self.button1 setTitleColor:[UIColor colorWithHexString:color] forState:UIControlStateNormal];
                
            }else{
                //带背景色的
                [self.button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [self.button1 setBackgroundColor:[UIColor colorWithHexString:color] forState:UIControlStateNormal];
                [self.button1 setBackgroundColor:[UIColor colorWithHexString:color] forState:UIControlStateHighlighted];
            }
        }else if (i==1){
            self.button2.hidden = NO;
            self.button2.frame = CGRectMake(kMaxX(self.button1.frame)+self.margin, viewPix(5), itemW, self.buttonH);
            [self.button2 setTitle:LGNSString(tempDic[@"title"]) forState:UIControlStateNormal];
            if ([type isEqualToString:@"bolder"]) {
                //带边框的
                self.button2.backgroundColor = [UIColor clearColor];
                [self.button2 addBorder:color lineWidth:1 cornerRidus:10];
                [self.button2 setTitleColor:[UIColor colorWithHexString:color] forState:UIControlStateNormal];
                
            }else{
                //带背景色的
                [self.button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [self.button2 setBackgroundColor:[UIColor colorWithHexString:color] forState:UIControlStateNormal];
                [self.button2 setBackgroundColor:[UIColor colorWithHexString:color] forState:UIControlStateHighlighted];
            }
        }else{
            self.button3.hidden = NO;
            self.button3.frame = CGRectMake(kMaxX(self.button2.frame)+self.margin, viewPix(5), itemW, self.buttonH);
            [self.button3 setTitle:LGNSString(tempDic[@"title"]) forState:UIControlStateNormal];
            if ([type isEqualToString:@"bolder"]) {
                //带边框的
                self.button3.backgroundColor = [UIColor clearColor];
                [self.button3 addBorder:color lineWidth:1 cornerRidus:10];
                [self.button3 setTitleColor:[UIColor colorWithHexString:color] forState:UIControlStateNormal];
                
            }else{
                //带背景色的
                [self.button3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [self.button3 setBackgroundColor:[UIColor colorWithHexString:color] forState:UIControlStateNormal];
                [self.button3 setBackgroundColor:[UIColor colorWithHexString:color] forState:UIControlStateHighlighted];
            }
        }
    }
}


-(void)itemButtonTouched:(UIButton *)sender{
    NSInteger index = sender.tag - 1000;
    NSString *title = sender.titleLabel.text;
    if (self.delegate && [self.delegate respondsToSelector:@selector(bottomButtonTouchedWithIndex:)]) {
        [self.delegate bottomButtonTouchedWithIndex:index];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(bottomButtonTouchedWithTitle:)]) {
        [self.delegate bottomButtonTouchedWithTitle:title];
    }
    
    if (sender == self.button1) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(bottomButtonTouched)]) {
            [self.delegate bottomButtonTouched];
        }
    }
}




-(UIButton *)button1{
    if(!_button1){
        _button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        _button1.titleLabel.font = LGFontWeight(16, UIFontWeightMedium);
        _button1.cornerRidus = 10;
        _button1.hidden = YES;
        _button1.tag = 1000+1;
        [_button1 addTarget:self action:@selector(itemButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button1;
}

-(UIButton *)button2{
    if(!_button2){
        _button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        _button2.titleLabel.font = LGFontWeight(16, UIFontWeightMedium);
        _button2.cornerRidus = 10;
        _button2.hidden = YES;
        _button2.tag = 1000+2;
        [_button2 addTarget:self action:@selector(itemButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button2;
}

-(UIButton *)button3{
    if(!_button3){
        _button3 = [UIButton buttonWithType:UIButtonTypeCustom];
        _button3.titleLabel.font = LGFontWeight(16, UIFontWeightMedium);
        _button3.cornerRidus = 10;
        _button3.hidden = YES;
        _button3.tag = 1000+3;
        [_button3 addTarget:self action:@selector(itemButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button3;
}

@end
