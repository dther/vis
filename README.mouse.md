# Mouse Support

**Highly experimental** mouse support is available through the Lua API.
This feature relies heavily on xterm and SGR mouse extensions,
which may not be available on your terminal emulator of choice.
**It has been tested to work on...**

 - suckless st v0.9.1
 - tmux, via suckless st

Please consider adding your own emulator to this list if this patch is useful to you.

## Default Behaviour and Usage

**The mouse API is currently undocumented and subject to change. Read `vis-mouse.lua` for any information regarding mouse binding.**

To activate mouse support, add `require("vis-mouse")` to your `visrc.lua`.
This will automatically add the necessary hooks to signal the terminal to detect mouse input.

An example of extending vis-mouse is also included in `lua/visrc.lua`, `getmousestr`,
which converts the mouse state exposed by vis-mouse into a string that can be displayed
in the status bar.

`vis-mouse` works by
**estimating which character in the file is closest to the mouse cursor's actual position.**
This is byte-perfect in a singular window containing only ASCII characters,
but **does not account for the following UI elements:**

 - multiple windows
 - line numbers
 - non-default `breakat` values

**The estimated location is always indicated by styling the nearest file character as though it were selected in VISUAL mode,**
creating a "ghost cursor" that is generally no more than a few lines away from the actual mouse cursor.
This allows the mouse to remain usable in situations where the estimation is off by no more than a screenful.
The default bindings are as follows:

### in ANY mode
 - Mouse wheel up or down feeds the keys `<C-y>` or `<C-e>` respectively.

### in INSERT mode
 - any click to move the cursor to the clicked character and return to NORMAL mode

### in NORMAL mode
 - any click to move the cursor to the clicked character
 - click and drag to enter VISUAL mode and select text range
   - By default, also updates the X PRIMARY clipboard using `vis-clipboard` on release.
 - double click to enter VISUAL mode and select the WORD at the current cursor
   - OR, begin VISUAL-LINE if the character clicked is a newline or at terminal column 0

### in VISUAL Mode
 - any click outside of the primary selection while in VISUAL mode to return to NORMAL mode
   - clicking inside the primary selection will simply move the selection cursor.
 - **Mouse Chording** is used to interact with `vis-clipboard`.
   To perform a mouse chord, **click a button while a mouse drag is still in progress.**
   - a **Right Click while dragging any other button** copies the selection at time of click to the system clipboard.
   - a **Mouse Wheel Click while dragging any other button** inserts the contents of the system clipboard before the cursor.
     - It doesn't replace the selection (yet), it only ever inserts. *This function is a work in progress.*
