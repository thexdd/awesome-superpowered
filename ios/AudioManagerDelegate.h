#import <Foundation/Foundation.h>

@protocol AudioManagerDelegate <NSObject>
-(void)process:(bool) silence
              :(float*) stereoBuffer
              :(void*) clientdata
              :(float**) inputBuffers
              :(unsigned int) inputChannels
              :(float**) outputBuffers
              :(unsigned int) outputChannels
              :(unsigned int) numberOfFrames
              :(unsigned int) samplerate
              :(uint64_t) hostTime;
-(void)samplerateChanged:(unsigned int) value;
@end
