//
//  NewsViewController.m
//  PRO3
//
//  Created by BEVER on 16/6/2.
//  Copyright © 2016年 李楠. All rights reserved.
//

#import "NewsViewController.h"

@interface NewsViewController ()

@end

@implementation NewsViewController


-(instancetype)init
{
    if(self = [super init])
    {
        self.title = @"动态";
        
        self.tabBarItem.image = [UIImage imageNamed:@"index_menu_coup.png"];
        
        self.tabBarItem.title = nil;
    }
    
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(showLeft:)];
}

- (void)showLeft:(UIButton *)button{
    
    //1.获取App单例的delegate属性 -> AppDelegate类对应的单例对象
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    
    //2.
    [appDelegate.bVC showLeftVC];
    
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
