# How to customize Circuit Python

## Docs
- All CP Docs: https://docs.circuitpython.org/_/downloads/en/latest/pdf/
- Building Circuit Python Guide: https://cdn-learn.adafruit.com/downloads/pdf/building-circuitpython.pdf
- Support Matrix to know which modules are included by default: https://docs.circuitpython.org/en/latest/shared-bindings/support_matrix.html

## Example C Modules
- /circuitpython/examples/usercmodule/cexample
- Refer to 'ps2io' module which is already availabel in circuit python 
- PR for 'ps2io': https://github.com/adafruit/circuitpython/commit/84e89146d003890ec3e64a9adf7d7889601baf0e#diff-9d5189936ea0f17ab40d6e1171ae4efed67bf46236ed21b4742633e7d059d022
- Blog for 'ps2io'


Hooking the modules in
Modules are registered by the macro MP_REGISTER_MODULE from py/obj.h. The macro takes two arguments: the
module name as a QSTR and the module object itself. The board module is registered like so:
MP_REGISTER_MODULE(MP_QSTR_board, board_module);


## I2S Audio Examples
- Page No: 146 on doc https://docs.circuitpython.org/_/downloads/en/latest/pdf/

## Keymatrix
- Page No: 242 on above doc, section: 12.56 keypad – Support for scanning keys and key matrices

## OS Functions
- Page No: 263: 12.69 os – functions that an OS normally provides

## HID Functions
- Page No: 325: 12.97 usb_hid – USB Human Interface Device

## Adding Frozen Module
- Page No: 18: Adding Frozen Modules, document: https://cdn-learn.adafruit.com/downloads/pdf/building-circuitpython.pdf