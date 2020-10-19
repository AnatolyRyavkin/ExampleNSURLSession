//
//  LoaderImages.m
//  URLSessionExample
//
//  Created by Anatoly Ryavkin on 19.10.2020.
//

#import "LoaderImages.h"

@implementation LoaderImages

+(LoaderImages*)Shared{
    static LoaderImages* loaderImages = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        loaderImages = [[LoaderImages alloc]init];
    });
    return loaderImages;
}



-(void)getImageFromURL: (NSString*) imageURL
                        onQueue: (dispatch_queue_t) runQueue
                        onCompletionQueue: (dispatch_queue_t) endRunQueue
                        completionBlock: (void (^)(UIImage* image, NSError* error)) compBlock {

    //load ephemeral (для примера ,чтобы без кэша)

    dispatch_async(runQueue, ^{
        NSURLSession* session = [NSURLSession sessionWithConfiguration: [NSURLSessionConfiguration ephemeralSessionConfiguration]];
        NSURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString: imageURL]];
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
        {
          NSHTTPURLResponse* res = (NSHTTPURLResponse *)response;
          if(res.statusCode == 200 && data)
          {
          dispatch_async(endRunQueue, ^{
              UIImage* image = [[UIImage alloc]initWithData:data];
              compBlock(image,nil);
          });
          }
          else
          {
            compBlock(nil, error);
            NSLog(@"Error");
          }
        }];
        
        [dataTask resume];
    });

}

@end
