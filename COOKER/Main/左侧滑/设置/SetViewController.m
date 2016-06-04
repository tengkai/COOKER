//
//  SetViewController.m
//  PRO3
//
//  Created by BEVER on 16/6/2.
//  Copyright © 2016年 李楠. All rights reserved.
//

#import "SetViewController.h"
#import "SystemSettingsTableViewController.h"


@interface SetViewController ()<UIAlertViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *SystemSettingsTableView;

@property (nonatomic,strong) NSArray *titles;

@end

@implementation SetViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
    
    self.setTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,kScreenWidth,kScreenHeight) style:(UITableViewStylePlain)];
    self.setTableView.delegate = self;
    self.setTableView.dataSource = self;
    self.setTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView addSubview:self.setTableView];
    
    self.setTableView.hidden = YES;
    self.setTableView.userInteractionEnabled = NO;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.setTableView) {
        return 3;
    }
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.setTableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"setTableViewCell"];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"setTableViewCell"];
        }
        cell.backgroundColor = [UIColor lightGrayColor];
        cell.alpha = 0.5;
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SystemSettingsTableViewCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"SystemSettingsTableViewCell"];
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"系统设置";
        
    } else if (indexPath.row == 1) {
        
        cell.textLabel.text = @"皮肤更换";
        
    } else if (indexPath.row == 3) {
        
        cell.textLabel.text = @"清除缓存";
        
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
        CGFloat number = [self getSize];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2fM", number];
        
    } else if (indexPath.row == 2) {
        
        cell.textLabel.text = @"账户与安全";
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView == self.SystemSettingsTableView) {
        
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
        self.SystemSettingsTableView.hidden = YES;
        self.SystemSettingsTableView.userInteractionEnabled = YES;
        
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
        self.SystemSettingsTableView.hidden = NO;
        self.SystemSettingsTableView.userInteractionEnabled = YES;
        
    } else if (indexPath.row == 3) {
        
        SystemSettingsTableViewController *SystemSTVC = [[SystemSettingsTableViewController alloc] init];
        [self.navigationController pushViewController:SystemSTVC animated:YES];
        
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




//#pragma mark 遍历文件夹获得文件夹大小，返回多少M
//- (float)folderSizeAtPath:(NSString*)folderPath {
//
//    NSFileManager *manager = [NSFileManager defaultManager];
//
//    if (![manager fileExistsAtPath:folderPath]) return 0;
//
//    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
//
//    NSString *fileName;
//
//    long long folderSize = 0;
//
//    while ((fileName = [childFilesEnumerator nextObject]) != nil){
//
//        NSString *fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
//
//        folderSize += [self fileSizeAtPath:fileAbsolutePath];
//
//    }
//
//    return folderSize / (1024.0) / (1024.0);
//
//}

#pragma mark 清理缓存成功
- (void)clearCacheSuccess
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"清除缓存成功" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    
    [alert show];
    
    [self performSelector:@selector(removeAlertView:) withObject:alert afterDelay:0.3];
}

- (void)removeAlertView:(UIAlertView *)alertView
{
    //alertView消失
    [alertView dismissWithClickedButtonIndex:0 animated:YES];
}

#pragma mark 获得缓存文件大小
- (float)getSize
{
    return [[SDImageCache sharedImageCache] getSize] / 1024.0 / 1024.0;
}

#pragma mark 返回单个文件的大小
- (long long) fileSizeAtPath:(NSString *)filePath {
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:filePath]){
        
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
        
    }
    
    return 0;
    
}



@end
