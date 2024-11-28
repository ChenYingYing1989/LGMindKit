//
//  LGCheckPhotoTool.m
//  HeartDiseaseManage
//
//  Created by 1234 on 2023/3/10.
//  查看大图

#import "LGCheckPhotoTool.h"
#import <SDWebImage/SDWebImage.h>
#define picTop      (statusBarHeight+viewPix(20))
#define picWidth    (Screen_W)
#define picHeight   (Screen_H-picTop-viewPix(60)-bottomSafeBarHeight/3.0)

#define itemWidth    viewPix(98)
#define itemHeight   viewPix(70)
@interface LGCheckPhotoTool ()<UIScrollViewDelegate>
/**   */
@property (nonatomic , strong)UIScrollView *scrollView;
/**   */
@property (nonatomic , strong)UIPageControl *pageControl;
/**   */
@property (nonatomic , strong)UILabel *countLabel;

@end

@implementation LGCheckPhotoTool

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.title = @"";
        self.hidden = YES;
        self.alpha = 0;
        self.backgroundColor = [UIColor colorWithHexString:@"#000000"];
        [self addSubview:self.scrollView];
        [self addSubview:self.countLabel];
    }
    return self;
}

/**  网络图片地址 */
-(void)setPicArray:(NSArray *)picArray{
    _picArray = picArray;
    for (LGPhotoItemView *itemView in self.scrollView.subviews) {
        [itemView removeFromSuperview];
    }
    for (NSInteger i=0; i<picArray.count; i++) {
        LGPhotoItemView *itemView = [[LGPhotoItemView alloc]initWithFrame:CGRectMake(Screen_W*i, picTop, picWidth, picHeight)];
        itemView.photoUrl = picArray[i];
        [self.scrollView addSubview:itemView];
        __weak typeof(self) weakSelf = self;
        itemView.hiddenPhotoView = ^{
            [weakSelf hidenViewAnimation];
        };
    }
    self.scrollView.contentSize = CGSizeMake(Screen_W*picArray.count, Screen_H);
}

/**  image数组 */
-(void)setPhotoArray:(NSArray *)photoArray{
    _photoArray = photoArray;
    for (LGPhotoItemView *itemView in self.scrollView.subviews) {
        [itemView removeFromSuperview];
    }
    for (NSInteger i=0; i<photoArray.count; i++) {
        LGPhotoItemView *itemView = [[LGPhotoItemView alloc]initWithFrame:CGRectMake(Screen_W*i, picTop, picWidth, picHeight)];
        itemView.image = photoArray[i];
        [self.scrollView addSubview:itemView];
        __weak typeof(self) weakSelf = self;
        itemView.hiddenPhotoView = ^{
            [weakSelf hidenViewAnimation];
        };
    }
    self.scrollView.contentSize = CGSizeMake(Screen_W*photoArray.count, Screen_H);
}

-(void)showViewAnimation:(CGPoint)startPoint index:(NSInteger)index{
    NSArray *tempArray = self.picArray.count>0?self.picArray:self.photoArray;
    self.currentPage = index;
    self.pageControl.currentPage = index;
    self.countLabel.text = [NSString stringWithFormat:@"%@  %ld / %ld",self.title,index+1,tempArray.count];
    if (index<tempArray.count) {
        [self.scrollView setContentOffset:CGPointMake(Screen_W*index, 0)];
    }
    self.hidden = NO;
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.alpha = 1;
    } completion:nil];
}

-(void)hidenViewAnimation{
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        self.hidden = YES;
        [self removeFromSuperview];
    }];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSArray *tempArray = self.picArray.count>0?self.picArray:self.photoArray;
    self.currentPage = scrollView.contentOffset.x/Screen_W;
    self.countLabel.text = [NSString stringWithFormat:@"%@  %ld / %ld",self.title,self.currentPage+1,tempArray.count];
}

-(UIScrollView *)scrollView{
    if(!_scrollView){
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, Screen_W, Screen_H)];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

-(UILabel *)countLabel{
    if(!_countLabel){
        _countLabel = [UILabel lableWithText:@"" colorString:@"#FFFFFF" textFont:LGFont(16) textAlignment:NSTextAlignmentCenter lines:1];
        _countLabel.frame = CGRectMake(viewPix(20), Screen_H-viewPix(50)-bottomSafeBarHeight/3.0, Screen_W-viewPix(40), 30);
    }
    return _countLabel;
}

@end



#pragma mark
#pragma mark ====> LGPhotoItemView

@interface LGPhotoItemView()<UIScrollViewDelegate>
@property (nonatomic, strong) UITapGestureRecognizer *singleTap;
@property (nonatomic, strong) UITapGestureRecognizer *doubleTap;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imgView;


