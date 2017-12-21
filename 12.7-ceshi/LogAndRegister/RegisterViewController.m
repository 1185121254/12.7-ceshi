//
//  RegisterViewController.m
//  12.7-ceshi
//
//  Created by cchaojie on 2017/12/7.
//  Copyright © 2017年 chaojie. All rights reserved.
//

#import "RegisterViewController.h"


@interface RegisterViewController ()<UITextFieldDelegate>
{
    NSUserDefaults *_userDefaults;
}
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *pswTF;

@property (weak, nonatomic) IBOutlet UITextField *yanzheng;

@property (weak, nonatomic) IBOutlet UIButton *sendBtn;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"Register";
    
    _userDefaults = [NSUserDefaults standardUserDefaults];
    [_userDefaults objectForKey:@"name"];
    [_userDefaults objectForKey:@"psw"];
    
    _nameTF.returnKeyType = UIReturnKeyNext;
    _pswTF.returnKeyType = UIReturnKeyNext;
    _nameTF.delegate = self;
    _pswTF.delegate = self;
    [_nameTF becomeFirstResponder];

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if ([_nameTF isFirstResponder]) {
        [_pswTF becomeFirstResponder];
    }else if ([_pswTF isFirstResponder]){
        [_nameTF becomeFirstResponder];
    }
    return YES;
}
- (BOOL)validateMobile:(NSString *)mobile
{
    if (mobile.length <= 0) {
        return NO;
    }
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
    
}
- (IBAction)registerBtn:(id)sender {
    
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    [phoneTest evaluateWithObject:_nameTF.text];
    
    if ([_nameTF.text isEqualToString:@""] || [_pswTF.text isEqualToString:@""] ) {
        [self addAlertVC:@"name or psw can't nil"];
        return;
    }

    if (![self validateMobile:_nameTF.text]) {
        
        [self addAlertVC:@"name can't telePhone!"];
        return;
    }
    if ([_nameTF.text isEqualToString:[_userDefaults objectForKey:@"name"]]) {
        [self addAlertVC:@"This user has been registered"];
        return;
    }
//    if ([_yanzheng.text isEqualToString:@""]) {
//        [self addAlertVC:@"yanzhengma can't nil!"];
//        return;
//    }
    
    People *pp = [[People alloc] init];
    pp.name = _nameTF.text;
    pp.psw = _pswTF.text;
    [_userDefaults setObject:pp.name forKey:@"name"];
    [_userDefaults setObject:pp.psw forKey:@"psw"];
    [_userDefaults synchronize];
    
    [self addAlertVC:@"register successful!"];
    
}
- (IBAction)sendBtn:(id)sender {
    
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:@"15010948357" zone:@"86" template:nil result:^(NSError *error) {
        if (!error) {
            NSLog(@"successful!");
            
        }else{
            NSLog(@"failure!");
        }
    }];

    //提交验证
    [SMSSDK commitVerificationCode:_yanzheng.text phoneNumber:_nameTF.text zone:@"86" result:^(NSError *error) {
        if (!error) {
            NSLog(@"sussessful!");
        }else{
            NSLog(@"3failure!");
        }
    }];
}

-(void)Timedelay{
    
    if ([_delegate respondsToSelector:@selector(changeName:)]) {
        [_delegate changeName:[_userDefaults objectForKey:@"name"]];
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)addAlertVC:(NSString *)msg{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"tishi" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okSure = [UIAlertAction actionWithTitle:@"okSure" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self performSelector:@selector(Timedelay) withObject:nil afterDelay:0.5];

    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:okSure];
    [alertVC addAction:cancel];
    [self presentViewController:alertVC animated:YES completion:nil];
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
