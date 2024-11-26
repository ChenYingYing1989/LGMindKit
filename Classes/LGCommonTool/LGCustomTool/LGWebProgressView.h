//
//  LGWebProgressView.h
//  haoshuimian365
//
//  Created by LZH on 2019/4/16.
//  Copyright © 2019 CYY or LZH. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface LGWebProgressView : CAShapeLayer

- (void)speedLoad;
- (void)startLoad;
- (void)closeTimer;

@end

NS_ASSUME_NONNULL_END
