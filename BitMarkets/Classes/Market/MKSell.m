//
//  MKSell.m
//  Bitmessage
//
//  Created by Steve Dekorte on 3/21/14.
//  Copyright (c) 2014 Bitmarkets.org. All rights reserved.
//

#import "MKSell.h"
#import <NavKit/NavKit.h>
#import <BitmessageKit/BitmessageKit.h>

@implementation MKSell

- (id)init
{
    self = [super init];
    self.date = [NSDate date];
    
    self.uuid = [NSUUID UUID];
    
    self.title = @"";
    self.price = @0;
    self.description = @"";
    
    self.regionPath = @[@"North America", @"United States"];
    self.categoryPath = @[@"Electronics"];
    self.sellerAddress = @"sellerAddress";
    
    self.status = @"Draft";
    return self;
}

- (NSArray *)modelActions
{
    return [NSArray arrayWithObjects:@"delete", nil];
}

- (NSString *)nodeTitle
{
    return self.title;
}

- (NSString *)nodeSubtitle
{
    return self.status;
}

- (NSString *)nodeNote
{
    return self.date.itemDateString;
}

- (CGFloat)nodeSuggestedWidth
{
    return 0;
}

- (void)delete
{
    [self.nodeParent removeChild:self];
}

- (NSDictionary *)dict
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:self.title forKey:@"title"];
    [dict setObject:self.price forKey:@"price"];
    [dict setObject:@"BTC" forKey:@"currency"];
    [dict setObject:self.description forKey:@"description"];
    [dict setObject:self.regionPath forKey:@"regionPath"];
    [dict setObject:self.categoryPath forKey:@"categoryPath"];
    [dict setObject:self.sellerAddress forKey:@"sellerAddress"]; // Bitmessage address?
    
    return dict;
}

- (void)post
{
    NSString *channelAddress;
    
    BMMessage *m = [[BMMessage alloc] init];
    [m setFromAddress:self.sellerAddress];
    [m setToAddress:channelAddress];
    [m setSubject:self.title];
    [m setMessage:self.dict.description];
    [m send];
}


@end
