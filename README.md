# ChopBar

![ChopBar](https://raw.githubusercontent.com/robhendriks/ChopBar/master/ChopBar/Assets.xcassets/AppIcon.appiconset/AppIcon-128.png?token=ABw8KJEuPivI0wTUf1OKSWwpzQ1UHtRHks5aL0x6wA%3D%3D)

Always wanted to use your $1799+ MacBook Pro's TouchBar to chop some phat chunes? Well now you can using ChopBar: a simple application that turns your TouchBar into a MIDI-powered volume control surface supporting up to four decks.

![Screenshot](https://raw.githubusercontent.com/robhendriks/ChopBar/master/Screenshot.png?token=ABw8KEacLecr83T1Q_UuJweMmgEvQoyLks5aL0dUwA%3D%3D)

## Mapping

### Traktor

The latest release includes a `.tsi` file that can be imported through the `Controller Manager` in Traktor's preferences.

### Other

ChopBar is based on generic MIDI events called `Control Change` events. Any software that understands this is able to communicate with ChopBar. Just make sure it understands the mapping below:

| Control | Assignment | Mapped to |
| ------- | ---------- | --------- |
| Volume adjust | Deck A | Ch01.CC.000 |
| Volume adjust | Deck B | Ch02.CC.000 |
| Volume adjust | Deck C | Ch03.CC.000 |
| Volume adjust | Deck D | Ch04.CC.000 |

