//
//  IRNewsCellViewModel.h
//  NewsFeed
//
//  Created by Chandan Kumar on 06/01/24.
//

#import <UIKit/UIKit.h>
#import "IRNewsArticles.h"

NS_ASSUME_NONNULL_BEGIN

@interface IRNewsCellViewModel : NSObject

@property (nonatomic, readonly) NSString *newsTitle;
@property (nonatomic, readonly) NSString *newsDescription;
@property (nonatomic, readonly) NSString *newsURL;
@property (nonatomic, readonly) NSString *newsImageURL;
@property (nonatomic, readonly) NSString *newsPublishedDate;
@property (nonatomic, readonly) NSString *newsContent;
@property (nonatomic, readonly) UIImage *newsArticleImage;

- (instancetype)initWithModel:(IRNewsArticles *)newsArticle forCellIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
