//
//  SetViewController.m
//  PRO3
//
//  Created by BEVER on 16/6/2.
//  Copyright © 2016年 李楠. All rights reserved.
//

#import "SetViewController.h"

@interface SetViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSArray *titles;

@end

@implementation SetViewController


-(instancetype)init
{
    if(self = [super init])
    {
        self.title = @"设置";
        
        self.tabBarItem.image = [UIImage imageNamed:@"index_menu_coup.png"];
        
        self.tabBarItem.title = nil;
    }
    
    return self;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 40,kScreenWidth*4/5 , kScreenHeight) style:UITableViewStylePlain];
    
    _tableView.dataSource = self;
    
    _tableView.delegate = self;
    
    _tableView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_tableView];
    
    _titles = @[@"系统设置",@"皮肤更换",@"账户与安全",@"清除缓存"];
    
}


#pragma mark -
#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    
    cell.backgroundColor = [UIColor lightGrayColor];
    
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"v110_02Index_icon%02ld",indexPath.row+1]];
    cell.textLabel.text = _titles[indexPath.row];
    
    
    
    return cell;
    
}



@end
