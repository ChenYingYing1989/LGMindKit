//
//  LGPickerView.m
//  haoshuimian
//
//  Created by apple on 16/8/18.
//  Copyright © 2016年 CYY. All rights reserved.
//

#import "LGPickerView.h"

@interface LGPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
/**   */
@property (nonatomic , strong)UIView *baseView;
/**   */
@property (nonatomic , strong)UIView *topView;
/**   */
@property (nonatomic , strong)UIButton *cancelBtn;
/**   */
@property (nonatomic , strong)UILabel *leftUnitLabel;
/**   */
@property (nonatomic , strong)UILabel *rightUnitLabel;
/**   */
@property (nonatomic , copy)NSString *result;
/**   */
@property (nonatomic , strong)NSMutableArray *unitArray;

@end

@implementation LGPickerView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.unitOffset = viewPix(20);
        self.backgroundColor = RGBAColor(0, 0, 0, 0);
        [self creatSubView];
        [self showPickView];
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelBtnAction)]];
    }
    return self;
}

-(void)setUnits:(NSArray *)units{
    _units = units;
    if(units.count > 0){
        CGFloat itemWidth = self.pickView.size.width/units.count;
        self.unitArray = [NSMutableArray array];
        for (NSInteger i=0; i<units.count; i++) {
            UILabel *unitLabel = [UILabel lableWithText:units[i] colorString:@"#000000"textFont:LGFontWeight(15, UIFontWeightSemibold) textAlignment:NSTextAlignmentCenter lines:1];
            [self.pickView addSubview:unitLabel];
            [self.unitArray addObject:unitLabel];
            CGFloat centerX = itemWidth*i+itemWidth/2.0+self.unitOffset;
            centerX += (i == 0)?viewPix(20):0;
            [unitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.pickView.mas_left).offset(centerX);
                make.centerY.equalTo(self.pickView);
            }];
        }
    }
}


-(void)setPickArry:(NSArray *)pickArry{
    _pickArry = pickArry;
    [self.pickView reloadAllComponents];
}

-(void)setSelectStr:(NSString *)selectStr{
    _selectStr = selectStr;
    NSArray *arry = [self.selectStr componentsSeparatedByString:@"|"];
    if (arry.count>0) {
        for (NSInteger i=0; i<arry.count; i++) {
            NSString *str = [NSString stringWithFormat:@"%@",arry[i]];
            NSArray *tempArry = self.pickArry[i];
            for (NSInteger j=0; j<tempArry.count; j++) {
                if ([[NSString stringWithFormat:@"%@",tempArry[j]] isEqualToString:str]) {
                    [self.pickView selectRow:j inComponent:i animated:NO];
                    break;
                }
            }
        }
    }
}

//确定
-(void)sureBtnAction{
    NSMutableArray *indexArray = [NSMutableArray array];
    NSMutableArray *resultArray = [NSMutableArray array];
    for (NSInteger i=0; i<self.pickArry.count; i++) {
        NSInteger index = [self.pickView selectedRowInComponent:i];
        [indexArray addObject:[NSString stringWithFormat:@"%ld",index]];
        [resultArray addObject:LGNSString(self.pickArry[i][index])];
    }

    if ([self.delegate respondsToSelector:@selector(selectPickerViewIndex:)]) {
        [self.delegate selectPickerViewIndex:indexArray];
    }
    
    if ([self.delegate respondsToSelector:@selector(selectPickerViewResult:)]) {
        [self.delegate selectPickerViewResult:resultArray];
    }
    
    if ([self.delegate respondsToSelector:@selector(selectPickerIndexResult:indexArray:)]) {
        [self.delegate selectPickerIndexResult:resultArray indexArray:indexArray];
    }
        
    if (self.selectPickViewIndex) {
        self.selectPickViewIndex(indexArray);
    }
    
    if(self.selectPickViewResult){
        self.selectPickViewResult(resultArray);
    }
    
    if(self.selectPickIndexResult){
        self.selectPickIndexResult(resultArray, indexArray);
    }
    [self hiddenPickView];
}

-(void)cancelBtnAction{
    [self hiddenPickView];
}

-(void)showPickView{
    [UIView animateWithDuration:0.3 animations:^{
        self.baseView.frame = CGRectMake(0, Screen_H-viewPix(280)-bottomSafeBarHeight/3.0, Screen_W, viewPix(290)+bottomSafeBarHeight/3.0);
        self.backgroundColor = RGBAColor(0, 0, 0, 0.3);
    }];
}

