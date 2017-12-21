//
//  FZControl.m
//  12.7-ceshi
//
//  Created by cchaojie on 2017/12/19.
//  Copyright © 2017年 chaojie. All rights reserved.
//

#import "FZControl.h"

@implementation FZControl

+(UIButton *)createBtnFrame:(CGRect)frame title:(NSString *)title bgImageName:(NSString *)bgImageName target:(id)target action:(SEL)action

{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = frame;
    
    [btn setTitle:title forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [btn setBackgroundImage:[UIImage imageNamed:bgImageName] forState:UIControlStateNormal];
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    
    return btn;
    
}

+(UILabel *)createLableFrame:(CGRect)frame text:(NSString *)text{
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = frame;
    label.text = text;
    label.textColor = [UIColor greenColor];
    return label;
}

@end
