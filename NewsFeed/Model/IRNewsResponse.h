//
//  IRNewsResponse.h
//  NewsFeed
//
//  Created by Chandan Kumar on 06/01/24.
//

#import <Foundation/Foundation.h>
#import "IRNewsArticles.h"

NS_ASSUME_NONNULL_BEGIN

@interface IRNewsResponse : NSObject

@property (nonatomic, assign) NSInteger totalNewsArticles;
@property (nonatomic, strong) NSArray<IRNewsArticles *> *newsArticles;

+ (id)objectFromJSON:(NSDictionary *)JSONValue;

@end

NS_ASSUME_NONNULL_END
