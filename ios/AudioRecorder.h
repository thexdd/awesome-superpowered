#import <Foundation/Foundation.h>
#import "AudioManagerDelegate.h"
#import "AudioManager.h"

@interface AudioRecorder : NSObject<AudioManagerDelegate> {
@public
  bool isRecording;
}
- (id)init:(NSString*)path
          :(unsigned int)samplerate
          :(AudioManager*)audio;
- (void)start;
- (void)stop;
@end
