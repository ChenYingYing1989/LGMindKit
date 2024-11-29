//
//  LGCheckPhotoTool.h
//  HeartDiseaseManage
//
//  Created by 1234 on 2023/3/10.
//  查看大图

#import <UIKit/UIKit.h>
#import "LGBaseView.h"
NS_ASSUME_NONNULL_BEGIN

@interface LGCheckPhotoTool : LGBaseView
/**  网络图片地址 */
@property (nonatomic , strong)NSArray *picArray;
/**  image数组 */
@property (nonatomic , strong)NSArray *photoArray;
/**  当前显示的图片 */
@property (nonatomic , assign)NSInteger currentPage;

//展现动画
-(void)showViewAnimation:(CGPoint)startPoint index:(NSInteger)index;
//收起动画
-(void)hidenViewAnimation;
/**   */
@property (nonatomic , copy)NSString *title;

@end



@interface LGPhotoItemView : LGBaseView
///
@property (nonatomic, copy) void(^hiddenPhotoView)(void);
/**   */
@property (nonatomic , copy)NSString *photoUrl;

@property (nonatomic, strong)UIImage *image;

@end

NS_ASSUME_NONNULL_END
