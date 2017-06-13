//
//  StoreManager.h
//  CatTodo
//
//  Created by Shuyuan Shi on 6/12/17.
//  Copyright © 2017 CatTodo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreManager : NSObject
+ (NSArray *) getTodos;
+ (void) addTodo:(NSDictionary *) todo;
@end
