//
//  IRNewsItemCell.m
//  NewsFeed
//
//  Created by Chandan Kumar on 06/01/24.
//

#import "IRNewsItemCell.h"
#import <Masonry/Masonry.h>
#import <ReactiveObjC/ReactiveObjC.h>

@interface IRNewsItemCell ()

@property (nonatomic) UIImageView *newsImageView;
@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UILabel *publishedDateLabel;
@property (nonatomic) UILabel *descriptionLabel;

@end

@implementation IRNewsItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self addSubViews];
    [self setupConstraints];
    [self setNewsArticleImage];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellViewModel:(IRNewsCellViewModel *)cellViewModel
{
    if (cellViewModel != nil) {
        if (cellViewModel != _cellViewModel) {
            _cellViewModel = cellViewModel;
            [self setCellContentWithViewModel];
        }
    }
}

- (UIImageView *)newsImageView
{
    if (!_newsImageView) {
        _newsImageView= [[UIImageView alloc] initWithFrame:CGRectZero];
        _newsImageView.contentMode = UIViewContentModeScaleAspectFit;
        [_newsImageView setBackgroundColor:[UIColor clearColor]];
    }
    
    return _newsImageView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:[UIFont systemFontSize] weight:UIFontWeightHeavy];
        _titleLabel.numberOfLines = 0;
        [_titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [_titleLabel sizeToFit];
    }
    
    return _titleLabel;
}

- (UILabel *)publishedDateLabel
{
    if (!_publishedDateLabel) {
        _publishedDateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _publishedDateLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _publishedDateLabel.textAlignment = NSTextAlignmentLeft;
        _publishedDateLabel.font = [UIFont systemFontOfSize:[UIFont systemFontSize] weight:UIFontWeightLight];
        _publishedDateLabel.numberOfLines = 0;
        [_publishedDateLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [_publishedDateLabel sizeToFit];
    }
    
    return _publishedDateLabel;
}

- (UILabel *)descriptionLabel
{
    if (!_descriptionLabel) {
        _descriptionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _descriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _descriptionLabel.textAlignment = NSTextAlignmentLeft;
        _descriptionLabel.font = [UIFont systemFontOfSize:[UIFont systemFontSize] weight:UIFontWeightMedium];
        _descriptionLabel.numberOfLines = 2;
        [_descriptionLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        [_descriptionLabel sizeToFit];
    }
    
    return _descriptionLabel;
}

- (void)setCellContentWithViewModel
{
    self.titleLabel.text = self.cellViewModel.newsTitle;
    self.publishedDateLabel.text = self.cellViewModel.newsPublishedDate;
    self.descriptionLabel.text = self.cellViewModel.newsDescription;
    self.newsImageView.image = self.cellViewModel.newsArticleImage;
}

- (void)addSubViews
{
    [self.contentView addSubview:self.newsImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.publishedDateLabel];
    [self.contentView addSubview:self.descriptionLabel];
}

- (void)setupConstraints
{
    [self.newsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView.mas_leading).offset(5);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(120);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(20);
        make.leading.equalTo(self.newsImageView.mas_trailing).offset(5);
        make.trailing.equalTo(self.contentView.mas_trailing).offset(-5);
    }];
    
    [self.publishedDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
        make.leading.equalTo(self.newsImageView.mas_trailing).offset(5);
        make.trailing.equalTo(self.contentView.mas_trailing).offset(-5);
    }];
    
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.publishedDateLabel.mas_bottom).offset(5);
        make.leading.equalTo(self.newsImageView.mas_trailing).offset(5);
        make.trailing.equalTo(self.contentView.mas_trailing).offset(-5);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
    
}

- (void)setNewsArticleImage
{
    @weakify(self);
    [[[[RACObserve(self, cellViewModel.newsArticleImage) ignore:nil] distinctUntilChanged] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.newsImageView setImage:x];
    }];
}

@end
