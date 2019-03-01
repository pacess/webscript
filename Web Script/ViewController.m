//
//  ViewController.m
//  WhatsApp
//
//  Created by Pacess HO on 28/2/2019.
//  Copyright © 2019 Pacess Studio. All rights reserved.
//

//------------------------------------------------------------------------------
//  0    1         2         3         4         5         6         7         8
//  5678901234567890123456789012345678901234567890123456789012345678901234567890

#import "ViewController.h"
#import "Rules.h"

//------------------------------------------------------------------------------
#define VIEWCONTROLLER_VALUE_URL							@"https://www.facebook.com/"
#define VIEWCONTROLLER_KEY_URL								@"currentURL"

//------------------------------------------------------------------------------
typedef enum  {
	VIEWCONTROLLER_TAG_UNDEFINED = 0,
	VIEWCONTROLLER_TAG_BACK,
	VIEWCONTROLLER_TAG_FORWARD,
	VIEWCONTROLLER_TAG_RELOAD,
	VIEWCONTROLLER_TAG_URL,
	VIEWCONTROLLER_TAG_GO,
}  VIEWCONTROLLER_TAG;

//==============================================================================
@implementation ViewController

//------------------------------------------------------------------------------
@synthesize currentURLString = _currentURLString;

//------------------------------------------------------------------------------
static NSString *_userAgent = @"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_2) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/12.0.2 Safari/605.1.15";
static BOOL _isVerticalLayout = NO;

