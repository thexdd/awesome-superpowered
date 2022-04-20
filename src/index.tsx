import { NativeModules, Platform } from 'react-native';

const LINKING_ERROR =
  `The package 'awesome-superpowered' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo managed workflow\n';

const AwesomeSuperpowered = NativeModules.AwesomeSuperpowered
  ? NativeModules.AwesomeSuperpowered
  : new Proxy(
    {},
    {
      get() {
        throw new Error(LINKING_ERROR);
      },
    }
  );

class Superpowered {
  constructor(recordingPath: string) {
    // this.construct(recordingPath)
  }

  construct(recordingPath: string): Promise<void> {
    return AwesomeSuperpowered.construct('JOPA SUKA BLJAD')
  }

  multiply(a: number, b: number): Promise<number> {
    return AwesomeSuperpowered.add(a, b)
  }
}

export default Superpowered
