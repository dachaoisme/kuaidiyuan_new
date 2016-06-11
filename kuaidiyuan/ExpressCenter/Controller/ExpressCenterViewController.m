//
//  ExpressCenterViewController.m
//  xueyuanpai
//
//  Created by lidachao on 16/5/3.
//  Copyright © 2016年 lidachao. All rights reserved.
//

#import "ExpressCenterViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface ExpressCenterViewController ()<CLLocationManagerDelegate>
{
    CALayer *_layer;
    CAAnimationGroup *_animaTionGroup;
    CADisplayLink *_disPlayLink;
    
    ExpressCenterPeopleModel * expressCenterPeopleModel;

    
}

///显示接单数量的控件视图
@property (nonatomic,strong)UILabel *showNumberCourier;


///定位管理器
@property (nonatomic,strong)CLLocationManager *manager;

///编码反编码的类
@property (nonatomic,strong)CLGeocoder *geocoder;


///位置信息
@property (nonatomic,strong)NSString *locationStr;


@property (nonatomic,strong) UILabel *showLocationLable;




@end

@implementation ExpressCenterViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self theTabBarHidden:NO];
    
    [self.view.layer removeAllAnimations];
    [_disPlayLink invalidate];
    _disPlayLink = nil;

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    [self.view.layer removeAllAnimations];
    [_disPlayLink invalidate];
    _disPlayLink = nil;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"我的快递"];
    
    self.view.backgroundColor = [CommonUtils colorWithHex:@"00beaf"];
    
    

    
    
    //开始定位
    [self startGetPosition];
    
    
    //定位信息的显示  deliver_icon_location
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, NAV_TOP_HEIGHT + 10, 8, 12)];
    imageView.image = [UIImage imageNamed:@"deliver_icon_location"];
    [self.view addSubview:imageView];
    
    
    UILabel *showLocationLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame) + 5, NAV_TOP_HEIGHT + 5, SCREEN_WIDTH - CGRectGetMaxX(imageView.frame) - 15, 20)];
    
    showLocationLable.text = @"北京";
    showLocationLable.font = [UIFont systemFontOfSize:14];
    showLocationLable.textColor = [UIColor whiteColor];
    [self.view addSubview:showLocationLable];

    self.showLocationLable = showLocationLable;


    
    
}

#pragma mark - 开始定位
- (void)startGetPosition{
    
    //第一步：初始化定位管理器
    self.manager = [[CLLocationManager alloc] init];
    
    
    //第二步：进行隐私的判断并授权
    
    
    //进行隐私的判断
    if (![CLLocationManager locationServicesEnabled]) {
        
        NSLog(@"是否前往隐私进行设置允许定位");
        
        
    }
    
    //根据状态进行授权
    
    //进行版本的判断
    if ([[[UIDevice currentDevice] systemVersion] integerValue] >= 8.0) {
        
        if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedWhenInUse) {
            
            //请求授权
            [self.manager requestWhenInUseAuthorization];
            
        }
        
    }
    
    //第三步：设置管理器的代理和相关属性
    self.manager.delegate = self;
    
    //设置精度
    self.manager.desiredAccuracy = 100;
    
    //设置最小更新距离
    self.manager.distanceFilter = 100;
    
    //第四步：开启定位
    [self.manager startUpdatingLocation];
    
    
    

}

#pragma mark - CLLocationManagerDelegate的代理方法
//这个代理方法是定位成功之后开始更新位置信息，只要移动设置的最小距离之后也开始走这个方法
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    //获取最后一次的位置
    CLLocation *location = locations.lastObject;
    //获取位置坐标
    CLLocationCoordinate2D coordinate= location.coordinate;
    
    NSLog(@"经度：%f,纬度：%f,海拔：%f,航海方向：%f,行走速度：%f",coordinate.longitude,coordinate.latitude,location.altitude,location.course,location.speed);
    
    
    
    //初始化对象
    self.geocoder = [[CLGeocoder alloc] init];
    
    
    //根据经纬度反编码取出地名
    [self getAdressByLongitude:coordinate.longitude Latitude:coordinate.latitude];
}

#pragma mark - 根据经纬度获取地址
- (void)getAdressByLongitude:(CLLocationDegrees)longitude Latitude:(CLLocationDegrees)latitude{
    
    
    //反编码
    //创建CLLocation
    CLLocation *location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    [_geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        
        //显示最前面的地标信息
        CLPlacemark *firstPlacemark=[placemarks firstObject];
        self.showLocationLable.text=firstPlacemark.name;
        
        
        
    }];
    
}
//定位失败
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    NSLog(@"定位失败了");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
