//
//  ViewController.h
//  ExampleNSURLSession
//
//  Created by Anatoly Ryavkin on 19.10.2020.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;
@property (weak, nonatomic) IBOutlet UIImageView *imageView4;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *arrrayImageViews;

- (IBAction)actionLoadSync:(id)sender;
- (IBAction)actionLoadAsync:(id)sender;
- (IBAction)actionDel:(id)sender;

@end

