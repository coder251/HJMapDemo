//
//  HJMapViewController.m
//  MKMapDemo
//
//  Created by huangjiong on 16/4/10.
//  Copyright © 2016年 huangjiong. All rights reserved.
//

#import "HJMapViewController.h"
//地图框架
#import <MapKit/MapKit.h>

@interface HJMapViewController ()<MKMapViewDelegate>

//地图
@property(nonatomic,weak)MKMapView *mapView;

@end

@implementation HJMapViewController

#pragma mark - 懒加载
-(MKMapView *)mapView
{
    if (_mapView == nil) {
        MKMapView *mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64 - 49)];
        
        //代理
        _mapView.delegate = self;
        
        
        [self.view addSubview:mapView];
        _mapView = mapView;
    }
    return _mapView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //允许显示用户位置
    //设为YES之后, 将开始定位
    self.mapView.showsUserLocation = YES;
    
    MKCoordinateSpan span = MKCoordinateSpanMake(0.051109, 0.034153);
    MKCoordinateRegion region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(37.785834, 122.406417), span);
    [self.mapView setRegion:region animated:YES];
    
}


#pragma mark - MKMapViewDelegate
//即将开始定位
-(void)mapViewWillStartLocatingUser:(MKMapView *)mapView
{
    NSLog(@"即将开始定位");
}

//定位失败
-(void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"定位失败:%@",error);
}

//定位成功
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    NSLog(@"定位成功");
    
    //位置
    CLLocation *myLocation = userLocation.location;
    //坐标
    CLLocationCoordinate2D myCoodinate = myLocation.coordinate;
    
    NSLog(@"当前坐标, 经度:%f, 纬度:%f",myCoodinate.latitude, myCoodinate.longitude);
    
    //显示当前位置所在区域
    MKCoordinateSpan span = MKCoordinateSpanMake(0.051109, 0.034153);
    MKCoordinateRegion region = MKCoordinateRegionMake(userLocation.location.coordinate, span);
    [self.mapView setRegion:region animated:YES];
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
