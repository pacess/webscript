//
//  ViewController.h
//  WhatsApp
//
//  Created by Pacess HO on 28/2/2019.
//  Copyright © 2019 Pacess Studio. All rights reserved.
//

//------------------------------------------------------------------------------
//  0    1         2         3         4         5         6         7         8
//  5678901234567890123456789012345678901234567890123456789012345678901234567890

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

//==============================================================================
@interface ViewController : UIViewController <UITextFieldDelegate, WKNavigationDelegate>  {
	UIButton *_forwardButton;
	UIButton *_reloadButton;
	UIButton *_backButton;
	UIButton *_goButton;

	UITextField *_urlField;
	UITextView *_htmlView;

	WKWebView *_webview;

	UIView *_browserView;
	UIView *_scriptView;

	NSString *_currentURLString;
	NSMutableArray *_ruleArray;
}

//------------------------------------------------------------------------------
@property (nonatomic, strong) NSString *currentURLString;

//------------------------------------------------------------------------------
- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator;

- (BOOL)textFieldShouldReturn:(UITextField *)textField;

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation;

- (BOOL)detectVerticalLayout:(CGSize)size;
- (void)resizeLayout:(CGSize)size;
- (void)loadURL:(NSString *)urlString;
- (void)loadRules;
- (NSString *)applyPostRules:(NSString *)htmlString forURL:(NSString *)urlString;
- (void)buttonClicked:(UIButton *)button;

@end
