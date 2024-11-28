//
//  LGMindHomeController.m
//  LGMindKit
//
//  Created by 1234 on 2024/11/22.
//\

#import "LGMindHomeController.h"

#import "UIColor+LGExtension.h"
#import "LGHomeViewController.h"
#import "LGBottomButtonView.h"

#import <CoreBluetooth/CoreBluetooth.h>

@interface LGMindHomeController()<LGBottomButtonDelegate,CBCentralManagerDelegate,CBPeripheralManagerDelegate,CBPeripheralDelegate>

/**  中央管理器 */
@property (nonatomic , strong)CBCentralManager *centralManager;
/**  设备管理器 */
@property (nonatomic , strong)CBPeripheralManager *peripheralManager;
/**  已连接的外围设备 */
@property (nonatomic , strong)CBPeripheral *peripheral;
/**  要发送信号的特征值 */
@property (nonatomic , strong)CBCharacteristic *characteristic;

/**   */
@property (nonatomic , strong)CBUUID *serviceUUID;
/**   */
@property (nonatomic , strong)NSMutableArray *peripheralArray;

/**   */
@property (nonatomic , strong)UILabel *inoutTitle;
/**   */
@property (nonatomic , strong)UILabel *inoutLabel;
/**   */
@property (nonatomic , strong)UILabel *statusTitle;
/**   */
@property (nonatomic , strong)UILabel *statusLabel;
/**   */
@property (nonatomic , strong)UILabel *levelTitle;
/**   */
@property (nonatomic , strong)UILabel *levelLabel;
/**   */
@property (nonatomic , strong)UILabel *batteryTitle;
/**   */
@property (nonatomic , strong)UILabel *batteryLabel;
/**   */
@property (nonatomic , strong)UIButton *openBtn;

/**   */
@property (nonatomic , copy)NSString *inoutStr;
/**   */
@property (nonatomic , copy)NSString *statusStr;
/**   */
@property (nonatomic , copy)NSString *levelStr;
/**   */
@property (nonatomic , copy)NSString *batteryStr;



@end

@implementation LGMindHomeController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"首页";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.backBtn];
    self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    self.peripheralManager = [[CBPeripheralManager alloc]initWithDelegate:self queue:nil];
    
    [self.view addSubview:self.inoutTitle];
    [self.view addSubview:self.inoutLabel];
    [self.view addSubview:self.statusTitle];
    [self.view addSubview:self.statusLabel];
    [self.view addSubview:self.levelTitle];
    [self.view addSubview:self.levelLabel];
    [self.view addSubview:self.batteryTitle];
    [self.view addSubview:self.batteryLabel];
    [self.view addSubview:self.openBtn];
    
    LGBottomButtonView *actionView = [[LGBottomButtonView alloc] initWithItemArray:@[@{@"title":@"上调",@"color":@"#7562FF",@"type":@"back"},@{@"title":@"下调",@"color":@"#7562FF",@"type":@"back"}] frame:CGRectMake(0, kMaxY(self.batteryTitle.frame)+viewPix(80), Screen_W, viewPix(76))];
    actionView.delegate = self;
    [self.view addSubview:actionView];
    
    LGBottomButtonView *bottomView = [[LGBottomButtonView alloc]initWithTitle:@"下一页" color:@"#4C87FD" type:LGBottomButtonTypeBack frame:CGRectMake(0, Screen_H-topBarHeight-viewPix(76), Screen_W, viewPix(76))];
    bottomView.delegate = self;
    [self.view addSubview:bottomView];
}

