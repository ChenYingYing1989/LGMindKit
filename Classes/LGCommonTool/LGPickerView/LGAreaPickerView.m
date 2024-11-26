//
//  LGAreaPickerView.m
//  HeartDiseaseManage
//
//  Created by 1234 on 2023/9/22.
//  地区选择器

#import "LGAreaPickerView.h"

@interface LGAreaPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
/**   */
@property (nonatomic , strong)UIView *baseView;
/**   */
@property (nonatomic , strong)UIView *topView;
/**   */
@property (nonatomic , strong)UIButton *cancelBtn;
/**   */
@property (nonatomic , strong)UIButton *sureBtn;
/**   */
@property (nonatomic , copy)NSString *result;
/**   */
@property (nonatomic , assign)NSInteger provinceIndex;
/**   */
@property (nonatomic , assign)NSInteger cityIndex;
/**   */
@property (nonatomic , assign)NSInteger areaIndex;

@end

@implementation LGAreaPickerView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGBAColor(0, 0, 0, 0);
        [self creatSubView];
        [self showPickView];
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelBtnAction)]];
    }
    return self;
}

-(void)setPickArry:(NSArray *)pickArry{
    _pickArry = pickArry;
    [self.pickView reloadAllComponents];
}

-(void)setSelectStr:(NSString *)selectStr{
    _selectStr = selectStr;
    self.provinceIndex = 0;
    self.cityIndex = 0;
    self.areaIndex = 0;
    NSArray *arry = [self.selectStr componentsSeparatedByString:@","];
    if (arry.count>0) {
        NSString *province = LGNSString(arry[0]);
        NSString *city = (arry.count>1)?LGNSString(arry[1]):@"";
        NSString *area = (arry.count>2)?LGNSString(arry[2]):@"";
        for (NSInteger i=0; i<self.pickArry.count; i++) {
            NSDictionary *provinceDic = self.pickArry[i];
            NSString *name = LGNSString(provinceDic[@"name"]);
            if([name isEqualToString:province]){
                self.provinceIndex = i;
                //市
                NSArray *cityArray = provinceDic[@"city"];
                for (NSInteger j=0; j<cityArray.count; j++) {
                    NSDictionary *cityDic = cityArray[j];
                    NSString *cityName = LGNSString(cityDic[@"name"]);
                    if([cityName isEqualToString:city]){
                        //区
                        self.cityIndex = j;
                        NSArray *areaArray = cityDic[@"area"];
                        for (NSInteger k=0; k<areaArray.count; k++) {
                            if([area isEqualToString:areaArray[k]]){
                                self.areaIndex = k;
                            }
                        }
                    }
                }
            }
            
        }
    }
    [self.pickView selectRow:self.provinceIndex inComponent:0 animated:NO];
    [self.pickView selectRow:self.cityIndex inComponent:1 animated:NO];
    [self.pickView selectRow:self.areaIndex inComponent:2 animated:NO];
}

//确定
-(void)sureBtnAction{
    NSDictionary *provinceDic = self.pickArry[self.provinceIndex];
    NSDictionary *cityDic = provinceDic[@"city"][self.cityIndex];
    NSString *area = cityDic[@"area"][self.areaIndex];
    NSString *result = [NSString stringWithFormat:@"%@,%@,%@",provinceDic[@"name"],cityDic[@"name"],area];
    if(self.selectPickViewResult){
        self.selectPickViewResult(result);
    }
    [self hiddenPickView];
}

-(void)cancelBtnAction{
    [self hiddenPickView];
}

-(void)showPickView{
    [UIView animateWithDuration:0.3 animations:^{
        self.baseView.frame = CGRectMake(0, Screen_H-viewPix(275)-bottomSafeBarHeight, Screen_W, viewPix(290)+bottomSafeBarHeight);
        self.backgroundColor = RGBAColor(0, 0, 0, 0.3);
    }];
}

-(void)hiddenPickView{
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor =  RGBAColor(0, 0, 0, 0);
        self.baseView.frame = CGRectMake(0, Screen_H, Screen_W, viewPix(290)+bottomSafeBarHeight);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


#pragma mark---pickViewDelegate
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 35*LGPercent;
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(component == 0){
        return self.pickArry.count;
        
    }else if (component == 1){
        NSArray *cityArray = self.pickArry[self.provinceIndex][@"city"];
        return cityArray.count;
        
    }else{
        NSArray *cityArray = self.pickArry[self.provinceIndex][@"city"];
        NSArray *areaArray = cityArray[self.cityIndex][@"area"];
        return areaArray.count;
    }
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(component == 0){
        //省
        return LGNSString(self.pickArry[row][@"name"]);
    
    }else if(component == 1){
        //市
        NSArray *cityArray = self.pickArry[self.provinceIndex][@"city"];
        return LGNSString(cityArray[row][@"name"]);
        
    }else{
        //区
        NSArray *cityArray = self.pickArry[self.provinceIndex][@"city"];
        NSArray *areaArray = cityArray[self.cityIndex][@"area"];
        return LGNSString(areaArray[row]);
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if(component == 0){
        //省
        self.provinceIndex = row;
        self.cityIndex = 0;
        self.areaIndex = 0;
        
    }else if (component == 1){
        //市
        self.cityIndex = row;
        self.areaIndex = 0;
        
    }else if (component == 2){
        //区
        self.areaIndex = row;
    }
    [self.pickView reloadAllComponents];
    [self.pickView selectRow:self.provinceIndex inComponent:0 animated:NO];
    [self.pickView selectRow:self.cityIndex inComponent:1 animated:NO];
    [self.pickView selectRow:self.areaIndex inComponent:2 animated:NO];
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
        pickerLabel = [UILabel lableWithText:@"" colorString:@"#000000"textFont:LGFontWeight(15, UIFontWeightSemibold) textAlignment:NSTextAlignmentCenter lines:2];
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

#pragma mark---懒加载+布局
-(void)creatSubView{
    [self addSubview:self.baseView];
    [self.baseView addSubview:self.pickView];
    [self.baseView addSubview:self.topView];
    [self.topView addSubview:self.titleLabel];
    [self.topView addSubview:self.cancelBtn];
    [self.baseView addSubview:self.sureBtn];
}

-(UIView *)baseView{
    if(!_baseView){
        _baseView = [[UIView alloc]initWithFrame:CGRectMake(0, Screen_H, Screen_W, viewPix(290)+bottomSafeBarHeight)];
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
        _titleLabel = [UILabel lableWithText:@"请选择地址" colorString:@"#000000" textFont:LGFont(15) textAlignment:NSTextAlignmentCenter lines:1];
        _titleLabel.frame = CGRectMake(viewPix(60), viewPix(5), Screen_W-viewPix(120), viewPix(40));
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
        _pickView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 30*LGPercent, Screen_W, 210*LGPercent)];
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



@end
