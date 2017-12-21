//
//  CustomTableViewCell.h
//  12.7-ceshi
//
//  Created by cchaojie on 2017/12/18.
//  Copyright © 2017年 chaojie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *context;
@property (weak, nonatomic) IBOutlet UILabel *people;



@end