-(void)backButtonAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)bottomButtonTouched{
    LGHomeViewController *controller = [[LGHomeViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)setInoutStr:(NSString *)inoutStr{
    _inoutStr = inoutStr;
    if ([inoutStr isEqualToString:@"ba"] || [inoutStr isEqualToString:@"BA"]) {
        //输入
        self.inoutLabel.text = [NSString stringWithFormat:@"BA - 输入"];
    }else{
        //输出
        self.inoutLabel.text = [NSString stringWithFormat:@"AB - 输出"];
    }
}

-(void)setStatusStr:(NSString *)statusStr{
    _statusStr = statusStr;
    if ([statusStr isEqualToString:@"10"]) {
        self.statusLabel.text = [NSString stringWithFormat:@"10 - 停止"];
        self.openBtn.selected = NO;
        
    }else if ([statusStr isEqualToString:@"11"]){
        self.statusLabel.text = [NSString stringWithFormat:@"11 - 运行"];
        self.openBtn.selected = YES;
        
    }else if ([statusStr isEqualToString:@"12"]){
        self.statusLabel.text = [NSString stringWithFormat:@"12 - 暂停"];
        self.openBtn.selected = NO;
        
    }else if ([statusStr isEqualToString:@"13"]){
        self.statusLabel.text = [NSString stringWithFormat:@"13 - 升档"];
        
    }else if ([statusStr isEqualToString:@"14"]){
        self.statusLabel.text = [NSString stringWithFormat:@"13 - 降档"];
    }
}

-(void)setLevelStr:(NSString *)levelStr{
    _levelStr = levelStr;
    self.levelLabel.text = [NSString stringWithFormat:@"%@ 档",levelStr];
}

-(void)setBatteryStr:(NSString *)batteryStr{
    _batteryStr = batteryStr;
    self.batteryLabel.text = batteryStr;
}

//上调 、 下调
-(void)bottomButtonTouchedWithIndex:(NSInteger)index{
    if (!self.peripheral || !self.characteristic) {
        return;
    }
    NSString *content = (index == 1)?@"A50A0134D9BA00010001100006AB130000C45A":@"A50A0134D9BA00010001100006AB140000C55A";
    NSData *data = [self stringToData:content];
    [self.peripheral writeValue:data forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
}

//开启 、 关闭
-(void)openButtonTouched:(UIButton *)sender{
    if (!self.peripheral || !self.characteristic) {
        return;
    }
    NSString *content = (sender.selected == NO)?@"A50A0134D9BA00010001100006AB110000C25A":@"A50A0134D9BA00010001100006AB100000C15A";
    NSData *data = [self stringToData:content];
    [self.peripheral writeValue:data forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
}

//检查蓝牙状态
- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    if (central.state == CBManagerStatePoweredOn) {
        NSLog(@"蓝牙已开启，开始扫描设备");
        CBUUID *uuid = [CBUUID UUIDWithString:@"6E40FFF0-B5A3-F393-E0A9-E50E24DCCA9E"];
        [self.centralManager scanForPeripheralsWithServices:@[uuid] options:nil];
    } else {
        NSLog(@"蓝牙不可用");
    }
}

//扫描设备
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *, id> *)advertisementData RSSI:(NSNumber *)RSSI {
    NSLog(@"发现设备：%@, 信号强度：%@ -- %ld -- %@", peripheral.name, RSSI,(long)peripheral.state , peripheral.services);
    // 保存设备并连接
    [self.peripheralArray addObject:peripheral];
    [self.centralManager stopScan];
    [self.centralManager connectPeripheral:peripheral options:nil];
}

//连接设备
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    NSLog(@"连接成功：%@", peripheral.name);
    peripheral.delegate = self;
    [peripheral discoverServices:nil];
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error{
    NSLog(@"连接失败：%@", peripheral.name);
}


//发现服务
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    for (CBService *service in peripheral.services) {
        NSLog(@"发现服务：%@", service.UUID);
        [peripheral discoverCharacteristics:nil forService:service];
    }
}

//发现特征值
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    for (CBCharacteristic *characteristic in service.characteristics) {
        NSLog(@"发现特征值：%@", characteristic.UUID);
        if ([characteristic.UUID.UUIDString isEqualToString:@"6E40FFF2-B5A3-F393-E0A9-E50E24DCCA9E"]) {
            self.characteristic = characteristic;
            self.peripheral = peripheral;
        }
        // 订阅特征值通知或读写数据
        [peripheral readValueForCharacteristic:characteristic];
        [peripheral setNotifyValue:YES forCharacteristic:characteristic];
    }
}

//处理数据
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    if (!error) {
        NSData *data = characteristic.value;
        NSLog(@"收到更新数据: %@\n Data:%@ \n",characteristic.UUID, data);
        [self handleResult:data];

    } else {
        NSLog(@"接收通知时出错: %@", error.localizedDescription);
    }
}

