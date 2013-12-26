//
//  WZCommentListViewController.m
//  Abalone
//
//  Created by 吾在 on 13-4-24.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZCommentListViewController.h"
#import "WZAddCommentCell.h"
#import "WZComment.h"
#import "WZCommentCell.h"
#import "UITextView+Zoom.h"
#import "WZUser+Me.h"

@interface WZCommentListViewController ()
@property NSMutableArray *comments;
@end

static NSString *const addCommentcellIdentifier = @"addCommentCell";
static NSString *const commentcellIdentifier = @"commentCell";

@implementation WZCommentListViewController



-(void)updateViews
{
    self.comments = [NSMutableArray arrayWithArray:[self.merchant.comments allObjects]];
    [self.comments sortUsingComparator:^(WZComment *c1,WZComment *c2){
        return [c2.createdAt compare:c1.createdAt];
    }];
    NSLog(@"COMMET%i",self.comments.count);
//    NSLog(@"self.merchant.comments allObjects %i",[self.merchant.comments allObjects count ]);
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.scrollEnabled = NO;
    [self.tableView setSeparatorColor:[UIColor lightGrayColor]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
     
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    
    
    
    NSBundle *classBundle = [NSBundle bundleForClass:[WZAddCommentCell class]];
    UINib *nib = [UINib nibWithNibName:@"AddComment" bundle:classBundle];
    [self.tableView registerNib:nib forCellReuseIdentifier:addCommentcellIdentifier];
    
     NSBundle *classBundle2 = [NSBundle bundleForClass:[WZCommentCell class]];
    UINib *nib2 = [UINib nibWithNibName:@"CommentCell" bundle:classBundle2];
    [self.tableView registerNib:nib2 forCellReuseIdentifier:commentcellIdentifier];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.comments.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:addCommentcellIdentifier];
        if ([cell isKindOfClass:[WZAddCommentCell class]]) {
            WZAddCommentCell *commentCell = (WZAddCommentCell *)cell;
            [commentCell.commentButton addTarget:self action:@selector(goAddComment:) forControlEvents:UIControlEventTouchDown];
        }
    }else{
         cell = [tableView dequeueReusableCellWithIdentifier:commentcellIdentifier];
        WZComment *comment = [self.comments objectAtIndex:indexPath.row-1];
        if ([cell isKindOfClass:[WZCommentCell class]]) {
            WZCommentCell *commentCell = (WZCommentCell *)cell;
            NSDateFormatter *formater = [NSDateFormatter new];
            [formater setDateFormat:@"yyyy年MM月dd日  HH时mm分"];
            NSString *timeStr = [formater stringFromDate:comment.createdAt];
            commentCell.commentTitleLabel.text = [NSString stringWithFormat:@"%@ 发表于 %@",((comment.commenterName)?(comment.commenterName):comment.user.username),timeStr];
            commentCell.commentTextView.text = comment.content;
//            UIImage *image = commentCell.cellbackgroundView.image;
//           image =[image resizableImageWithCapInsets:UIEdgeInsetsMake(30, 20, 20, 20)];
            
            if (comment.user.faceIcon)
            {
                commentCell.userIconView.imageURL = [NSURL URLWithString:comment.user.faceIcon];

            }
            else
            {
                commentCell.userIconView.image = [UIImage imageNamed:@"defAvatar.png"];
            }

            
//            commentCell.cellbackgroundView.image = image;
//            CGRect frame = commentCell.cellbackgroundView.frame;
//            frame.origin.y = commentCell.commentTextView.frame.origin.y + commentCell.commentTextView.frame.size.height+5;
//            frame.size.height = 1;
//            [commentCell.cellbackgroundView setFrame:frame];
        }
    }
    
    return cell;
}

-(void)goAddComment:(id)sender
{
    [self.parentViewController performSegueWithIdentifier:@"addComment" sender:nil];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 44;
    }else{
        NSString *text = ((WZComment*)[self.comments objectAtIndex:indexPath.row-1]).content;
        CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(310, 999999) lineBreakMode:NSLineBreakByWordWrapping];
        return size.height + 62;
    }
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        if ([WZUser me]) {
            [self.parentViewController performSegueWithIdentifier:@"addComment" sender:nil];
        }else{
            [self.parentViewController performSegueWithIdentifier:@"goLogin" sender:nil];
        }
    }
}

@end
