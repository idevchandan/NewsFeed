//
//  IRNetworkManager.h
//  NewsFeed
//
//  Created by Chandan Kumar on 06/01/24.
//

#import <Foundation/Foundation.h>

@class RACSignal;

NS_ASSUME_NONNULL_BEGIN

@interface IRNetworkManager : NSObject

+ (RACSignal *)fetchDataFromAPI;

@end

NS_ASSUME_NONNULL_END
