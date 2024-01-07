//
//  IRNewsArticles.h
//  NewsFeed
//
//  Created by Chandan Kumar on 06/01/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IRNewsArticles : NSObject

@property (nonatomic, copy) NSString *newsTitle;
@property (nonatomic, copy) NSString *newsDescription;
@property (nonatomic, copy) NSString *newsURL;
@property (nonatomic, copy) NSString *newsImageURL;
@property (nonatomic, copy) NSString *newsPublishedDate;
@property (nonatomic, copy) NSString *newsContent;

+ (id)objectFromJSON:(NSDictionary *)json;

@end

NS_ASSUME_NONNULL_END
