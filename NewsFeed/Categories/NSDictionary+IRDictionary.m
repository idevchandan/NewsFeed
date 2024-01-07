//
//  NSDictionary+IRDictionary.m
//  NewsFeed
//
//  Created by Chandan Kumar on 06/01/24.
//

#import "NSDictionary+IRDictionary.h"

@implementation NSDictionary (IRDictionary)

- (id)safeValueForKey:(NSString *)key
{
    id value = [self valueForKey:key];
    if (value && value != [NSNull null] && ![self isEmptyDictionary:value] ) {
        return value;
    }
    return nil;
}

- (BOOL)isEmptyDictionary:(id)value
{
    return ([value isKindOfClass:[NSDictionary class]] && ([(NSDictionary *)value count] == 0));
}

@end