-(void)hiddenPickView{
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor =  RGBAColor(0, 0, 0, 0);
        self.baseView.frame = CGRectMake(0, Screen_H, Screen_W, viewPix(290)+bottomSafeBarHeight/3.0);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


#pragma mark---pickViewDelegate
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return viewPix(40);
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return self.pickArry.count;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.pickArry[component] count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.pickArry[component][row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
   
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    //设置分割线的颜色
    for(UIView *singleLine in pickerView.subviews){
        if (singleLine.frame.size.height < 1){
            singleLine.backgroundColor = [UIColor clearColor];
        }
    }
    
    UILabel *pickerLabel = (UILabel *)view;
    if (!pickerLabel) {
        pickerLabel = [UILabel lableWithText:@"" colorString:@"#000000"textFont:LGFontWeight(15, UIFontWeightSemibold) textAlignment:NSTextAlignmentCenter lines:0];
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

#pragma mark---懒加载+布局
-(void)creatSubView{
    [self addSubview:self.baseView];
    [self.baseView addSubview:self.pickView];
    [self.pickView addSubview:self.leftUnitLabel];
    [self.pickView addSubview:self.rightUnitLabel];
    [self.baseView addSubview:self.topView];
    [self.topView addSubview:self.titleLabel];
    [self.topView addSubview:self.cancelBtn];
    [self.baseView addSubview:self.sureBtn];
}

-(UIView *)baseView{
    if(!_baseView){
        _baseView = [[UIView alloc]initWithFrame:CGRectMake(0, Screen_H, Screen_W, viewPix(290)+bottomSafeBarHeight/3.0)];
        _baseView.backgroundColor = [UIColor whiteColor];
        _baseView.cornerRidus = 10;
    }
    return _baseView;
}

-(UIView *)topView{
    if(!_topView){
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_W, 45*LGPercent)];
        _topView.backgroundColor = [UIColor whiteColor];
        _topView.cornerRidus = 10;
    }
    return _topView;
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [UILabel lableWithText:@"" colorString:@"#000000" textFont:LGFontWeight(16, UIFontWeightSemibold) textAlignment:NSTextAlignmentCenter lines:1];
        _titleLabel.frame = CGRectMake(viewPix(60), viewPix(10), Screen_W-viewPix(120), viewPix(40));
    }
    return _titleLabel;
}

-(UIButton *)cancelBtn{
    if(!_cancelBtn){
        _cancelBtn = [UIButton buttonWithImage:@"closeGray16" selectImage:@"closeGray16"];
        _cancelBtn.frame = CGRectMake(Screen_W-viewPix(48), viewPix(5), viewPix(40), viewPix(40));
        [_cancelBtn addTarget:self action:@selector(cancelBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

-(UIPickerView *)pickView{
    if(!_pickView){
        _pickView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 25*LGPercent, Screen_W, 210*LGPercent)];
        _pickView.backgroundColor = [UIColor whiteColor];
        _pickView.dataSource = self;
        _pickView.delegate = self;
    }
    return _pickView;
}

-(UIButton *)sureBtn{
    if(!_sureBtn){
        _sureBtn = [UIButton buttonWithTitle:@"确定" topMargin:kMaxY(self.pickView.frame)-viewPix(5)];
        [_sureBtn addTarget:self action:@selector(sureBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}

-(UILabel *)leftUnitLabel{
    if(!_leftUnitLabel){
        _leftUnitLabel = [UILabel lableWithText:@"" colorString:@"444444" textFont:LGFontWeight(13, UIFontWeightThin) textAlignment:NSTextAlignmentLeft lines:1];
        _leftUnitLabel.bounds = CGRectMake(0, 0, 60*LGPercent, 43*LGPercent);
//        _leftUnitLabel.frame = CGRectMake(0, 43*LGPercent, 60*LGPercent, 43*LGPercent);
    }
    return _leftUnitLabel;
}

-(UILabel *)rightUnitLabel{
    if(!_rightUnitLabel){
        _rightUnitLabel = [UILabel lableWithText:@"" colorString:@"444444" textFont:LGFontWeight(13, UIFontWeightThin) textAlignment:NSTextAlignmentLeft lines:1];
        _rightUnitLabel.bounds = CGRectMake(0, 0, 60*LGPercent, 43*LGPercent);
//        _leftUnitLabel.frame = CGRectMake(0, 43*LGPercent, 60*LGPercent, 43*LGPercent);
    }
    return _rightUnitLabel;
}

-(void)dealloc{
    self.delegate = nil;
}


@end
