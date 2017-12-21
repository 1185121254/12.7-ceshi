//
//  SXViewController.m
//  12.7-ceshi
//
//  Created by cchaojie on 2017/12/19.
//  Copyright © 2017年 chaojie. All rights reserved.
//

#import "SXViewController.h"

@interface SXViewController ()<UISearchResultsUpdating,UITableViewDelegate,UITableViewDataSource>
{
    UISearchController *_searchC;
    UITableView *_tableView;
}
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *searchArray;
@end

@implementation SXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"search";
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _searchC = [[UISearchController alloc]initWithSearchResultsController:nil];
    _searchC.searchBar.frame = CGRectMake(0, 0, kScreenWidth, 50);
    _searchC.searchResultsUpdater = self;
    _searchC.dimsBackgroundDuringPresentation = NO;
    _tableView.tableHeaderView = _searchC.searchBar;
    
    _dataArray = [[NSMutableArray alloc] initWithObjects:@"王小管",@"李型剂",@"王青云",@"张菲菲",@"abe",@"ABe",@"aBS",@"wang@12.com", @"wan@126.cn", nil];
    
    _searchArray = [[NSMutableArray alloc] init];
}
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString* str = searchController.searchBar.text;
    NSLog(@"&&&&&&&&:%@",str);
//
//    NSPredicate *namePredicate = [NSPredicate predicateWithFormat:@"name CONTAINS %@",str];
//
    NSPredicate *namePredicate_2 = [NSPredicate predicateWithFormat:@"name CONTAINS[c] %@ ",str];
    
    NSLog(@"namePredicate_2:%@",namePredicate_2);
//
////    NSString *emailRegex = @"\\w+@\\w+\\.[A-Za-z]{2,4}";
//
////    NSPredicate *emailPredicate = [NSPredicate predicateWithFormat:@"name MATCHES %@",emailRegex];
//
    [_searchArray removeAllObjects];
  
    self.searchArray =  [NSMutableArray arrayWithArray:[self.dataArray filteredArrayUsingPredicate:namePredicate_2]];
    
//
    [_tableView reloadData];
//
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (_searchC.active) {
        return self.searchArray.count;
    }
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *str = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
    
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }

    if (_searchC.active) {
        cell.textLabel.text = self.searchArray[indexPath.row];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    return cell;
}
//-(void)leftBarClick{
//
//    [_webView reload];
//}
//-(void)rightBarClick{
//
//    [_webView stopLoading];
//
//}
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
