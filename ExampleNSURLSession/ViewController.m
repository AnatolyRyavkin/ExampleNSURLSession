//
//  ViewController.m
//  ExampleNSURLSession
//
//  Created by Anatoly Ryavkin on 19.10.2020.
//

#import "ViewController.h"
#import "LoaderImages.h"

@interface ViewController ()

@property NSMutableArray<UIImage*>*arrayImage;
@property NSArray* arrayURL;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.arrayURL = [[NSArray alloc]initWithObjects:@"https://ancsgroup.ru/resources/000/000/000/001/583/1583325_1024x768.png",
                                                    @"https://i.pinimg.com/736x/79/83/76/7983766b4e9a19eaaaf3fc792cf20e1f.jpg",
                                                    @"https://moscow.sm-news.ru/wp-content/uploads/2019/10/14/sberbank.jpg",
                                                    @"https://akket.com/wp-content/uploads/2019/09/Mobilnyi-bank-Sberbank.jpg",
                                                    nil];
    self.arrayImage = [[NSMutableArray alloc]init];
    [self actionDel:nil];
}


- (IBAction)actionDel:(id)sender {
    for(int i=0;i<4;i++){
        UIImageView*imageView = [self.arrrayImageViews objectAtIndex:i];
        imageView.image = [UIImage imageNamed:@"Image"];
        self.arrayImage[i] = imageView.image;
    }
    [self.view reloadInputViews];
}

//ассинхронная загрузка

- (IBAction)actionLoadAsync:(id)sender {

    for (int i=0; i<4; i++) {
        dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
        [LoaderImages.Shared getImageFromURL: self.arrayURL[i]
                                     onQueue:queue
                                     onCompletionQueue: dispatch_get_main_queue()
                             completionBlock:^(UIImage * _Nonnull image, NSError * _Nonnull error) {

            if(!error) {
                UIImageView*imageView = [self.arrrayImageViews objectAtIndex:i];
                imageView.image = image;
            }

        }];
    }

}

//синхронная загрузка (через группу)

- (IBAction)actionLoadSync:(id)sender {

    dispatch_queue_t queue = dispatch_queue_create("queue_for_grupp", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();


    for(int i=0;i<4;i++){
    dispatch_group_enter(group);
    [LoaderImages.Shared getImageFromURL:self.arrayURL[i] onQueue:queue
                               onCompletionQueue: queue
                                 completionBlock:^(UIImage * _Nonnull image, NSError * _Nonnull error) {
                if(!error){
                    self.arrayImage[i] = image;
                    dispatch_group_leave(group);
                }
            }];
    }


    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        for (int i=0; i<4; i++) {
            UIImageView*imageView = [self.arrrayImageViews objectAtIndex:i];
            imageView.image = self.arrayImage[i];
        }
    });

}


@end
