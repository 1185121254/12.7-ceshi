//
//  UIViewController+JASidePanel.m
//  12.7-ceshi
//
//  Created by cchaojie on 2017/12/8.
//  Copyright © 2017年 chaojie. All rights reserved.
//

#import "UIViewController+JASidePanel.h"
#import "JASidePanelController.h"

@implementation UIViewController (JASidePanel)

- (JASidePanelController *)sidePanelController {
    UIViewController *iter = self.parentViewController;
    while (iter) {
        if ([iter isKindOfClass:[JASidePanelController class]]) {
            return (JASidePanelController *)iter;
        } else if (iter.parentViewController && iter.parentViewController != iter) {
            iter = iter.parentViewController;
        } else {
            iter = nil;
        }
    }
    return nil;
}

@end
