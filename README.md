# ChopBar

ChopBar is a simple TouchBar application that provides four sliders to the user. The sliders are emitting MIDI events and enable the user to chop some phat chunes and be a RIDDIM DJ.

![Screenshot](https://raw.githubusercontent.com/robhendriks/ChopBar/master/Screenshot.png?token=ABw8KEacLecr83T1Q_UuJweMmgEvQoyLks5aL0dUwA%3D%3D)

## Mapping

### Traktor

The latest release includes a `.tsi` file that can be imported through the `Controller Manager` in Traktor's preferences.

### Other stuff

Idk, just make sure it understands the following `Control Change` events:

| Control | Assignment | Mapped to |
| ------- | ---------- | --------- |
| Volume adjust | Deck A | Ch01.CC.000 |
| Volume adjust | Deck B | Ch02.CC.000 |
| Volume adjust | Deck C | Ch03.CC.000 |
| Volume adjust | Deck D | Ch04.CC.000 |

