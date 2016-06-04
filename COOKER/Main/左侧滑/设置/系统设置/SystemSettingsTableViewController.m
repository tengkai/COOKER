//
//  SystemSettingsTableViewController.m
//  COOKER
//
//  Created by BEVER on 16/6/3.
//  Copyright © 2016年 李楠. All rights reserved.
//

#import "SystemSettingsTableViewController.h"

@interface SystemSettingsTableViewController ()

@end

@implementation SystemSettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.SystemTableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"setTableViewCell"];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"setTableViewCell"];
        }
        cell.backgroundColor = [UIColor lightGrayColor];
        cell.alpha = 0.5;
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LCMSetTableViewCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"LCMSetTableViewCell"];
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"护眼模式";
        
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"nightMode"] == 0) {
            cell.detailTextLabel.text = @"关";
        } else {
            cell.detailTextLabel.text = @"开";
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    } else if (indexPath.row == 1) {
        
        NSUserDefaults *userUD = [[NSUserDefaults alloc] init];
        
        if ([userUD valueForKey:@"wordSize"] == nil) {
            [userUD setValue:@"1" forKey:@"wordSize"];
        }
        
        cell.textLabel.text = @"正文字号";
        if ([[userUD valueForKey:@"wordSize"] isEqualToString:@"0"]) {
            cell.detailTextLabel.text = @"小号字";
        } else if ([[userUD valueForKey:@"wordSize"] isEqualToString:@"1"]) {
            cell.detailTextLabel.text = @"中号字";
        } else {
            cell.detailTextLabel.text = @"大号字";
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    } else if (indexPath.row == 3) {
        
        cell.textLabel.text = @"版权声明";
        
    } else if (indexPath.row == 2) {
        
        cell.textLabel.text = @"清除缓存";
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
        CGFloat number = [self getSize];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2fM", number];
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView == self.SystemTableView) {
        
        NSString *wordSize = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
        
        NSUserDefaults *userUD = [[NSUserDefaults alloc] init];
        
        if (indexPath.row == 0) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"wordSize" object:wordSize];
            [userUD setValue:@"0" forKey:@"wordSize"];
        } else if (indexPath.row == 1) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"wordSize" object:wordSize];
            [userUD setValue:@"1" forKey:@"wordSize"];
        } else {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"wordSize" object:wordSize];
            [userUD setValue:@"2" forKey:@"wordSize"];
        }
        
        [self.tableView reloadData];
        self.SystemTableView.hidden = YES;
        self.SystemTableView.userInteractionEnabled = YES;
        
        return;
    }
    
    if (indexPath.row == 0) {
        
        //判断是否开启夜间模式
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"nightMode"] == 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"要开启夜间模式吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"要关闭夜间模式吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
        }
    } else if (indexPath.row == 1) {
        
        //选择正文字号
        self.SystemTableView.hidden = NO;
        self.SystemTableView.userInteractionEnabled = YES;
        
    } else if (indexPath.row == 3) {
        
        LCMCopyrightViewController *copyrightVC = [[LCMCopyrightViewController alloc] init];
        [self.navigationController pushViewController:copyrightVC animated:YES];
        
    } else if (indexPath.row == 2) {
        
        //        //gcd清理缓存
        //        //清理缓存图片
        //        [[SDImageCache sharedImageCache] cleanDisk];
        //        dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //            // 获取缓存路径
        //            NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        //            NSString *cachePath = path;
        //            // 将子路径放入到数组
        //            NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachePath];
        //            for (NSString *s in files) {
        //                // 拼接路径
        //                NSString *path = [cachePath stringByAppendingPathComponent:s];
        //                // 如果路径存在
        //                if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        //                    [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
        //                }
        //            }
        
        [[SDImageCache sharedImageCache] clearDisk];// 清除缓存
        [[SDImageCache sharedImageCache] cleanDisk];
        
        [self.tableView reloadData];
        
        [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];
        
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UIAlertView代理方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        
        //判断是否开启夜间模式
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"nightMode"] == 0) {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"nightMode"];
            [self.tableView reloadData];
            
            NSString *nightMode = @"1";
            //通知中心，监听夜间模式是否开启
            [[NSNotificationCenter defaultCenter] postNotificationName:@"nightMode" object:nightMode];
            
        } else {
            
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"nightMode"];
            [self.tableView reloadData];
            
            NSString *nightMode = @"0";
            //通知中心，监听夜间模式是否开启
            [[NSNotificationCenter defaultCenter] postNotificationName:@"nightMode" object:nightMode];
            
        }
    }
}

@end
