//
//  FZControl.h
//  12.7-ceshi
//
//  Created by cchaojie on 2017/12/19.
//  Copyright © 2017年 chaojie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FZControl : NSObject

+(UIButton *)createBtnFrame:(CGRect)frame title:(NSString *)title bgImageName:(NSString *)bgImageName target:(id)target action:(SEL)action;

+(UILabel *)createLableFrame:(CGRect)frame text:(NSString *)text;


@end
