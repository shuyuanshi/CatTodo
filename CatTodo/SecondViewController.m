//
//  SecondViewController.m
//  CatTodo
//
//  Created by Shuyuan Shi on 6/12/17.
//  Copyright © 2017 CatTodo. All rights reserved.
//

#import "SecondViewController.h"
#import "StoreManager.h"

@interface SecondViewController ()
@property (nonatomic) UITableView *todoTableView;
@end

@implementation SecondViewController
@synthesize todoTableView;

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  todoTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 20, self.view.frame.size.width - 20, self.view.frame.size.height - 49 - 20)];
  todoTableView.dataSource = self;
  todoTableView.delegate = self;
  self.view.backgroundColor = [UIColor blackColor];
  todoTableView.backgroundColor = [UIColor blackColor];
  todoTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
  [self.view addSubview:todoTableView];
}

- (void) viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  if (todoTableView)
    [todoTableView reloadData];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark UITableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
  }
  cell.layer.cornerRadius = 2.f;
  cell.backgroundColor = [UIColor lightGrayColor];
  cell.textLabel.text = [[[StoreManager getTodos] objectAtIndex:indexPath.section] objectForKey:@"event"];
  cell.detailTextLabel.text = [[[StoreManager getTodos] objectAtIndex:indexPath.section] objectForKey:@"date"];
  cell.userInteractionEnabled = NO;
  return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return [[StoreManager getTodos] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
  // space between cells
  return 3;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
  UIView *view = [UIView new];
  [view setBackgroundColor:[UIColor clearColor]];
  return view;
}

@end
