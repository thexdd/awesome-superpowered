#import "AudioManager.h"
#import "Superpowered.h"
#import "SuperpoweredAdvancedAudioPlayer.h"
#import "SuperpoweredSimple.h"
#import "SuperpoweredIOSAudioIO.h"
#import "SuperpoweredMixer.h"
#import "AudioManagerDelegate.h"

#import <mach/mach_time.h>

@implementation AudioManager {
  Superpowered::AdvancedAudioPlayer *player;
  Superpowered::StereoMixer *mixer;
  SuperpoweredIOSAudioIO *output;
  
  unsigned int lastSamplerate;
  float *stereoBuffer;
  float volume;
}

// This is where the Superpowered magic happens.
static bool audioProcessing(void *clientdata, float **inputBuffers, unsigned int inputChannels, float **outputBuffers,
                            unsigned int outputChannels, unsigned int numberOfFrames, unsigned int samplerate, uint64_t hostTime) {
  __unsafe_unretained AudioManager *self = (__bridge AudioManager *) clientdata;

  // Has samplerate changed?
  if (self->lastSamplerate != samplerate) {
    self->lastSamplerate = samplerate;
    self->player->outputSamplerate = samplerate;
    [self.delegate samplerateChanged:samplerate];
  };

  // Let's process some audio. If you'd like to change connections or tap into something, no abstract connection handling and no callbacks required!
  bool silence = !self->player->processStereo(self->stereoBuffer, false, numberOfFrames, self->volume);
  
  // Audio processing callback
  [self.delegate process :silence :self->stereoBuffer :clientdata :inputBuffers :inputChannels :outputBuffers :outputChannels :numberOfFrames :samplerate :hostTime];
  
  if (!silence) Superpowered::DeInterleave(self->stereoBuffer, outputBuffers[0], outputBuffers[1], numberOfFrames);
  return !silence;
}

- (bool)isTrackLoaded {
  return player->getLatestEvent() == Superpowered::AdvancedAudioPlayer::PlayerEvent_Opened;
}

- (id)init:(unsigned int)preferredSamplerate {
  self = [super init];
  if (!self) return nil;

  // enableAudioPlayerAndDecoder (using SuperpoweredAdvancedAudioPlayer or SuperpoweredDecoder)
  Superpowered::Initialize("ExampleLicenseKey-WillExpire-OnNextUpdate", false, false, false, false, true, false, false);

  lastSamplerate = 0;
  
  // Allocating memory, aligned to 16.
  if (posix_memalign((void **) &stereoBuffer, 16, 4096 + 128) != 0) abort();

  // Creating the Superpowered features we'll use.
  player = new Superpowered::AdvancedAudioPlayer(44100, 0);
  
  mixer = new Superpowered::StereoMixer();

  output = [[SuperpoweredIOSAudioIO alloc]
          initWithDelegate:(id <SuperpoweredIOSAudioIODelegate>) self
       preferredBufferSize:12
       preferredSamplerate:preferredSamplerate
      audioSessionCategory:AVAudioSessionCategoryPlayback
                  channels:2
   audioProcessingCallback:audioProcessing
            clientdata:(__bridge void *) self];
  [output start];
  
  return self;
}

- (void)togglePlayback {
  player->togglePlayback();
}

- (void)play {
  player->play();
}

- (void)stop {
  player->pause();
}

- (void)setTrack:(const char*)path {
  player->open(path);
}

- (void)setSpeed:(double)speed {
  player->playbackRate = speed;
}

- (void)setVolume:(double)volume {
  self->volume = volume;
}

- (void)seek:(double)percent {
  player->seek(percent);
}

- (int)getDuration {
  int duration = player->getDurationSeconds();
  return duration;
}

- (bool)getPlayerState {
  bool playerState = player->isPlaying();
  return playerState;
}

- (double)getPosition {
  double position = player->getDisplayPositionMs();
  return position;
}
@end
