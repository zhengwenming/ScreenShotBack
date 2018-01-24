
/*!
 @header DetailViewController.m
 
 @abstract  作者Github地址：https://github.com/zhengwenming
            作者CSDN博客地址:http://blog.csdn.net/wenmingzheng
 
 @author   Created by zhengwenming on  16/3/13
 
 @version 1.00 16/3/13 Creation(版本信息)
 
   Copyright © 2016年 zhengwenming. All rights reserved.
 */

#import "DetailViewController.h"

@interface DetailViewController (){
    UITableView *nearbyTable;
    NSMutableArray *dataSource;
}

@end

@implementation DetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =  @"详情页";
    self.view.backgroundColor = [UIColor whiteColor];
    
    dataSource  = [[NSMutableArray alloc]init];
    for (NSUInteger i = 0; i<100; i++) {
        [dataSource addObject:[NSString stringWithFormat:@"%ld",i]];
    }
    self.view.backgroundColor = [UIColor blackColor];
    [super viewDidLoad];
    [self initTable];
}
-(void)initTable{
    nearbyTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
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

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSLog(@"UITableViewCellEditingStyleDelete");
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}


-(void)dealloc{
    NSLog(@"DetailViewController dealloc");
}
@end
