//
//  TZLCoreDataManager.h
//  Demos
//
//  Created by tang on 2018/10/19.
//  Copyright © 2018年 TZL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "General+CoreDataClass.h"
#import "General+CoreDataProperties.h"

@interface TZLCoreDataManager : NSObject
+ (NSManagedObjectContext *)getManagedObjectContext;
@end
