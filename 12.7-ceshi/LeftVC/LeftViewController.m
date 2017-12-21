//
//  LeftViewController.m
//  12.7-ceshi
//
//  Created by cchaojie on 2017/12/8.
//  Copyright © 2017年 chaojie. All rights reserved.
//

#import "LeftViewController.h"

@interface LeftViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIImageView *_imgView;
    NSString *_path;
}

@property(nonatomic,strong)NSArray *array;
@property(nonatomic,assign)BOOL select;

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.view.backgroundColor = [UIColor greenColor];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth,kScreenHeight) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    
    _array = @[@"my information",@"my friends",@"my setting",@"Clear the cache"];
    
    _select = NO;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _array.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[UITableViewCell alloc]  initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
    }
    
    cell.textLabel.text = _array [indexPath.row];
    if (indexPath.row == 3) {
        if (_select == NO) {
            float aa = [FZCleanCache folderSizeAtPath];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%.00f.KB",aa];
        }else{
            float aa = [_path floatValue];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%.00f.KB",aa];
        }

    }
   
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
        {
           
            
            UIWindow *window = [[UIApplication sharedApplication] delegate].window;
            NewInfoViewController *newInfoVC = [[NewInfoViewController alloc]init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:newInfoVC];
            window.rootViewController = nav;
            
            
            CATransition *myTransition=[CATransition animation];//创建CATransition
            myTransition.duration=0.35;//持续时长0.35秒
            myTransition.timingFunction=UIViewAnimationCurveEaseInOut;//计时函数，从头到尾的流畅度
            myTransition.type = kCATransitionFade;//子类型
            [window.layer addAnimation:myTransition forKey:nil];
            
        }
            break;
        case 1:
        {
            NewInfoViewController *newInfoVC = [[NewInfoViewController alloc]init];
            
            [self.navigationController pushViewController:newInfoVC animated:YES];
        }
            break;
        case 2:
        {
            SettingViewController *settingVC = [[SettingViewController alloc]init];
            
            [self.navigationController pushViewController:settingVC animated:YES];
        }
            break;
        case 3:
        {
            _select = YES;
            float aa = [FZCleanCache folderSizeAtPath];
            if (aa >= (1024 * 1024)) {
                NSString *string = [NSString stringWithFormat:@"%f.GB",aa];
                [self addOtherAlertVC:string];
                
            }else if (aa >= 1024){
                NSString *string = [NSString stringWithFormat:@"%.0f.MB",aa];
                [self addOtherAlertVC:string];
                
            }else if (aa >= 1){
                NSString *string = [NSString stringWithFormat:@"%.00f.KB",aa];
                [self addOtherAlertVC:string];
                NSLog(@"aa1:%f",aa);
                
            }
            
            [tableView reloadData];
        }
            break;
        default:
            break;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 200;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *aView = [[UIView alloc] init];
    aView.backgroundColor = [UIColor whiteColor];

    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    _imgView.image = [UIImage imageNamed:@"timg.jpg"];
    [aView addSubview:_imgView];
    _imgView.userInteractionEnabled = YES;
    
    
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesChange:)];
    [_imgView addGestureRecognizer:ges];
    
    return aView;
    
}
-(void)gesChange:(UITapGestureRecognizer *)tap{
   UIImagePickerController *pickerVC = [[UIImagePickerController alloc] init];
    pickerVC.delegate  = self;
    pickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:pickerVC animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
//    _imgView.image = info[UIImagePickerControllerOriginalImage];
    
    _imgView.image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    [self saveImageToPhotos:_imgView.image];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)saveImageToPhotos:(UIImage*)savedImage

{
    UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    
}
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    
    NSString *msg = nil ;
    
    if(error != NULL){
        
        msg = @"save photo The failure" ;
        
    }else{
        
        msg = @"save photo The successful" ;
        
    }
    
    [self addAlertVC:msg];
}
-(void)addAlertVC:(NSString *)msg{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"save photo The results showed" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okSure = [UIAlertAction actionWithTitle:@"okSure" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:okSure];
    [self presentViewController:alertVC animated:YES completion:nil];
}
-(void)addOtherAlertVC:(NSString *)msg{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"Are you sure Clear the cache?" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okSure = [UIAlertAction actionWithTitle:@"okSure" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        _select = YES;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

            NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];

            NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
            NSLog(@"files :%lu",(unsigned long)[files count]);
            for (NSString *p in files) {
                NSError *error;
                _path = [cachPath stringByAppendingPathComponent:p];
                if ([[NSFileManager defaultManager] fileExistsAtPath:_path]) {
                    [[NSFileManager defaultManager] removeItemAtPath:_path error:&error];
                    
                }
            }
        });
        [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];

        }];
    [alertVC addAction:okSure];
    [self presentViewController:alertVC animated:YES completion:nil];
}

-(void)clearCacheSuccess
{
    NSLog(@"清理成功");
    
    float aa = [_path floatValue];
    
    NSString *string = [NSString stringWithFormat:@"%.00f.KB",aa];
    NSLog(@"aa2:%f",aa);
    showTishi(string);
    
    
    
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
