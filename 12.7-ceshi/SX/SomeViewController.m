//
//  SomeViewController.m
//  12.7-ceshi
//
//  Created by cchaojie on 2017/12/21.
//  Copyright © 2017年 chaojie. All rights reserved.
//

#import "SomeViewController.h"

@interface SomeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
}
@property(nonatomic,strong)NSMutableArray *array1;
@property(nonatomic,strong)NSMutableArray *array2;
@property(nonatomic,strong)NSMutableArray *array3;
@property(nonatomic,strong)NSMutableArray *array4;
@property(nonatomic,strong)NSMutableArray *arrayChange;
@end

@implementation SomeViewController
-(NSMutableArray *)array1{
    if (!_array1) {
        _array1 = [[NSMutableArray alloc] initWithObjects:@"one",@"two",@"three", nil];
    }
    return _array1;
}
-(NSMutableArray *)array2{
    if (!_array2) {
        _array2 = [[NSMutableArray alloc] initWithObjects:@"ben",@"alex",@"jam", nil];
    }
    return _array2;
}
-(NSMutableArray *)array3{
    if (!_array3) {
        _array3 = [[NSMutableArray alloc] initWithObjects:@"shuxue",@"yuwen",@"dili", nil];
    }
    return _array3;
}
-(NSMutableArray *)array4{
    if (!_array4) {
        _array4 = [[NSMutableArray alloc] initWithObjects:@"zhuhai",@"beijign",@"shajnghai", nil];
    }
    return _array4;
}
-(NSMutableArray *)arrayChange{
    if (!_arrayChange) {
        _arrayChange = [[NSMutableArray alloc] init];
    }
    return _arrayChange;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSArray *array = @[@"one",@"two",@"three",@"four"];
    
    for (int i = 0; i<4; i++) {
        
        float width = 60;
        float height = 40;
        
//        NSInteger row = i % 4;
        
        CGFloat jianju = (kScreenWidth - (width * 4)) / (4 + 1);
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(jianju + (width + jianju) * i , 20, width, height);
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        btn.tag = i+1;
    }
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [self.arrayChange addObjectsFromArray:self.array1];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.arrayChange.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str = @"cell";
    UITableViewCell *cell  =[tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }

    
    cell.textLabel.text = self.arrayChange[indexPath.row];
    
    return cell;
}
-(void)btnClick:(UIButton *)btn{
    NSLog(@"btn");
    
    [self.arrayChange removeAllObjects];
    
    switch (btn.tag) {
        case 1:
            [self.arrayChange addObjectsFromArray:self.array1];
            [_tableView reloadData];
            break;
        case 2:
            [self.arrayChange addObjectsFromArray:self.array2];
            [_tableView reloadData];
            break;
        case 3:
            [self.arrayChange addObjectsFromArray:self.array3];
            [_tableView reloadData];
            break;
        case 4:
            [self.arrayChange addObjectsFromArray:self.array4];
            [_tableView reloadData];
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
