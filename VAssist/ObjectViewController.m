//
//  ObjectViewController.m
//  VAssist
//
//  Created by Jeyabalaji T M on 13/11/16.
//  Copyright © 2016 Ant and Buffalo. All rights reserved.
//

#import "ObjectViewController.h"

@interface ObjectViewController ()

@property (weak, nonatomic) IBOutlet UINavigationItem *navTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblMessage;

@end

@implementation ObjectViewController

- (IBAction)closeModal:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navTitle.title = self.vcTitle;
    self.lblMessage.text = self.message;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
