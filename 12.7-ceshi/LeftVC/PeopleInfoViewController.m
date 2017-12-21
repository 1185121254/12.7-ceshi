//
//  PeopleInfoViewController.m
//  12.7-ceshi
//
//  Created by cchaojie on 2017/12/18.
//  Copyright © 2017年 chaojie. All rights reserved.
//

#import "PeopleInfoViewController.h"

@interface PeopleInfoViewController ()
{
    UILabel *_label;
    UIDatePicker *_picker;
}
@property (weak, nonatomic) IBOutlet UILabel *titleinfo;
@property (weak, nonatomic) IBOutlet UILabel *dateinfo1;
@property (weak, nonatomic) IBOutlet UILabel *contextinfo1;

@property (weak, nonatomic) IBOutlet UILabel *peopleinfo1;

@property(nonatomic,strong)People *pp;


@end

@implementation PeopleInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    self.navigationController.navigationBar.hidden = YES;
    self.navigationItem.title = _titlepeople;
    
    _titleinfo.text = _titleInfo;
    _dateinfo1.text = _dateinfo;
    _contextinfo1.text = _contextinfo;
    _peopleinfo1.text = _peopleinfo;
    
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithTitle:@"right" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarClick)];
    self.navigationItem.rightBarButtonItem = rightBar;
    
   
    [self.view addSubview: [FZControl createBtnFrame:CGRectMake(kScreenWidth/2-30, kScreenHeight/2-30, 60, 60) title:@"btnClick" bgImageName:@"timg.jpg" target:self action:@selector(btnClcikjia:)]];
    
    [self.view addSubview: [FZControl createBtnFrame:CGRectMake(kScreenWidth/3-30, kScreenHeight/2-30, 60, 60) title:@"btnClick" bgImageName:@"timg.jpg" target:self action:@selector(btnClcikjian)]];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2-30, kScreenHeight/3-30, 60, 60)];
    _label.textColor = [UIColor greenColor];
    [self.view addSubview:_label];
    
    _pp=[[People alloc] init];
    _pp.age = 60;
    [_pp addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew context:nil];
    

}
-(void)btnClcikjia:(UIButton *)btn{
//    _pp.age += 5;
    
    SXViewController *sxVC = [[SXViewController alloc] init];
    [self.navigationController pushViewController:sxVC animated:YES];
    NSLog(@"456");
}
-(void)btnClcikjian{
//    _pp.age -= 5;
    SomeViewController *someVC = [[SomeViewController alloc] init];
//    [self.navigationController pushViewController:someVC animated:YES];
    [self presentViewController:someVC animated:YES completion:nil];
}
/* KVO function， 只要object的keyPath属性发生变化，就会调用此函数*/
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
         if ([keyPath isEqualToString:@"age"] && object == _pp) {
                 _label.text = [NSString stringWithFormat:@"%d", _pp.age];
             }
}
-(void)rightBarClick{
    NSString *info = @"share test";

    UIImage *image=[UIImage imageNamed:@"timg.jpg"];
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    NSArray *postItems=@[info,image,url];
    
    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:postItems applicationActivities:nil];
    controller.excludedActivityTypes = @[UIActivityTypePostToFacebook,UIActivityTypePostToTwitter, UIActivityTypePostToWeibo,UIActivityTypeMessage,UIActivityTypeMail,UIActivityTypePrint,UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll,UIActivityTypeAddToReadingList,UIActivityTypePostToFlickr,UIActivityTypePostToVimeo,UIActivityTypePostToTencentWeibo,UIActivityTypeAirDrop,UIActivityTypeOpenInIBooks];
    
    //if iPhone
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [self presentViewController:controller animated:YES completion:nil];
    }
    //if iPad
    else {
        // Change Rect to position Popover
        UIBarButtonItem *shareBarButtonItem = self.navigationItem.rightBarButtonItem;
        UIPopoverController *popup = [[UIPopoverController alloc] initWithContentViewController:controller];
        [popup presentPopoverFromBarButtonItem:shareBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }

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
