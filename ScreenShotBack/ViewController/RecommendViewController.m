//
//  RecommendViewController.m
//  ScreenShotBack
//
//  Created by 郑文明 on 16/5/10.
//  Copyright © 2016年 郑文明. All rights reserved.
//

#import "RecommendViewController.h"
#import "PanGestureViewController.h"
#import "NonPanGestureViewController.h"
#import "NonNavgationBarViewController.h"
@interface RecommendViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *dataSource;
}
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation RecommendViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    dataSource = @[@{@"带导航栏测试":@[@"进入关闭（手势返回）的VC",@"进入打开（手势返回）的VC"]},
                   @{@"隐藏导航栏测试":@[@"进入打开（手势返回）的VC"]}];
    _table.rowHeight = 60;
    _table.tableFooterView = [UIView new];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return dataSource.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSDictionary * dic = dataSource[section];
    NSArray *valuesArray = dic.allValues.firstObject;
    return valuesArray.count;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSDictionary * dic = dataSource[section];
    return dic.allKeys.firstObject;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NSDictionary * dic = dataSource[indexPath.section];
    NSArray *valuesArray = dic.allValues.firstObject;

    cell.textLabel.text = valuesArray[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            NonPanGestureViewController *nonPanGesVC = [[NonPanGestureViewController alloc]init];
            [self.navigationController pushViewController:nonPanGesVC animated:YES];
        }else{
            [self.navigationController pushViewController:[[PanGestureViewController alloc] init] animated:YES];
        }
    }else if (indexPath.section==1){
        [self.navigationController pushViewController:[[NonNavgationBarViewController alloc] init] animated:YES];
    }
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
