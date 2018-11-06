//
//  Entity+CoreDataProperties.h
//  
//
//  Created by tang on 2018/10/19.
//
//

#import "Entity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Entity (CoreDataProperties)

+ (NSFetchRequest<Entity *> *)fetchRequest;

@property (nonatomic) int64_t atk;
@property (nonatomic) int16_t career;
@property (nonatomic) int64_t defence;
@property (nonatomic) int64_t hp;
@property (nonatomic) int64_t hr;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *sex;

@end

NS_ASSUME_NONNULL_END
