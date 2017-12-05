import Cocoa

class ChannelTouchBarItem: NSCustomTouchBarItem {
    let channel: Settings.Channel
    
    init(_ channel: Settings.Channel, identifier: NSTouchBarItem.Identifier) {
        self.channel = channel
        super.init(identifier: identifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
