import { NativeModules } from 'react-native'

class Superpowered {
  constructor(recordingPath: string) {
    this.construct(recordingPath)
  }

  construct(recordingPath: string): Promise<void> {
    return NativeModules.AwesomeSuperpowered.construct(recordingPath)
  }
}

export default Superpowered
