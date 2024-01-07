//
//  NSDictionary+IRDictionary.h
//  NewsFeed
//
//  Created by Chandan Kumar on 06/01/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (IRDictionary)

- (id)safeValueForKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
