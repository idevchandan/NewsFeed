//
//  IRNewsFeedListViewModel.h
//  NewsFeed
//
//  Created by Chandan Kumar on 06/01/24.
//

#import <Foundation/Foundation.h>
#import "IRNewsCellViewModel.h"

typedef enum : NSUInteger
{
    IREndPointStarted,
    IRNewsDataFetchedWithSuccess,
    IRNewsDataFetchedWithError,
    IRNetworkNotAvailable,
    IRNetworkAvailable
} IRNewsArticleViewModelState;

NS_ASSUME_NONNULL_BEGIN

@interface IRNewsFeedListViewModel : NSObject

@property (nonatomic) IRNewsArticleViewModelState progressState;
@property (nonatomic, readonly) NSArray <IRNewsCellViewModel *> *newsCellModels;
@property (nonatomic) NSError *errors;
@property (nonatomic) BOOL isNetworkConnectionAvailable;

- (void)fetchNewsList;
- (void)setReachability;

@end

NS_ASSUME_NONNULL_END
