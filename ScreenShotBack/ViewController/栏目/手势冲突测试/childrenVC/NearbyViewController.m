
/*!
 @header NearbyViewController.m
 
 @abstract  作者Github地址：https://github.com/zhengwenming
            作者CSDN博客地址:http://blog.csdn.net/wenmingzheng
 
 @author   Created by zhengwenming on  16/3/13
 
 @version 1.00 16/3/13 Creation(版本信息)
 
   Copyright © 2016年 zhengwenming. All rights reserved.
 */

#import "NearbyViewController.h"
#import "DetailViewController.h"
@interface NearbyViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *nearbyTable;
    NSMutableArray *dataSource;
}

@end

@implementation NearbyViewController

- (void)viewDidLoad {
    dataSource  = [[NSMutableArray alloc]init];
    for (NSUInteger i = 0; i<20; i++) {
        [dataSource addObject:[NSString stringWithFormat:@"%ld",i]];
    }
    self.view.backgroundColor = [UIColor blackColor];
    [super viewDidLoad];
    [self initTable];
}
-(void)initTable{
    nearbyTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    nearbyTable.delegate = self;
    nearbyTable.dataSource = self;
    nearbyTable.rowHeight = 50;
    [self.view addSubview:nearbyTable];
    nearbyTable.tableFooterView = [UIView new];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifer = @"cell";
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%@行，点击后push页面",dataSource[indexPath.row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailViewController *detailVC = [[DetailViewController alloc]init];
    [self.navigationController pushViewController:detailVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

-(void)dealloc{
    NSLog(@"%s dealloc",object_getClassName(self));
}

@end
