@objc(AwesomeSuperpowered)
class AwesomeSuperpowered: NSObject {
    
    @objc static func requiresMainQueueSetup() -> Bool {
          return false
      }
    
    @objc func construct(recordingPath: String) -> Void {
        print(recordingPath)
    }

    @objc(multiply:withB:withResolver:withRejecter:)
    func multiply(a: Float, b: Float, resolve:RCTPromiseResolveBlock,reject:RCTPromiseRejectBlock) -> Void {
        resolve(a*b*a)
    }
    
    @objc(add:withB:withResolver:withRejecter:)
    func add(a: Float, b: Float, resolve:RCTPromiseResolveBlock,reject:RCTPromiseRejectBlock) -> Void {
        resolve(a+b)
    }
}
