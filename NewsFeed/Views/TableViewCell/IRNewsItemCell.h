//
//  IRNewsItemCell.h
//  NewsFeed
//
//  Created by Chandan Kumar on 06/01/24.
//

#import <UIKit/UIKit.h>
#import "IRNewsCellViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface IRNewsItemCell : UITableViewCell

@property (nonatomic) IRNewsCellViewModel *cellViewModel;

@end

NS_ASSUME_NONNULL_END