@end

@implementation LGPhotoItemView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.userInteractionEnabled = YES;
        [self addSubview:self.scrollView];
    }
    return self;
}

- (void)setPhotoUrl:(NSString *)photoUrl {
    _photoUrl = photoUrl;
    if (![photoUrl containsString:@"http"]) {
        photoUrl = [NSString stringWithFormat:@"%@%@",BaseUrl,photoUrl];
    }
    __weak __typeof(self) weakSelf = self;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:photoUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        weakSelf.image = image;
    }];
}

- (void)setImage:(UIImage *)image{
    _image = image;
    self.imgView.image = image;
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    CGFloat maxHeight = self.scrollView.bounds.size.height;
    CGFloat maxWidth = self.scrollView.bounds.size.width;
    //如果图片尺寸大于view尺寸，按比例缩放
    if (width > maxWidth || height > width) {
        CGFloat ratio = height / width;
        CGFloat maxRatio = maxHeight / maxWidth;
        if (ratio < maxRatio) {
            width = maxWidth;
            height = width*ratio;
        } else {
            height = maxHeight;
            width = height / ratio;
        }
    }
    self.imgView.frame = CGRectMake((maxWidth - width) / 2, (maxHeight - height) / 2, width, height);
}

- (void)handleDoubleTap1:(UITapGestureRecognizer *)recongnizer {
    if (recongnizer.numberOfTouchesRequired == 2) {
        return;
    }
    if (self.hiddenPhotoView) {
        self.hiddenPhotoView();
    }
}

- (void)handleDoubleTap:(UITapGestureRecognizer *)recongnizer {
    UIGestureRecognizerState state = recongnizer.state;
    switch (state) {
        case UIGestureRecognizerStateBegan:
            break;
        case UIGestureRecognizerStateChanged:
            break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded: {
            //以点击点为中心，放大图片
            CGPoint touchPoint = [recongnizer locationInView:recongnizer.view];
            BOOL zoomOut = self.scrollView.zoomScale == self.scrollView.minimumZoomScale;
            CGFloat scale = zoomOut?self.scrollView.maximumZoomScale:self.scrollView.minimumZoomScale;
            [UIView animateWithDuration:0.3 animations:^{
                self.scrollView.zoomScale = scale;
                if (zoomOut) {
                    CGFloat x = touchPoint.x*scale - self.scrollView.bounds.size.width / 2;
                    CGFloat maxX = self.scrollView.contentSize.width-self.scrollView.bounds.size.width;
                    CGFloat minX = 0;
                    x = x > maxX ? maxX : x;
                    x = x < minX ? minX : x;
                    
                    CGFloat y = touchPoint.y * scale-self.scrollView.bounds.size.height / 2;
                    CGFloat maxY = self.scrollView.contentSize.height-self.scrollView.bounds.size.height;
                    CGFloat minY = 0;
                    y = y > maxY ? maxY : y;
                    y = y < minY ? minY : y;
                    self.scrollView.contentOffset = CGPointMake(x, y);
                }
            }];
        }
            break;
        default:
            break;
    }
}

#pragma mark ====== UIScrollViewDelegate ======
//指定缩放UIScrolleView时，缩放UIImageView来适配
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imgView;
}

//缩放后让图片显示到屏幕中间
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    CGSize originalSize = _scrollView.bounds.size;
    CGSize contentSize = _scrollView.contentSize;
    CGFloat offsetX = originalSize.width > contentSize.width ? (originalSize.width - contentSize.width) / 2 : 0;
    CGFloat offsetY = originalSize.height > contentSize.height ? (originalSize.height - contentSize.height) / 2 : 0;
    self.imgView.center = CGPointMake(contentSize.width / 2 + offsetX, contentSize.height / 2 + offsetY);
}

#pragma mark ====== init ======
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.frame = self.bounds;
        _scrollView.delegate = self;
        _scrollView.maximumZoomScale = 2.0;//最大缩放倍数
        _scrollView.minimumZoomScale = 1;//最小缩放倍数
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        self.singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap1:)];
        _singleTap.delegate = self;
        [_scrollView addGestureRecognizer:_singleTap];
    }
    return _scrollView;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [UIImageView new];
        _imgView.userInteractionEnabled = YES;
        self.doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
        [_doubleTap setNumberOfTapsRequired:2];
        [_imgView addGestureRecognizer:_doubleTap];//添加双击手势
        
        [_singleTap requireGestureRecognizerToFail:_doubleTap];
        [self.scrollView addSubview:_imgView];
    }
    return _imgView;
}

@end



