//
//  SHLogger.h
//  Core
//
//  Created by sheely.paean.Nightshade on 12/11/13.
//  Copyright (c) 2013 zywang. All rights reserved.
//

#import <Foundation/Foundation.h>

#define  LOG_RECORD @"log_record"

@interface SHLogger : NSObject

+(void) Log:(NSString*)log;

@end

