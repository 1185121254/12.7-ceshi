//
//  LoginViewController.m
//  12.7-ceshi
//
//  Created by cchaojie on 2017/12/7.
//  Copyright © 2017年 chaojie. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()<RegisterViewControllerDelegate,UITextFieldDelegate>
{
    NSUserDefaults * _userDefaults;

}
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *pswTF;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"Login";
    
     _userDefaults = [NSUserDefaults standardUserDefaults];
    [_userDefaults objectForKey:@"name"];
    [_userDefaults objectForKey:@"psw"];
    
    _nameTF.returnKeyType = UIReturnKeyNext;
    _pswTF.returnKeyType = UIReturnKeyNext;
    _nameTF.delegate = self;
    _pswTF.delegate = self;
    [_nameTF becomeFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([_nameTF isFirstResponder]) {
        [_pswTF becomeFirstResponder];
    } else if([_pswTF isFirstResponder]) {
        [_nameTF becomeFirstResponder];
    }
    return YES;
}
- (IBAction)logBtn:(id)sender {
    
    if ([_nameTF.text isEqualToString:@""] || [_pswTF.text isEqualToString:@""]) {
        showMessage(@"name or psw can't nil");
        return;
    }
    if (![_nameTF.text isEqualToString:[_userDefaults objectForKey:@"name"]] || ![_pswTF.text isEqualToString:[_userDefaults objectForKey:@"psw"]]) {
        showMessage(@"name or psw is not correct");
        return;
    }
     
    JASidePanelController *viewController = [[JASidePanelController alloc] init];
    viewController.shouldDelegateAutorotateToVisiblePanel = NO;
    viewController.leftPanel = [[LeftViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[MainViewController alloc] init]];
    
    viewController.centerPanel = nav;
    UIWindow *window = [[UIApplication sharedApplication]keyWindow];
    window.rootViewController = viewController;
    
    
}
- (IBAction)registerBtn:(id)sender {
    
    RegisterViewController *registerVC = [[RegisterViewController alloc]init];
    registerVC.delegate =self;
    [self.navigationController pushViewController:registerVC animated:YES];
}

-(void)changeName:(NSString *)name{
    
    _nameTF.text = name;
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
