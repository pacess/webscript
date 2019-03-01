//
//  Rules.h
//  Web Script
//
//  Created by Pacess HO on 1/3/2019.
//  Copyright © 2019 Pacess Studio. All rights reserved.
//

//------------------------------------------------------------------------------
//  0    1         2         3         4         5         6         7         8
//  5678901234567890123456789012345678901234567890123456789012345678901234567890

#import <Foundation/Foundation.h>

//------------------------------------------------------------------------------
typedef enum  {
	RULES_TYPE_UNDEFINED = 0,
	RULES_TYPE_REQUEST,
	RULES_TYPE_RESPONSE,
}  RULES_TYPE;

//==============================================================================
@interface Rules : NSObject  {
	NSString *_domain;
	NSString *_path;

	NSInteger _type;

	NSString *_search;
	NSString *_replace;
}

//------------------------------------------------------------------------------
@property (nonatomic, strong) NSString *domain;
@property (nonatomic, strong) NSString *path;
@property (nonatomic, readwrite) NSInteger type;
@property (nonatomic, strong) NSString *search;
@property (nonatomic, strong) NSString *replace;

@end