-(NSArray *)hexStringArray:(NSData *)data{
    const uint8_t *bytes = data.bytes;
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSInteger i = 0; i < data.length; i++) {
        [tempArray addObject:[NSString stringWithFormat:@"%02x",bytes[i]]];
    }
    return tempArray;
}

-(NSArray *)hexValueArray:(NSData *)data{
    const uint8_t *bytes = data.bytes;
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSInteger i = 0; i < data.length; i++) {
        [tempArray addObject:@(bytes[i])];
    }
    return tempArray;
}

-(NSData *)stringToData:(NSString *)content{
    NSMutableData *data = [NSMutableData data];
    for (NSInteger i=0; i<content.length; i += 2) {
        NSString *hexPair = [content substringWithRange:NSMakeRange(i, 2)];
        unsigned int byteValue;
        [[NSScanner scannerWithString:hexPair] scanHexInt:&byteValue];
        [data appendBytes:&byteValue length:1];
    }
    return data;
}

-(void)handleResult:(NSData *)data{
    NSArray *stringArray = [self hexStringArray:data];
    NSArray *valueArray = [self hexValueArray:data];
    if (stringArray.count>17) {
        self.inoutStr = stringArray[14];
        self.statusStr = stringArray[15];
        self.levelStr = stringArray[16];
        self.batteryStr = stringArray[17];
    }
    
    
//    NSString *csString = stringArray[10];
    
}




// A5 14 0A 01 34 D9 BA 00 01 00 01 10 00 06 BA 13 01 04 D8 5A
- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error{
    if (error) {
        NSLog(@"发送通知失败: %@", error.localizedDescription);
    }else{
        NSLog(@"发送通知成功: %@", characteristic.UUID);
    }
}

//订阅通知是否成功
- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error{
    if (error) {
        NSLog(@"订阅通知失败: %@", error.localizedDescription);
    } else {
        NSLog(@"订阅通知成功: %@", characteristic.UUID);
    }
}


//
- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral {
    if (peripheral.state == CBManagerStatePoweredOn) {
        NSLog(@"外围设备已启动");
        [self setupServiceAndCharacteristics];
    }
}

//定义服务和特征值
- (void)setupServiceAndCharacteristics {
    CBUUID *serviceUUID = [CBUUID UUIDWithString:@"6e40fff3-b5a3-f393-e0a9-e50e24dcca9e"];
    CBUUID *characteristicUUID = [CBUUID UUIDWithString:@"5678"];

    CBMutableCharacteristic *characteristic = [[CBMutableCharacteristic alloc] initWithType:characteristicUUID properties:CBCharacteristicPropertyRead value:nil permissions:CBAttributePermissionsReadable];

    CBMutableService *service = [[CBMutableService alloc] initWithType:serviceUUID primary:YES];
//    service.characteristics = @[characteristic];

    [self.peripheralManager addService:service];
}

//开始广播
- (void)startAdvertising {
    [self.peripheralManager startAdvertising:@{CBAdvertisementDataServiceUUIDsKey : @[[CBUUID UUIDWithString:@"6e40fff2-b5a3-f393-e0a9-e50e24dcca9e"]]}];
}

