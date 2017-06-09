//
//  ViewController.m
//  YHAudio
//
//  Created by harry on 2017/6/7.
//  Copyright © 2017年 harry. All rights reserved.
//

#import "ViewController.h"
#import "homeModel.h"

#import "PlayShortSoundVC.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *modelArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"关于播放声音的封装";
    
    self.tableView.frame = self.view.bounds;
    
    [self setupModelArray];
}

#pragma mark - 延迟加载 begin
- (UITableView *)tableView
{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self.view addSubview:tableView];
        _tableView = tableView;
        
        tableView.delegate = self;
        tableView.dataSource = self;
    }
    
    return _tableView;
}

- (NSMutableArray *)modelArray
{
    if (!_modelArray) {
        NSMutableArray *modelArray = [NSMutableArray array];
        _modelArray = modelArray;
    }
    return _modelArray;
}

#pragma mark - 私有工具 begin
/** 添加一个数据模型 */
- (void)addModel:(homeModel *)homeModel
{
    [self.modelArray addObject:homeModel];
    [self.tableView reloadData];
}
- (void)addModelWithTitle:(NSString *)title subTitle:(NSString *)subTitle tarClass:(Class)tarClass
{
    homeModel *model = [homeModel modelWithTitle:title subTitle:subTitle tarClass:tarClass];
    [self addModel:model];
}

/** 添加数据模型数组 */
- (void)setupModelArray
{
    // 播放短时间声音的控制器
    [self addModelWithTitle:@"播放提示音效" subTitle:@"可以选择震动或不振动" tarClass:[PlayShortSoundVC class]];
}

#pragma mark - UITableViewDataSource begin
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"CELL_ID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    
    homeModel *model = self.modelArray[indexPath.row];
    
    cell.textLabel.text = model.title;
    cell.detailTextLabel.text = model.subTiele;
    
    return cell;
}
#pragma mark - UITableViewDataSource end


#pragma mark - UITableViewDelegate begin
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    homeModel *model = self.modelArray[indexPath.row];
    
    if (model.tarClass) {[self.navigationController pushViewController:[[model.tarClass alloc] init] animated:YES];}
}
#pragma mark - UITableViewDelegate end


@end
