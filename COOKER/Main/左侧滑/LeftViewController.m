//
//  LeftViewController.m
//  PRO3
//
//  Created by BEVER on 16/6/2.
//  Copyright © 2016年 李楠. All rights reserved.
//

#import "LeftViewController.h"

@interface LeftViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSArray *titles;

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 40,kScreenWidth*4/5 , kScreenHeight) style:UITableViewStylePlain];
    
    _tableView.dataSource = self;
    
    _tableView.delegate = self;
    
    _tableView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_tableView];
    
    _navigationControllers = [[NSMutableArray alloc]init];
    
    _titles = @[@"",@"收藏",@"设置",@"关注",@"关于我们",@"退出登入"];
    
    for (int i = 0; i<5; i++) {
        
        UIViewController *vc1 = [[UIViewController alloc]init];
        
        vc1.title = _titles[i];
        
        UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:vc1];
        
        [_navigationControllers addObject:nav1];
    }
}


#pragma mark -
#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 6;
    
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


//点击单元格时调用

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}



@end
