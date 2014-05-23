//
//  CCCouponTableViewCell.m
//  CouplesCoupons
//
//  Created by eProximiti 10 on 5/22/14.
//  Copyright (c) 2014 Aaron.RIetschlin. All rights reserved.
//

#import "CCCouponTableViewCell.h"

@implementation CCCouponTableViewCell

@synthesize nameLabel = _nameLabel;
@synthesize detailLabel = _detailLabel;
@synthesize imageView = _imageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) awakeFromNib{
    
}

@end
