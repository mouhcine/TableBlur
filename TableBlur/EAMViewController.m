//
//  EAMViewController.m
//  TableBlur
//
//  Created by Mouhcine El Amine on 15/10/13.
//  Copyright (c) 2013 Mouhcine El Amine. All rights reserved.
//

#import "EAMViewController.h"
#import "EAMBlurredCell.h"

@interface EAMViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation EAMViewController

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 300;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EAMBlurredCell* cell = [tableView dequeueReusableCellWithIdentifier:@"TestCell"];
    if (!cell){
        cell = [[EAMBlurredCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TestCell"];
    }
    
    cell.tag = indexPath.row;
    cell.textLabel.text = @"TEST CELL";
    cell.textLabel.textColor = [UIColor whiteColor];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(EAMBlurredCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat offset =  cell.frame.origin.y;
    [cell setBlurredContentOffset:offset];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0f;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    for (EAMBlurredCell *cell in [self.tableView visibleCells]) {
        [cell setBlurredContentOffset:cell.frame.origin.y - scrollView.contentOffset.y];
    }
}


@end
