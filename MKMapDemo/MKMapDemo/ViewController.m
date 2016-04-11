//
//  ViewController.m
//  MKMapDemo
//
//  Created by huangjiong on 16/4/10.
//  Copyright © 2016年 huangjiong. All rights reserved.
//

#import "ViewController.h"
#import "HJUpdateLocationCtl.h"
#import "HJMapViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArr;

@end

@implementation ViewController

-(NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}

-(UITableView *)tableView
{
    if (_tableView == nil) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64 - 49) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
//        [tableView registerNib:[UINib nibWithNibName:@"" bundle:nil] forCellReuseIdentifier:@"Cell"];
        
        [self.view addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self createDatas];
}

-(void)createDatas
{
    [self.dataArr addObject:@"定位功能"];
    [self.dataArr addObject:@"地图展示"];
    [self.tableView reloadData];
}



#pragma mark - UITableViewDataSource, UITableViewDelegate
/**
 *  tableView代理方法
 */
//组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    NSString *title = self.dataArr[indexPath.row];
    cell.textLabel.text = title;
    
    return cell;
}

//点击cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            HJUpdateLocationCtl *ctl = [[HJUpdateLocationCtl alloc] init];
            [self.navigationController pushViewController:ctl animated:YES];
        }
            break;
       case 1:
        {
            HJMapViewController *ctl = [[HJMapViewController alloc] init];
            [self.navigationController pushViewController:ctl animated:YES];
        }
        default:
            break;
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