//------------------------------------------------------------------------------
//  Do any additional setup after loading the view, typically from a nib.
- (void)viewDidLoad  {
	[super viewDidLoad];

//	CGRect rect;
	UIView *uiview;
	UIButton *button;
	UITextField *textField;
	[self.view setBackgroundColor:[UIColor clearColor]];

	[self loadRules];

	//------------------------------------------------------------------------------
	//  Browser view not created yet, do it now
	if (_browserView == nil)  {

		uiview = [[UIView alloc] initWithFrame:self.view.frame];
		[uiview setBackgroundColor:[UIColor whiteColor]];
		[self.view addSubview:uiview];
		_browserView = uiview;

		//  Back button
//		rect.origin.x = 5;
//		rect.origin.y = 0;
//		rect.size.width = 32;
//		rect.size.height = 32;

		button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//		[button setFrame:rect];
		[button setTag:VIEWCONTROLLER_TAG_BACK];
		[button setBackgroundColor:[UIColor whiteColor]];
		[button setTitle:@"◀︎" forState:UIControlStateNormal];
		[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		[button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
		[_browserView addSubview:button];
		_backButton = button;

		//  Forward button
//		rect.origin.x += 5+rect.size.width;

		button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//		[button setFrame:rect];
		[button setTag:VIEWCONTROLLER_TAG_FORWARD];
		[button setBackgroundColor:[UIColor whiteColor]];
		[button setTitle:@"▶︎" forState:UIControlStateNormal];
		[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		[button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
		[_browserView addSubview:button];
		_forwardButton = button;

		//  Reload button
//		rect.origin.x += 5+rect.size.width;

		button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//		[button setFrame:rect];
		[button setTag:VIEWCONTROLLER_TAG_RELOAD];
		[button setBackgroundColor:[UIColor whiteColor]];
		[button setTitle:@"🔄" forState:UIControlStateNormal];
		[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		[button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
		[_browserView addSubview:button];
		_reloadButton = button;

		//  Go button
//		rect.origin.x = _browserView.frame.size.width-5-rect.size.width;

		button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//		[button setFrame:rect];
		[button setTag:VIEWCONTROLLER_TAG_GO];
		[button setBackgroundColor:[UIColor whiteColor]];
		[button setTitle:@"🆗" forState:UIControlStateNormal];
		[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		[button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
		[_browserView addSubview:button];
		_goButton = button;

		textField = [[UITextField alloc] initWithFrame:CGRectZero];
		[textField setDelegate:self];
		[textField setTag:VIEWCONTROLLER_TAG_URL];
		[textField setPlaceholder:@"Enter URL here..."];
		[textField setClearButtonMode:UITextFieldViewModeWhileEditing];
		[textField setAllowsEditingTextAttributes:NO];
		[_browserView addSubview:textField];
		_urlField = textField;

		//  Webview
//		NSURL *url = [NSURL URLWithString:@"https://www.apple.com/"];
//		NSURLRequest *request = [NSURLRequest requestWithURL:url];
//
//		NSURLResponse *response = nil;
//		NSError *error = nil;
//		NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//		NSString *htmlString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//
//		htmlString = [htmlString stringByReplacingOccurrencesOfString:@"iPhone" withString:@"iPacess"];

//		rect.origin.x = 0;
//		rect.origin.y = rect.size.height+5;
//		rect.size.width = _browserView.frame.size.width;
//		rect.size.height = _browserView.frame.size.height;

		WKWebView *webview = [[WKWebView alloc] initWithFrame:CGRectZero];
		[webview setNavigationDelegate:self];
		[webview setCustomUserAgent:_userAgent];
//		[webview loadHTMLString:htmlString baseURL:url];
		[_browserView addSubview:webview];
		_webview = webview;
	}

	//------------------------------------------------------------------------------
	//  Create script view
	if (_scriptView == nil)  {

		uiview = [[UIView alloc] initWithFrame:self.view.frame];
		[uiview setBackgroundColor:[UIColor blueColor]];
		[self.view addSubview:uiview];
		_scriptView = uiview;

		UITextView *textView = [[UITextView alloc] initWithFrame:CGRectZero];
		[textView setBackgroundColor:[UIColor blackColor]];
		[textView setTextColor:[UIColor whiteColor]];
		[_scriptView addSubview:textView];
		_htmlView = textView;
	}

	//------------------------------------------------------------------------------
	NSString *urlString = [[NSUserDefaults standardUserDefaults] objectForKey:VIEWCONTROLLER_KEY_URL];
	if (urlString == nil)  {urlString = VIEWCONTROLLER_VALUE_URL;}

	[_urlField setText:urlString];
	[self loadURL:urlString];
	[self resizeLayout:self.view.frame.size];
}

//------------------------------------------------------------------------------
//  Dispose of any resources that can be recreated.
- (void)didReceiveMemoryWarning  {
	[super didReceiveMemoryWarning];
}

//------------------------------------------------------------------------------
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator  {
//	BOOL isVertical = [self detectVerticalLayout];
//	if (isVertical == true)  {
//
//		//  It is vertical layout
//		return;
//	}
//
//	//  It is horizontal layout
//	[_webview setFrame:CGRectMake(0, 0, size.width, size.height)];

	[self resizeLayout:size];
}

//------------------------------------------------------------------------------
- (BOOL)textFieldShouldReturn:(UITextField *)textField  {
	[textField resignFirstResponder];

	NSString *urlString = textField.text;
	[self loadURL:urlString];
	return YES;
}

//------------------------------------------------------------------------------
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation  {
	if ([navigation isKindOfClass:[WKNavigationAction class]] == NO)  {return;}

	[webView stopLoading];

	WKNavigationAction *action = (WKNavigationAction *)navigation;
	NSString *urlString = action.request.URL.absoluteString;
	[self loadURL:urlString];
}

//------------------------------------------------------------------------------
//  Determine horizontal or vertical layout
- (BOOL)detectVerticalLayout:(CGSize)size  {
	_isVerticalLayout = YES;

	CGFloat ratio = size.width/size.height;
	if (ratio > 1)  {_isVerticalLayout = NO;}
	NSLog(@"Vertical layout ratio: %.2f (%d)", ratio, _isVerticalLayout);

	return _isVerticalLayout;
}

//------------------------------------------------------------------------------
- (void)resizeLayout:(CGSize)size  {
	if (_browserView == nil)  {return;}
	if (_scriptView == nil)  {return;}

	CGRect rect;
	CGFloat padding = 5.0f;
	BOOL isVerticalLayout = [self detectVerticalLayout:size];

	//------------------------------------------------------------------------------
	//  Browser view
	rect.origin.x = 0;
	rect.origin.y = 0;
	if (isVerticalLayout == YES)  {
		
		rect.size.width = size.width;
		rect.size.height = (size.height*0.6f);
	}  else  {
		
		rect.size.width = (size.width*0.6f);
		rect.size.height = size.height;
	}
	[_browserView setFrame:rect];

	rect.size.width = 32;
	rect.size.height = 32;

	//  Update back button
	rect.origin.x = 0;
	rect.origin.y = 20;
	[_backButton setFrame:rect];

	//  Update forward button
	rect.origin.x += padding+rect.size.width;
	[_forwardButton setFrame:rect];

	//  Update reload button
	rect.origin.x += padding+rect.size.width;
	[_reloadButton setFrame:rect];

	CGFloat left = rect.origin.x+padding+rect.size.width;

	//  Update go button
	rect.origin.x = _browserView.frame.size.width-rect.size.width;
	[_goButton setFrame:rect];

	CGFloat right = rect.origin.x-padding;

	//  Update URL field
	rect.origin.x = left;
	rect.size.width = right-left;
	[_urlField setFrame:rect];

	//  Update webview
	rect.origin.x = 0;
	rect.origin.y = rect.size.height+rect.origin.y;
	rect.size.width = _browserView.frame.size.width;
	rect.size.height = _browserView.frame.size.height-rect.origin.y;
	[_webview setFrame:rect];
	
	//------------------------------------------------------------------------------
	//  Script view
	if (isVerticalLayout == YES)  {
		
		rect.origin.x = 0;
		rect.origin.y = _browserView.frame.size.height;
		rect.size.width = size.width;
		rect.size.height = size.height-rect.origin.y;
	}  else  {
		
		//  Horizontal layout
		rect.origin.x = _browserView.frame.size.width;
		rect.origin.y = 0;
		rect.size.width = size.width-rect.origin.x;
		rect.size.height = size.height;
	}
	[_scriptView setFrame:rect];

	//  Text view
	rect.origin.x = 0;
	rect.origin.y = 0;
	[_htmlView setFrame:rect];
}

//------------------------------------------------------------------------------
- (void)loadURL:(NSString *)urlString  {
	NSLog(@"Load URL: %@", urlString);
	NSURL *url = [NSURL URLWithString:urlString];
	NSURLRequest *request = [NSURLRequest requestWithURL:url];

	NSURLResponse *response = nil;
	NSError *error = nil;
	NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	NSString *htmlString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

	//  Apply rules
	htmlString = [self applyPostRules:htmlString forURL:urlString];

	//  Update user interface content
	[_webview loadHTMLString:htmlString baseURL:url];
	[_htmlView setText:htmlString];
	self.currentURLString = urlString;

	//  Save URL to preferences
	[[NSUserDefaults standardUserDefaults] setObject:urlString forKey:VIEWCONTROLLER_KEY_URL];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

//------------------------------------------------------------------------------
- (void)loadRules  {
	if (_ruleArray == nil)  {_ruleArray = [[NSMutableArray alloc] init];}
	[_ruleArray removeAllObjects];

	//  DEBUG: Hard coded rules
	Rules *rule = [[Rules alloc] init];
	rule.domain = @"www.fimmick.com";
	rule.path = nil;
	rule.type = RULES_TYPE_RESPONSE;
	rule.search = @"</body>";
	rule.replace = @"<script>window.location.href='https://bayer.fimmickapps.com/';</script></body>";
	[_ruleArray addObject:rule];

	rule = [[Rules alloc] init];
	rule.domain = @"bayer.fimmickapps.com";
	rule.path = nil;
	rule.type = RULES_TYPE_RESPONSE;
	rule.search = @"</body>";
	rule.replace = @"<script>window.location.href='https://www.google.com/';</script></body>";
	[_ruleArray addObject:rule];
}

//------------------------------------------------------------------------------
- (NSString *)applyPostRules:(NSString *)htmlString forURL:(NSString *)urlString  {

	NSURL *url = [NSURL URLWithString:urlString];
	for (Rules *rule in _ruleArray)  {

		if (rule.domain != nil && [url.host isEqualToString:rule.domain] == NO)  {continue;}
		if (rule.path != nil && [url.path isEqualToString:rule.path] == NO)  {continue;}

		NSLog(@"!!! Match rule [%@] => [%@]", rule.search, rule.replace);
		switch (rule.type)  {

			default:  break;

			case RULES_TYPE_RESPONSE:  {
				htmlString = [htmlString stringByReplacingOccurrencesOfString:rule.search withString:rule.replace];
			}  break;
		}
	}
	return htmlString;
}

//------------------------------------------------------------------------------
- (void)buttonClicked:(UIButton *)button  {
	VIEWCONTROLLER_TAG tag = (VIEWCONTROLLER_TAG)button.tag;
	switch (tag)  {
		default:  {
			NSLog(@"### Unhandled button: %d", tag);
		}  break;

		case VIEWCONTROLLER_TAG_RELOAD:  {
			[self loadURL:self.currentURLString];
		}  break;

		case VIEWCONTROLLER_TAG_GO:  {
			[_urlField resignFirstResponder];
	
			NSString *urlString = _urlField.text;
			[self loadURL:urlString];
		}  break;
	}
}

@end
