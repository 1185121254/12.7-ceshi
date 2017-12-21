//
//  UIViewController+JASidePanel.h
//  12.7-ceshi
//
//  Created by cchaojie on 2017/12/8.
//  Copyright © 2017年 chaojie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class JASidePanelController;


@interface UIViewController (JASidePanel)

@property (nonatomic, weak, readonly) JASidePanelController *sidePanelController;


@end
