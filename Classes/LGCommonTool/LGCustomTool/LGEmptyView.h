//
//  LGEmptyView.h
//  haoshuimian365
//
//  Created by apple on 2017/6/21.
//  Copyright © 2017年 CYY. All rights reserved.

#import <UIKit/UIKit.h>
#import "LGBaseView.h"

@protocol LGEmptyViewDelegate <NSObject>

@optional

-(void)requestData;

@end

@interface LGEmptyView : LGBaseView
/**   */
@property (nonatomic , weak)id <LGEmptyViewDelegate> delegate;
/**   */
@property (nonatomic , strong)UIImageView *imageView;
/**   */
@property (nonatomic , strong)UILabel *contentLabel;
/**   */
@property (nonatomic , strong)UIButton *retryBtn;
/**  行间距 */
@property (nonatomic , assign)CGFloat lineSpace;
/**  距中心点的偏移量 */
@property (nonatomic , assign)CGFloat offset;
/**  图片、文字间隔 */
@property (nonatomic , assign)CGFloat margin;
/**   */
@property (nonatomic , assign)BOOL needBuffer;


-(void)showViewWithImage:(NSString *)imageName content:(NSString *)content offset:(CGFloat)offset;

-(void)startBufferAction;

-(void)stopBufferAction;

@end
