//
//  General+CoreDataProperties.h
//  
//
//  Created by tang on 2018/10/19.
//
//

#import "General+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface General (CoreDataProperties)

+ (NSFetchRequest<General *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *liftStory;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *picName;
@property (nullable, nonatomic, copy) NSString *sex;
@property (nullable, nonatomic, copy) NSString *star;

@end

NS_ASSUME_NONNULL_END