//处理请求
- (void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveReadRequest:(CBATTRequest *)request {
    if ([request.characteristic.UUID isEqual:[CBUUID UUIDWithString:@"5678"]]) {
        request.value = [@"Hello, World!" dataUsingEncoding:NSUTF8StringEncoding];
        [self.peripheralManager respondToRequest:request withResult:CBATTErrorSuccess];
    }
}


-(NSMutableArray *)peripheralArray{
    if(!_peripheralArray){
        _peripheralArray = [NSMutableArray array];
    }
    return _peripheralArray;
}


-(UILabel *)inoutTitle{
    if(!_inoutTitle){
        _inoutTitle = [UILabel lableWithText:@"输入/输出:" colorString:@"#2B2A37" textFont:LGFont(17) textAlignment:NSTextAlignmentLeft lines:1];
        _inoutTitle.frame = CGRectMake(viewPix(20), viewPix(30), viewPix(100), viewPix(40));
    }
    return _inoutTitle;
}

-(UILabel *)inoutLabel{
    if(!_inoutLabel){
        _inoutLabel = [UILabel lableWithText:@"" colorString:@"#2B2A37" textFont:LGFontWeight(17, UIFontWeightMedium) textAlignment:NSTextAlignmentLeft lines:1];
        _inoutLabel.frame = CGRectMake(viewPix(150), kMinY(self.inoutTitle.frame), Screen_W-viewPix(120), viewPix(40));
    }
    return _inoutLabel;
}

-(UILabel *)statusTitle{
    if(!_statusTitle){
        _statusTitle = [UILabel lableWithText:@"设备状态:" colorString:@"#2B2A37" textFont:LGFont(17) textAlignment:NSTextAlignmentLeft lines:1];
        _statusTitle.frame = CGRectMake(viewPix(20), kMaxY(self.inoutTitle.frame)+viewPix(10), viewPix(100), viewPix(40));
    }
    return _statusTitle;
}

-(UILabel *)statusLabel{
    if(!_statusLabel){
        _statusLabel = [UILabel lableWithText:@"" colorString:@"#2B2A37" textFont:LGFontWeight(17, UIFontWeightMedium) textAlignment:NSTextAlignmentLeft lines:1];
        _statusLabel.frame = CGRectMake(viewPix(150), kMinY(self.statusTitle.frame), Screen_W-viewPix(120), viewPix(40));
    }
    return _statusLabel;
}

-(UILabel *)levelTitle{
    if(!_levelTitle){
        _levelTitle = [UILabel lableWithText:@"刺激档位:" colorString:@"#2B2A37" textFont:LGFont(17) textAlignment:NSTextAlignmentLeft lines:1];
        _levelTitle.frame = CGRectMake(viewPix(20), kMaxY(self.statusTitle.frame)+viewPix(10), viewPix(100), viewPix(40));
    }
    return _levelTitle;
}

-(UILabel *)levelLabel{
    if(!_levelLabel){
        _levelLabel = [UILabel lableWithText:@"" colorString:@"#2B2A37" textFont:LGFontWeight(17, UIFontWeightMedium) textAlignment:NSTextAlignmentLeft lines:1];
        _levelLabel.frame = CGRectMake(viewPix(150), kMinY(self.levelTitle.frame), Screen_W-viewPix(120), viewPix(40));
    }
    return _levelLabel;
}

-(UILabel *)batteryTitle{
    if(!_batteryTitle){
        _batteryTitle = [UILabel lableWithText:@"设备电量:" colorString:@"#2B2A37" textFont:LGFont(17) textAlignment:NSTextAlignmentLeft lines:1];
        _batteryTitle.frame = CGRectMake(viewPix(20), kMaxY(self.levelTitle.frame)+viewPix(10), viewPix(100), viewPix(40));
    }
    return _batteryTitle;
}

-(UILabel *)batteryLabel{
    if(!_batteryLabel){
        _batteryLabel = [UILabel lableWithText:@"" colorString:@"#2B2A37" textFont:LGFontWeight(17, UIFontWeightMedium) textAlignment:NSTextAlignmentLeft lines:1];
        _batteryLabel.frame = CGRectMake(viewPix(150), kMinY(self.batteryTitle.frame), Screen_W-viewPix(120), viewPix(40));
    }
    return _batteryLabel;
}

-(UIButton *)openBtn{
    if(!_openBtn){
        _openBtn = [UIButton buttonWithTitle:@"开启" titleFont:LGFontWeight(25, UIFontWeightMedium) textColor:@"#FFFFFF" frame:CGRectMake((Screen_W-viewPix(100))/2.0, kMaxY(self.batteryTitle.frame)+viewPix(180), viewPix(100), viewPix(100))];
        [_openBtn setSelectTitle:@"关闭" textColor:@"#FFFFFF"];
        _openBtn.backgroundColor = [UIColor colorWithHexString:@"#7562FF"];
        _openBtn.cornerRidus = viewPix(50);
        [_openBtn addTarget:self action:@selector(openButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _openBtn;
}
 

@end
