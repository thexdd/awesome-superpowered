#import "AudioRecorder.h"
#import "SuperpoweredRecorder.h"
#import "AudioManager.h"

#import <mach/mach_time.h>

@implementation AudioRecorder {
  Superpowered::Recorder *recorder;
  const char *cPath;
  NSString *path;
  unsigned int samplerate;
}

- (id)init:(NSString*)path
          :(unsigned int)samplerate
          :(AudioManager*)audio {
  self = [super init];
  if (!self) return nil;
  
  cPath = [path UTF8String];
  isRecording = false;
  self->path = path;
  self->samplerate = samplerate;
  recorder = new Superpowered::Recorder(cPath);
  
  audio.delegate = self;
  
  return self;
}

- (void)start {
  if (recorder->prepare(cPath, samplerate, false, 0)) {
    NSLog(@"Recording filepath: %@", path);
  } else {
    NSLog(@"Failed to initialize recorder.");
  }
}

- (void)stop {
  if (isRecording) {
    recorder->stop();
    NSLog(@"Recording stopped.");
  }
}

-(void)samplerateChanged:(unsigned int)value {
  samplerate = value;
}

-(void)process:(bool) silence
              :(float*) stereoBuffer
              :(void*) clientdata
              :(float**) inputBuffers
              :(unsigned int) inputChannels
              :(float**) outputBuffers
              :(unsigned int) outputChannels
              :(unsigned int) numberOfFrames
              :(unsigned int) samplerate
              :(uint64_t) hostTime {
  isRecording = !recorder->isFinished();
  if (!silence && isRecording) {
    self->recorder->recordInterleaved(stereoBuffer, numberOfFrames);
  }
}
@end
