//
//  General+CoreDataProperties.m
//  
//
//  Created by tang on 2018/10/19.
//
//

#import "General+CoreDataProperties.h"

@implementation General (CoreDataProperties)

+ (NSFetchRequest<General *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"General"];
}

@dynamic liftStory;
@dynamic name;
@dynamic picName;
@dynamic sex;
@dynamic star;

@end
