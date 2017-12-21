//
//  NewInfoViewController.m
//  12.7-ceshi
//
//  Created by cchaojie on 2017/12/18.
//  Copyright © 2017年 chaojie. All rights reserved.
//

#import "NewInfoViewController.h"

@interface NewInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_title;
    NSArray *_context;
    NSArray *_people;

}
@end

@implementation NewInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"zhaolexiaoxi";
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource  =self;
    tableView.rowHeight = 120;
    [self.view addSubview:tableView];
    
    NSLog(@"---%@",[self getCurrentTime]);
    
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStyleDone target:self action:@selector(leftBarClick)];
    self.navigationItem.leftBarButtonItem = leftBar;
    
    _title = @[@"one",@"tow",@"three",@"four",@"five"];
    _context = @[@"做过几年IOS开发的都会有这样一种感觉，就是界面适配工作越来越难做了，原来iphone机型少，问题不大，但随着现在iphone机型越来越丰富，这个问题更加严重了。总结一下，ios开发中碰到的问题如下",@"对于稍复杂点的界面，在xib中设置autolayout是件极其容易出错的事情，如果不用xib改用masonry，则需要写大量的代码，而且无法直观的看到效果",@"同一个项目，大量控件的属性都是一样的，但是你不得不在xib或者代码中一次又一次的重复设置同样的属",@"对于稍微大一些的工程，每做一次改动如果想看到效果，必须编译运行才行，这需要大量的时间，往往人的耐心就是这样耗没的(｡•ˇ‸ˇ•｡)",@"iphonex一出，多少工程都需要大量的工作来适配，包括微信都出了三版来做适配工作，太悲催了(｡•ˇ‸ˇ•｡)"];
    _people = @[@"ben",@"daming",@"sam",@"blifm",@"alex"];
    
    [tableView registerNib:[UINib nibWithNibName:@"CustomTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}
-(void)leftBarClick{
    JASidePanelController *viewController = [[JASidePanelController alloc] init];
    viewController.shouldDelegateAutorotateToVisiblePanel = NO;
    viewController.leftPanel = [[LeftViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[MainViewController alloc] init]];
    
    viewController.centerPanel = nav;
    UIWindow *window = [[UIApplication sharedApplication]keyWindow];
    window.rootViewController = viewController;
    
    
    CATransition *myTransition=[CATransition animation];//创建CATransition
    myTransition.duration=0.35;//持续时长0.35秒
    myTransition.timingFunction=UIViewAnimationCurveEaseInOut;//计时函数，从头到尾的流畅度
    myTransition.type = kCATransitionFade;//子类型
    [window.layer addAnimation:myTransition forKey:nil];
}
- (NSString *)getCurrentTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd,hh:mm:ss"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _title.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell != nil) {
        cell.title.text = _title[indexPath.row];
        cell.date.text = [self getCurrentTime];
        cell.context.text = _context[indexPath.row];
        cell.people.text = _people[indexPath.row];
    }else{
        
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            PeopleInfoViewController *peopleVC = [[PeopleInfoViewController alloc] init];
            peopleVC.titleInfo = _title[0];
            peopleVC.dateinfo = [self getCurrentTime];
            peopleVC.contextinfo = _context[0];
            peopleVC.peopleinfo = _people[0];
            peopleVC.titlepeople = self.navigationItem.title;
            peopleVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:peopleVC animated:YES];
            
        }
            break;
        case 1:
        {
            PeopleInfoViewController *peopleVC = [[PeopleInfoViewController alloc] init];
            peopleVC.titleInfo = _title[1];
            peopleVC.dateinfo = [self getCurrentTime];
            peopleVC.contextinfo = _context[1];
            peopleVC.peopleinfo = _people[1];
            peopleVC.titlepeople = self.navigationItem.title;
            peopleVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:peopleVC animated:YES];
        }
            break;
        case 2:
        {
            PeopleInfoViewController *peopleVC = [[PeopleInfoViewController alloc] init];
            peopleVC.titleInfo = _title[2];
            peopleVC.dateinfo = [self getCurrentTime];
            peopleVC.contextinfo = _context[2];
            peopleVC.peopleinfo = _people[2];
            peopleVC.titlepeople = self.navigationItem.title;
            peopleVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:peopleVC animated:YES];
        }
            break;
        case 3:
        {
            PeopleInfoViewController *peopleVC = [[PeopleInfoViewController alloc] init];
            peopleVC.titleInfo = _title[3];
            peopleVC.dateinfo = [self getCurrentTime];
            peopleVC.contextinfo = _context[3];
            peopleVC.peopleinfo = _people[3];
            peopleVC.titlepeople = self.navigationItem.title;
            peopleVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:peopleVC animated:YES];
        }
            break;
        case 4:
        {
            PeopleInfoViewController *peopleVC = [[PeopleInfoViewController alloc] init];
            peopleVC.titleInfo = _title[4];
            peopleVC.dateinfo = [self getCurrentTime];
            peopleVC.contextinfo = _context[4];
            peopleVC.peopleinfo = _people[4];
            peopleVC.titlepeople = self.navigationItem.title;
            peopleVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:peopleVC animated:YES];
        }
            break;
        default:
            break;
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
