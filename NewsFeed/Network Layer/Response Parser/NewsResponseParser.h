//
//  NewsResponseParser.h
//  NewsFeed
//
//  Created by Chandan Kumar on 06/01/24.
//

#import <Foundation/Foundation.h>

@class IRNewsResponse;

NS_ASSUME_NONNULL_BEGIN

@interface NewsResponseParser : NSObject

+ (IRNewsResponse *)newsParsedFromJSON:(NSDictionary *)json;

@end

NS_ASSUME_NONNULL_END
