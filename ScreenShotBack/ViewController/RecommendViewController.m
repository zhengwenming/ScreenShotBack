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
@interface RecommendViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *dataSource;
}
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation RecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dataSource = [@[@"进入关闭（手势返回）的VC",@"进入打开（手势返回）的VC"] mutableCopy];
    
    _table.rowHeight = 60;
    _table.tableFooterView = [UIView new];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataSource.count;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"测试";
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = dataSource[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row==0) {
        
        NonPanGestureViewController *nonPanGesVC = [[NonPanGestureViewController alloc]init];
#if kUseFullScreenGesture
        nonPanGesVC.fd_interactivePopDisabled = YES;
#endif
        
        [self.navigationController pushViewController:nonPanGesVC animated:YES];
    }else{
        [self.navigationController pushViewController:[[PanGestureViewController alloc] init] animated:YES];
    }
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
