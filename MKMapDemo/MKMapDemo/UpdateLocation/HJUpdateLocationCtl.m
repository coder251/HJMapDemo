//
//  HJUpdateLocationCtl.m
//  MKMapDemo
//
//  Created by huangjiong on 16/4/10.
//  Copyright © 2016年 huangjiong. All rights reserved.
//

#import "HJUpdateLocationCtl.h"
//定位框架
#import <CoreLocation/CoreLocation.h>

@interface HJUpdateLocationCtl ()<CLLocationManagerDelegate>

//定位管理器
@property(nonatomic,strong)CLLocationManager *locationManager;

@end

@implementation HJUpdateLocationCtl
#pragma mark - 懒加载
-(CLLocationManager *)locationManager
{
    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc] init];
        //代理
        _locationManager.delegate = self;
        
        //距离过滤, 移动多少米之后,才调用返回最新位置的代理方法
        //如果不设置,会一直返回最新位置
        _locationManager.distanceFilter = 100;
    }
    return _locationManager;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.判断系统版本
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        
        //用户授权后开始定位
        [self.locationManager requestWhenInUseAuthorization];
        //始终定位
        [self.locationManager requestAlwaysAuthorization];
    }
    
    //2.开始定位
    //[self.locationManager startUpdatingLocation];
}
#pragma mark - 开始定位
- (IBAction)startUpdateLocation:(id)sender
{
    [self.locationManager startUpdatingLocation];
}


#pragma mark - CLLocationManagerDelegate
//定位失败
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"定位失败:%@",error);
}

//定位成功
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    NSLog(@"定位成功");
    //当前位置
    CLLocation *currentLocation = locations.lastObject;
    //坐标
    CLLocationCoordinate2D currentCoordinate = currentLocation.coordinate;
    
    NSLog(@"当前坐标, 经度:%f, 纬度:%f",currentCoordinate.latitude, currentCoordinate.longitude);
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
