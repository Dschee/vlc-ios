//
//  VLCDropboxTableViewCell.m
//  VLC for iOS
//
//  Created by Felix Paul Kühne on 24.05.13.
//  Copyright (c) 2013 VideoLAN. All rights reserved.
//

#import "VLCDropboxTableViewCell.h"

@implementation VLCDropboxTableViewCell

+ (VLCDropboxTableViewCell *)cellWithReuseIdentifier:(NSString *)ident
{
    NSArray *nibContentArray = [[NSBundle mainBundle] loadNibNamed:@"VLCDropboxTableViewCell" owner:nil options:nil];
    NSAssert([nibContentArray count] == 1, @"meh");
    NSAssert([[nibContentArray lastObject] isKindOfClass:[VLCDropboxTableViewCell class]], @"meh meh");
    VLCDropboxTableViewCell *cell = (VLCDropboxTableViewCell *)[nibContentArray lastObject];
    CGRect frame = [cell frame];
    UIView *background = [[UIView alloc] initWithFrame:frame];
    background.backgroundColor = [UIColor colorWithWhite:.05 alpha:1.];
    cell.backgroundView = background;
    UIView *highlightedBackground = [[UIView alloc] initWithFrame:frame];
    highlightedBackground.backgroundColor = [UIColor colorWithWhite:.2 alpha:1.];
    cell.selectedBackgroundView = highlightedBackground;

    return cell;
}

- (void)setFileMetadata:(DBMetadata *)fileMetadata
{
    if (fileMetadata != _fileMetadata)
        _fileMetadata = fileMetadata;

    [self _updatedDisplayedInformation];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)_updatedDisplayedInformation
{
    self.titleLabel.text = self.fileMetadata.filename;
    self.subtitleLabel.text = (self.fileMetadata.totalBytes > 0) ? self.fileMetadata.humanReadableSize : @"";

    self.thumbnailView.image = [UIImage imageNamed:self.fileMetadata.icon];
    if (!self.thumbnailView.image)
        APLog(@"missing icon for type '%@'", self.fileMetadata.icon);

    [self setNeedsDisplay];
}

+ (CGFloat)heightOfCell
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
        return 80.;

    return 48.;
}

@end
