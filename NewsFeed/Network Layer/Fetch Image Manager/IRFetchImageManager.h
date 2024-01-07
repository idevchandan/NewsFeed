//
//  IRFetchImageManager.h
//  NewsFeed
//
//  Created by Chandan Kumar on 06/01/24.
//

#import <Foundation/Foundation.h>

@class RACSignal;

NS_ASSUME_NONNULL_BEGIN

@interface IRFetchImageManager : NSObject

+ (instancetype)sharedInstance;
- (RACSignal *) fetch:(NSURL *)url;

@end

NS_ASSUME_NONNULL_END
