//
//  Entity+CoreDataProperties.m
//  
//
//  Created by tang on 2018/10/19.
//
//

#import "Entity+CoreDataProperties.h"

@implementation Entity (CoreDataProperties)

+ (NSFetchRequest<Entity *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Entity"];
}

@dynamic atk;
@dynamic career;
@dynamic defence;
@dynamic hp;
@dynamic hr;
@dynamic name;
@dynamic sex;

@end
