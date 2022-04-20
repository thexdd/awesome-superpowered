#import <Foundation/Foundation.h>
#import "AudioManagerDelegate.h"

@interface AudioManager : NSObject
@property (nonatomic, retain) IBOutlet id<AudioManagerDelegate> delegate;

- (id)init:(unsigned int)preferredSamplerate;
- (bool)isTrackLoaded;
- (void)setTrack:(const char*)name;
- (void)togglePlayback;
- (void)play;
- (void)stop;
- (void)setSpeed:(double)speed;
- (void)setVolume:(double)volume;
- (void)seek:(double)percent;
- (int)getDuration;
- (bool)getPlayerState;
- (double)getPosition;
@end
