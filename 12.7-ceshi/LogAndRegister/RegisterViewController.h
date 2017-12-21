//
//  RegisterViewController.h
//  12.7-ceshi
//
//  Created by cchaojie on 2017/12/7.
//  Copyright © 2017年 chaojie. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RegisterViewControllerDelegate <NSObject>

-(void)changeName:(NSString *)name;

@end

@interface RegisterViewController : UIViewController

@property(nonatomic,weak)id<RegisterViewControllerDelegate> delegate;

@end
