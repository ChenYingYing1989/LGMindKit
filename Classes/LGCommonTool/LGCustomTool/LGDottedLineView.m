//
//  LGDottedLineView.m
//  HeartDiseaseManage
//
//  Created by 1234 on 2023/3/4.
//

#import "LGDottedLineView.h"

@implementation LGDottedLineView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.lineColor = @"#E1E1E1";
        self.lineDirection = @"horizonta";
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)setLineColor:(NSString *)lineColor{
    _lineColor = lineColor;
    [self setNeedsLayout];
}

-(void)setLineDirection:(NSString *)lineDirection{
    _lineDirection = lineDirection;
    [self setNeedsLayout];
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if([self.lineDirection isEqualToString:@"horizonta"]){
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetLineCap(context, kCGLineCapRound);
        CGContextSetLineWidth(context, 1);
        CGContextSetStrokeColorWithColor(context, [UIColor colorWithHexString:self.lineColor].CGColor);
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, 5, self.bounds.size.height/2.0);
        CGFloat lengths[] = {5,5};
        CGContextSetLineDash(context, 0, lengths, 2);
        CGContextAddLineToPoint(context, self.bounds.size.width, self.bounds.size.height/2.0);
        CGContextStrokePath(context);
        CGContextClosePath(context);
    }else{
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetLineCap(context, kCGLineCapRound);
        CGContextSetLineWidth(context, 1);
        CGContextSetStrokeColorWithColor(context, [UIColor colorWithHexString:self.lineColor].CGColor);
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, self.bounds.size.width/2.0, 3);
        CGFloat lengths[] = {3,3};
        CGContextSetLineDash(context, 0, lengths, 2);
        CGContextAddLineToPoint(context, self.bounds.size.width/2.0, self.bounds.size.height);
        CGContextStrokePath(context);
        CGContextClosePath(context);
    }
    
}


@end
