//
//  MainViewController.m
//  12.7-ceshi
//
//  Created by cchaojie on 2017/12/7.
//  Copyright © 2017年 chaojie. All rights reserved.
//

#import "MainViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface MainViewController ()<CAAnimationDelegate,MKMapViewDelegate,CLLocationManagerDelegate>
{
    UIView *_aView;
    LeftViewController *_leftVC ;
    CLLocationManager *_locationManager;
    MKMapView *_mapView;
    CLLocationManager *locationManager;
    CLLocation *location;
}

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.view.backgroundColor = [UIColor redColor];
    
    // 长按手势  长按添加大头针
    UILongPressGestureRecognizer *title = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(titleClick:)];
    [self.navigationItem.titleView addGestureRecognizer:title];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.navigationItem.title = [defaults objectForKey:@"city"];
    [defaults synchronize];
    
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(rightBarClick:)];
    self.navigationItem.rightBarButtonItem = rightBar;
    
    _mapView =[[MKMapView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    _mapView.zoomEnabled = YES;
    _mapView.showsUserLocation = YES;
    _mapView.scrollEnabled = YES;
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    if([[UIDevice currentDevice].systemVersion floatValue] > 8.0f)
    {
        [self getUserLocation];
    }
    // 长按手势  长按添加大头针
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(lpgrClick:)];
    [_mapView addGestureRecognizer:lpgr];

    
}

//获取当前位置
- (void)getUserLocation
{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    //kCLLocationAccuracyBest:设备使用电池供电时候最高的精度
    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    locationManager.distanceFilter = 50.0f;
    if (([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0))
    {
        [locationManager requestAlwaysAuthorization];
    }
    //更新位置
    [locationManager startUpdatingLocation];
}
#pragma mark-CLLocationManagerDelegate  位置更新后的回调
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    //停止位置更新
    [locationManager stopUpdatingLocation];
    
    CLLocation *loc = [locations firstObject];
    CLLocationCoordinate2D theCoordinate;
    //位置更新后的经纬度
    theCoordinate.latitude = loc.coordinate.latitude;
    theCoordinate.longitude = loc.coordinate.longitude;
    //设定显示范围
    MKCoordinateSpan theSpan;
    theSpan.latitudeDelta=0.01;
    theSpan.longitudeDelta=0.01;
    //设置地图显示的中心及范围
    MKCoordinateRegion theRegion;
    theRegion.center=theCoordinate;
    theRegion.span=theSpan;
    [_mapView setRegion:theRegion];
    location = [locations lastObject];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *array, NSError *error)
     {
         CLGeocoder *geocoder = [[CLGeocoder alloc] init];
         [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *array, NSError *error) {
             
             if (array.count > 0)
             {
                 CLPlacemark *placemark = [array objectAtIndex:0];
                 // 将获得的所有信息显示到label上
                 NSLog(@"%@",placemark.administrativeArea);
                 // 获取城市
                 NSString *city = placemark.administrativeArea;
                 if (!city) {
                     // 四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                     city = placemark.administrativeArea;
                 }
                 NSLog(@"当前城市:%@",city);
               
                 // 设置地图显示的类型及根据范围进行显示  安放大头针
                 MKPointAnnotation *pinAnnotation = [[MKPointAnnotation alloc] init];
                 pinAnnotation.coordinate = theCoordinate;
                 pinAnnotation.title = city;
                 [_mapView addAnnotation:pinAnnotation];
             }
             else if (error == nil && [array count] == 0)
             {
                 NSLog(@"No results were returned.");
             }
             else if (error != nil)
             {
                 NSLog(@"An error occurred = %@", error);
             }
             
             
         }];
         
     }];
}
// 每次添加大头针都会调用此方法  可以设置大头针的样式
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    // 判断大头针位置是否在原点,如果是则不加大头针
    if([annotation isKindOfClass:[mapView.userLocation class]])
        return nil;
    static NSString *annotationName = @"annotation";
    MKPinAnnotationView *anView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:annotationName];
    if(anView == nil)
    {
        anView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:annotationName];
    }
    anView.animatesDrop = YES;
    //    // 显示详细信息
    anView.canShowCallout = YES;
    //    anView.leftCalloutAccessoryView   可以设置左视图
    //    anView.rightCalloutAccessoryView   可以设置右视图
    return anView;
}
//长按添加大头针事件
- (void)lpgrClick:(UILongPressGestureRecognizer *)lpgr
{
    // 判断只在长按的起始点下落大头针
    if(lpgr.state == UIGestureRecognizerStateBegan)
    {
        // 首先获取点
        CGPoint point = [lpgr locationInView:_mapView];
        // 将一个点转化为经纬度坐标
        CLLocationCoordinate2D center = [_mapView convertPoint:point toCoordinateFromView:_mapView];
        MKPointAnnotation *pinAnnotation = [[MKPointAnnotation alloc] init];
        pinAnnotation.coordinate = center;
        pinAnnotation.title = @"长按";
        [_mapView addAnnotation:pinAnnotation];
    }
}

//计算两个位置之间的距离
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"%@",error);
}

-(void)rightBarClick:(UIBarButtonItem *)rightBar{
    [self addAlertVC:@"are you Determine the exit？"];
    
}

-(void)titleClick:(UILongPressGestureRecognizer *)plges{
    LocationViewController *locationVC = [[LocationViewController alloc]init];
    [locationVC setHidesBottomBarWhenPushed:YES];
    [locationVC returnText:^(NSString *cityname) {
        self.navigationItem.title = cityname;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:cityname forKey:@"city"];
        [defaults synchronize];
        
    }];
    [self.navigationController pushViewController:locationVC animated:YES];
}
-(void)addAlertVC:(NSString *)msg{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"tishi" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okSure = [UIAlertAction actionWithTitle:@"okSure" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        [self exitApplication];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:okSure];
    [alertVC addAction:cancel];
    [self presentViewController:alertVC animated:YES completion:nil];
}

-(void)addView{
    
    _aView = [[UIView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight)];
    _aView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_aView];
    
}
- (void)exitApplication {

    NSString *verCode = [[NSUserDefaults standardUserDefaults] objectForKey:@"name"];
    
    verCode = nil;
    
    UIWindow *window = [[UIApplication sharedApplication] delegate].window;
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
    window.rootViewController = nav;
    
    
    CATransition *myTransition=[CATransition animation];//创建CATransition
    myTransition.duration=0.35;//持续时长0.35秒
    myTransition.timingFunction=UIViewAnimationCurveEaseInOut;//计时函数，从头到尾的流畅度
    myTransition.type = kCATransitionFade;//子类型
    [window.layer addAnimation:myTransition forKey:nil];
    

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
