This is a small test app that demonstrates what I believe to be a flutter bug when running on a custom embedder.

I have tested with two embedders, ivi-homescreen and elinux, and the behavior appears on both. With elinux the behavior occurs with all three variants: gbm, X11, and Wayland. I have tested with two boards, Raspberry pi 3a+ and a Radxa Zero, and both boards show the issue.

## Expected behavior
The app should display a digital clock with the minutes incrementing by one every 10 seconds. The 'update' button has no visual effect.

## Actual behavior
On launch the digital clock will display once, then the screen will go black. The screen will then alternate between black and the clock approximately every five seconds. When the clock is shown the minutes will have incremented by one.

The 'Update' button will interrupt this sequence and cause the clock face to always appear. However the clock time value will alternate between the value it had when 'Update' was pressed and its current value. Pressing 'Update' again will cause the the "pinned" value to reset to the current value.

> The app has a fixed layout designed for a 1024x600 LCD display. 