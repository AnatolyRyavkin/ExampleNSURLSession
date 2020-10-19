//
//  LoaderImages.h
//  URLSessionExample
//
//  Created by Anatoly Ryavkin on 19.10.2020.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoaderImages : NSObject

+(LoaderImages*)Shared;

-(void)getImageFromURL: (NSString*) imageURL
                        onQueue: (dispatch_queue_t) runQueue
                        onCompletionQueue: (dispatch_queue_t) endRunQueue
                        completionBlock: (void (^)(UIImage* image, NSError* error)) compBlock;

@end

NS_ASSUME_NONNULL_END
