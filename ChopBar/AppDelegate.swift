import Cocoa
import AudioKit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var settings: Settings!
    var midi: AKMIDI!
    var statusItem: NSStatusItem!
    var channelIdentifiers: [NSTouchBarItem.Identifier]!
    var channelItems: [NSTouchBarItem.Identifier: NSTouchBarItem]!
    
    lazy var groupTouchBarItem: NSTouchBarItem = { [unowned self] in
        let result: NSCustomTouchBarItem = NSCustomTouchBarItem(identifier: .group)
        result.view = NSButton(image: NSImage(named: .statusBarIcon)!, target: self, action: #selector(presentGroupTouchBar))
        return result
    }()
    
    var _groupTouchBar: NSTouchBar!
    
    var groupTouchBar: NSTouchBar {
        if _groupTouchBar == nil {
            _groupTouchBar = NSTouchBar()
            _groupTouchBar.defaultItemIdentifiers = channelIdentifiers
            _groupTouchBar.delegate = self
        }
        return _groupTouchBar
    }
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        loadSettings()
        setupMIDI()
        setupStatusItem()
        setupTouchBar()
    }
    
    func applicationWillTerminate(_ notification: Notification) {
        //
    }
    
    func loadSettings() {
        do {
            settings = try Settings.load()
        } catch {
            fatalError("Error: unable to load settings")
        }
    }
    
    func setupMIDI() {
        midi = AKMIDI()
        midi.createVirtualPorts(2_000_000, name: "ChopBar")
        midi.addListener(self)
    }
    
    func setupStatusItem() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        
        if let button = statusItem.button {
            button.image = NSImage(named: .statusBarIcon)
        }
        
        setupStatusMenu()
    }
    
    func setupStatusMenu() {
        let menu: NSMenu = NSMenu()
        
        menu.addItem(NSMenuItem(title: "About ChopBar", action: #selector(aboutClicked), keyEquivalent: ""))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(quitClicked), keyEquivalent: ""))
        
        statusItem.menu = menu
    }
    
    func setupTouchBar() {
        channelIdentifiers = []
        channelItems = [:]
        
        var i: Int = 0
        for channel in settings.channels {
            let identifier: NSTouchBarItem.Identifier = NSTouchBarItem.Identifier("nl.robhendriks.ChopBar.slider.\(channel.name)")
            channelIdentifiers.append(identifier)
            
            let item: ChannelTouchBarItem = ChannelTouchBarItem(channel, identifier: identifier)
            
            let slider: NSSlider = NSSlider(target: self, action: #selector(channelValueChanged))
            slider.trackFillColor = channel.color.nsColor
            slider.minValue = 0
            slider.maxValue = 100
            slider.integerValue = 100
            slider.tag = i
            
            item.view = slider
            
            channelItems[identifier] = item
            i += 1
        }
        
        DFRSystemModalShowsCloseBoxWhenFrontMost(true)
        NSTouchBarItem.addSystemTrayItem(groupTouchBarItem)
        DFRElementSetControlStripPresenceForIdentifier(groupTouchBarItem.identifier.rawValue, true)
    }
    
    @available(OSX 10.12.1, *)
    func makeTouchBar() -> NSTouchBar {
        return groupTouchBar
    }
}

extension AppDelegate {
    
    @objc func channelValueChanged(sender: Any?) {
        guard let slider = sender as? NSSlider
            else { return }
        
        let channel: Settings.Channel = settings.channels[slider.tag]
        let value: Double = Double(127) / 100 * slider.doubleValue
        
        midi.sendEvent(AKMIDIEvent(controllerChange: UInt8(channel.controller), value: UInt8(value), channel: UInt8(channel.channel)))
    }
    
    @objc func presentGroupTouchBar(sender: Any?) {
        NSTouchBar.presentSystemModalFunctionBar(groupTouchBar, systemTrayItemIdentifier: groupTouchBarItem.identifier.rawValue)
    }
    
    @objc func aboutClicked(sender: Any?) {
        //
    }
    
    @objc func quitClicked(sender: Any?) {
        NSApp.terminate(sender)
    }
}

extension AppDelegate: NSTouchBarDelegate {
    
    @available(OSX 10.12.1, *)
    func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItem.Identifier) -> NSTouchBarItem? {
        if identifier == groupTouchBarItem.identifier {
            return groupTouchBarItem
        } else if channelItems.keys.contains(identifier) {
            return channelItems[identifier]
        }
        
        return nil
    }
}

extension AppDelegate: AKMIDIListener {
    
}
