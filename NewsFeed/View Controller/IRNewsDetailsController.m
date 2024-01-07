//
//  IRNewsDetailsController.m
//  NewsFeed
//
//  Created by Chandan Kumar on 06/01/24.
//

#import "IRNewsDetailsController.h"
#import <SafariServices/SafariServices.h>

@interface IRNewsDetailsController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *NewsImageView;
@property (weak, nonatomic) IBOutlet UILabel *newsContentView;
@property (weak, nonatomic) IBOutlet UITextView *newsURL;

@end

@implementation IRNewsDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpView];
}

- (void)setUpView
{
    self.NewsImageView.image = self.newsCellVM.newsArticleImage;
    self.newsContentView.text = self.newsCellVM.newsContent;
    self.newsURL.attributedText = [self newsDetailsHyperLink:self.newsCellVM.newsURL];
}

- (NSAttributedString *)newsDetailsHyperLink:(NSString *)urlStr
{
    NSURL *URL = [NSURL URLWithString: urlStr];
    NSMutableAttributedString * str = [[NSMutableAttributedString alloc] initWithString:@"Read More Details From Here!"];
    [str addAttribute: NSLinkAttributeName value:URL range: NSMakeRange(0, str.length)];
    return str;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction
{
    SFSafariViewController *safariViewController = [[SFSafariViewController alloc] initWithURL:URL];
    [self presentViewController:safariViewController animated:true completion:nil];
    return false;
}

@end
