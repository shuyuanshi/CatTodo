//
//  StoreManager.m
//  CatTodo
//
//  Created by Shuyuan Shi on 6/12/17.
//  Copyright © 2017 CatTodo. All rights reserved.
//

#import "StoreManager.h"

@implementation StoreManager

+ (NSArray *) getTodos
{
  NSArray *todos = [[NSUserDefaults standardUserDefaults] objectForKey:@"todos"];
  if (!todos) {
    return [[NSArray alloc] init];
  }
  else {
    return todos;
  }
}

+ (void) addTodo:(NSDictionary *) todo
{
  NSMutableArray *todos = [[StoreManager getTodos] mutableCopy];
  [todos insertObject:todo atIndex:0];
  [[NSUserDefaults standardUserDefaults] setObject:todos forKey:@"todos"];
}

@end
