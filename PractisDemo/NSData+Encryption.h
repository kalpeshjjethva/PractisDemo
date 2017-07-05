//
//  NSData+Encryption.h
//  
//
//  Created by Mehul Solanki on 05/07/17.
//
//

#import <Foundation/Foundation.h>

@interface NSData (Encryption)
- (NSData *)AES256EncryptWithKey:(NSString *)key;
- (NSData *)AES256DecryptWithKey:(NSString *)key;

@end
