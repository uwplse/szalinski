/* Customizable enclosure
 * Modified lego code originally copied from canadaduane:
 * https://github.com/canadaduane/Things/blob/master/Lego/lego.scad
 */

// Which face of the enclosure to generate
show_face="open"; // ["open":Open view of the enclosure, "closed":Closed enclosure, "left":Left panel, "right":Right panel, "top":Top panel, "bottom":Bottom panel, "front":Front panel, "back":Back panel] 
// The width of the device in mm
device_width=200;
// The length of the device in mm
device_length=300;
// The height of the device. in mm
device_height=100;
// The height of the bottom only side of the device
device_bottom_height = 30;
// The thickness of the walls of the enclosure
enclosure_thickness = 5; // [2:100]
// Thickness of the PCB board
pcb_thickness = 1;

// Type of port on the front side
front_port1 = "none"; // ["none":None, "power":5V Power Connector, "hdmi":HDMI Port, "vga":VGA Port, "dvi":DVI-I Port, "displayport":Displayport, "s-video":S-Video Port, "eth":Ethernet Port, "stereo":Stereo Headphones Jack, "audio":Microphone and Stereo Headphones Jack, "sd":SD Card Slot, "microsd":MicroSD Card Slot,  "micro-usb":Micro USB, "mini-usb":Mini USB, "usb-a":USB-A Host Port, "2usb-a":Dual USB-A Host Ports, "usb-b":USB-B Port, "custom-rectangle":Regtangle of custom size, "custom-circle":Circle of custom radius]
// Position in mm of the port along the device
front_port1_position = 0;
// Side on which the port appears
front_port1_side = "top"; // ["top":Top, "bottom":Bottom]
// Width of the rectangle if "custom-regtangle" port type is selected
front_port1_custom_rectangle_width = 0;
// Height of the rectangle if "custom-regtangle" port type is selected
front_port1_custom_rectangle_height = 0;
// Radius of the circle if "custom-circle" port type is selected
front_port1_custom_circle_radius = 0;
// Elevation of the center of rectangle or center of circle from the device PCB if "custom-circle" or "custom-rectangle" port type is selected
front_port1_custom_elevation = 0;
// Type of port on the front side
front_port2 = "none"; // ["none":None, "power":5V Power Connector, "hdmi":HDMI Port, "vga":VGA Port, "dvi":DVI-I Port, "displayport":Displayport, "s-video":S-Video Port, "eth":Ethernet Port, "stereo":Stereo Headphones Jack, "audio":Microphone and Stereo Headphones Jack, "sd":SD Card Slot, "microsd":MicroSD Card Slot,  "micro-usb":Micro USB, "mini-usb":Mini USB, "usb-a":USB-A Host Port, "2usb-a":Dual USB-A Host Ports, "usb-b":USB-B Port, "custom-rectangle":Regtangle of custom size, "custom-circle":Circle of custom radius]
// Position in mm of the port along the device
front_port2_position = 0;
// Side on which the port appears
front_port2_side = "top"; // ["top":Top, "bottom":Bottom]
// Width of the rectangle if "custom-regtangle" port type is selected
front_port2_custom_rectangle_width = 0;
// Height of the rectangle if "custom-regtangle" port type is selected
front_port2_custom_rectangle_height = 0;
// Radius of the circle if "custom-circle" port type is selected
front_port2_custom_circle_radius = 0;
// Elevation of the center of rectangle or center of circle from the device PCB if "custom-circle" or "custom-rectangle" port type is selected
front_port2_custom_elevation = 0;
// Type of port on the front side
front_port3 = "none"; // ["none":None, "power":5V Power Connector, "hdmi":HDMI Port, "vga":VGA Port, "dvi":DVI-I Port, "displayport":Displayport, "s-video":S-Video Port, "eth":Ethernet Port, "stereo":Stereo Headphones Jack, "audio":Microphone and Stereo Headphones Jack, "sd":SD Card Slot, "microsd":MicroSD Card Slot,  "micro-usb":Micro USB, "mini-usb":Mini USB, "usb-a":USB-A Host Port, "2usb-a":Dual USB-A Host Ports, "usb-b":USB-B Port, "custom-rectangle":Regtangle of custom size, "custom-circle":Circle of custom radius]
// Position in mm of the port along the device
front_port3_position = 0;
// Side on which the port appears
front_port3_side = "top"; // ["top":Top, "bottom":Bottom]
// Width of the rectangle if "custom-regtangle" port type is selected
front_port3_custom_rectangle_width = 0;
// Height of the rectangle if "custom-regtangle" port type is selected
front_port3_custom_rectangle_height = 0;
// Radius of the circle if "custom-circle" port type is selected
front_port3_custom_circle_radius = 0;
// Elevation of the center of rectangle or center of circle from the device PCB if "custom-circle" or "custom-rectangle" port type is selected
front_port3_custom_elevation = 0;
// Type of port on the front side
front_port4 = "none"; // ["none":None, "power":5V Power Connector, "hdmi":HDMI Port, "vga":VGA Port, "dvi":DVI-I Port, "displayport":Displayport, "s-video":S-Video Port, "eth":Ethernet Port, "stereo":Stereo Headphones Jack, "audio":Microphone and Stereo Headphones Jack, "sd":SD Card Slot, "microsd":MicroSD Card Slot,  "micro-usb":Micro USB, "mini-usb":Mini USB, "usb-a":USB-A Host Port, "2usb-a":Dual USB-A Host Ports, "usb-b":USB-B Port, "custom-rectangle":Regtangle of custom size, "custom-circle":Circle of custom radius]
// Position in mm of the port along the device
front_port4_position = 0;
// Side on which the port appears
front_port4_side = "top"; // ["top":Top, "bottom":Bottom]
// Width of the rectangle if "custom-regtangle" port type is selected
front_port4_custom_rectangle_width = 0;
// Height of the rectangle if "custom-regtangle" port type is selected
front_port4_custom_rectangle_height = 0;
// Radius of the circle if "custom-circle" port type is selected
front_port4_custom_circle_radius = 0;
// Elevation of the center of rectangle or center of circle from the device PCB if "custom-circle" or "custom-rectangle" port type is selected
front_port4_custom_elevation = 0;
// Type of port on the front side
front_port5 = "none"; // ["none":None, "power":5V Power Connector, "hdmi":HDMI Port, "vga":VGA Port, "dvi":DVI-I Port, "displayport":Displayport, "s-video":S-Video Port, "eth":Ethernet Port, "stereo":Stereo Headphones Jack, "audio":Microphone and Stereo Headphones Jack, "sd":SD Card Slot, "microsd":MicroSD Card Slot,  "micro-usb":Micro USB, "mini-usb":Mini USB, "usb-a":USB-A Host Port, "2usb-a":Dual USB-A Host Ports, "usb-b":USB-B Port, "custom-rectangle":Regtangle of custom size, "custom-circle":Circle of custom radius]
// Position in mm of the port along the device
front_port5_position = 0;
// Side on which the port appears
front_port5_side = "top"; // ["top":Top, "bottom":Bottom]
// Width of the rectangle if "custom-regtangle" port type is selected
front_port5_custom_rectangle_width = 0;
// Height of the rectangle if "custom-regtangle" port type is selected
front_port5_custom_rectangle_height = 0;
// Radius of the circle if "custom-circle" port type is selected
front_port5_custom_circle_radius = 0;
// Elevation of the center of rectangle or center of circle from the device PCB if "custom-circle" or "custom-rectangle" port type is selected
front_port5_custom_elevation = 0;

// Type of port on the back side
back_port1 = "none"; // ["none":None, "power":5V Power Connector, "hdmi":HDMI Port, "vga":VGA Port, "dvi":DVI-I Port, "displayport":Displayport, "s-video":S-Video Port, "eth":Ethernet Port, "stereo":Stereo Headphones Jack, "audio":Microphone and Stereo Headphones Jack, "sd":SD Card Slot, "microsd":MicroSD Card Slot,  "micro-usb":Micro USB, "mini-usb":Mini USB, "usb-a":USB-A Host Port, "2usb-a":Dual USB-A Host Ports, "usb-b":USB-B Port, "custom-rectangle":Regtangle of custom size, "custom-circle":Circle of custom radius]
// Position in mm of the port along the device
back_port1_position = 0;
// Side on which the port appears
back_port1_side = "top"; // ["top":Top, "bottom":Bottom]
// Width of the rectangle if "custom-regtangle" port type is selected
back_port1_custom_rectangle_width = 0;
// Height of the rectangle if "custom-regtangle" port type is selected
back_port1_custom_rectangle_height = 0;
// Radius of the circle if "custom-circle" port type is selected
back_port1_custom_circle_radius = 0;
// Elevation of the center of rectangle or center of circle from the device PCB if "custom-circle" or "custom-rectangle" port type is selected
back_port1_custom_elevation = 0;
// Type of port on the back side
back_port2 = "none"; // ["none":None, "power":5V Power Connector, "hdmi":HDMI Port, "vga":VGA Port, "dvi":DVI-I Port, "displayport":Displayport, "s-video":S-Video Port, "eth":Ethernet Port, "stereo":Stereo Headphones Jack, "audio":Microphone and Stereo Headphones Jack, "sd":SD Card Slot, "microsd":MicroSD Card Slot,  "micro-usb":Micro USB, "mini-usb":Mini USB, "usb-a":USB-A Host Port, "2usb-a":Dual USB-A Host Ports, "usb-b":USB-B Port, "custom-rectangle":Regtangle of custom size, "custom-circle":Circle of custom radius]
// Position in mm of the port along the device
back_port2_position = 0;
// Side on which the port appears
back_port2_side = "top"; // ["top":Top, "bottom":Bottom]
// Width of the rectangle if "custom-regtangle" port type is selected
back_port2_custom_rectangle_width = 0;
// Height of the rectangle if "custom-regtangle" port type is selected
back_port2_custom_rectangle_height = 0;
// Radius of the circle if "custom-circle" port type is selected
back_port2_custom_circle_radius = 0;
// Elevation of the center of rectangle or center of circle from the device PCB if "custom-circle" or "custom-rectangle" port type is selected
back_port2_custom_elevation = 0;
// Type of port on the back side
back_port3 = "none"; // ["none":None, "power":5V Power Connector, "hdmi":HDMI Port, "vga":VGA Port, "dvi":DVI-I Port, "displayport":Displayport, "s-video":S-Video Port, "eth":Ethernet Port, "stereo":Stereo Headphones Jack, "audio":Microphone and Stereo Headphones Jack, "sd":SD Card Slot, "microsd":MicroSD Card Slot,  "micro-usb":Micro USB, "mini-usb":Mini USB, "usb-a":USB-A Host Port, "2usb-a":Dual USB-A Host Ports, "usb-b":USB-B Port, "custom-rectangle":Regtangle of custom size, "custom-circle":Circle of custom radius]
// Position in mm of the port along the device
back_port3_position = 0;
// Side on which the port appears
back_port3_side = "top"; // ["top":Top, "bottom":Bottom]
// Width of the rectangle if "custom-regtangle" port type is selected
back_port3_custom_rectangle_width = 0;
// Height of the rectangle if "custom-regtangle" port type is selected
back_port3_custom_rectangle_height = 0;
// Radius of the circle if "custom-circle" port type is selected
back_port3_custom_circle_radius = 0;
// Elevation of the center of rectangle or center of circle from the device PCB if "custom-circle" or "custom-rectangle" port type is selected
back_port3_custom_elevation = 0;
// Type of port on the back side
back_port4 = "none"; // ["none":None, "power":5V Power Connector, "hdmi":HDMI Port, "vga":VGA Port, "dvi":DVI-I Port, "displayport":Displayport, "s-video":S-Video Port, "eth":Ethernet Port, "stereo":Stereo Headphones Jack, "audio":Microphone and Stereo Headphones Jack, "sd":SD Card Slot, "microsd":MicroSD Card Slot,  "micro-usb":Micro USB, "mini-usb":Mini USB, "usb-a":USB-A Host Port, "2usb-a":Dual USB-A Host Ports, "usb-b":USB-B Port, "custom-rectangle":Regtangle of custom size, "custom-circle":Circle of custom radius]
// Position in mm of the port along the device
back_port4_position = 0;
// Side on which the port appears
back_port4_side = "top"; // ["top":Top, "bottom":Bottom]
// Width of the rectangle if "custom-regtangle" port type is selected
back_port4_custom_rectangle_width = 0;
// Height of the rectangle if "custom-regtangle" port type is selected
back_port4_custom_rectangle_height = 0;
// Radius of the circle if "custom-circle" port type is selected
back_port4_custom_circle_radius = 0;
// Elevation of the center of rectangle or center of circle from the device PCB if "custom-circle" or "custom-rectangle" port type is selected
back_port4_custom_elevation = 0;
// Type of port on the back side
back_port5 = "none"; // ["none":None, "power":5V Power Connector, "hdmi":HDMI Port, "vga":VGA Port, "dvi":DVI-I Port, "displayport":Displayport, "s-video":S-Video Port, "eth":Ethernet Port, "stereo":Stereo Headphones Jack, "audio":Microphone and Stereo Headphones Jack, "sd":SD Card Slot, "microsd":MicroSD Card Slot,  "micro-usb":Micro USB, "mini-usb":Mini USB, "usb-a":USB-A Host Port, "2usb-a":Dual USB-A Host Ports, "usb-b":USB-B Port, "custom-rectangle":Regtangle of custom size, "custom-circle":Circle of custom radius]
// Position in mm of the port along the device
back_port5_position = 0;
// Side on which the port appears
back_port5_side = "top"; // ["top":Top, "bottom":Bottom]
// Width of the rectangle if "custom-regtangle" port type is selected
back_port5_custom_rectangle_width = 0;
// Height of the rectangle if "custom-regtangle" port type is selected
back_port5_custom_rectangle_height = 0;
// Radius of the circle if "custom-circle" port type is selected
back_port5_custom_circle_radius = 0;
// Elevation of the center of rectangle or center of circle from the device PCB if "custom-circle" or "custom-rectangle" port type is selected
back_port5_custom_elevation = 0;

// Type of port on the left side
left_port1 = "none"; // ["none":None, "power":5V Power Connector, "hdmi":HDMI Port, "vga":VGA Port, "dvi":DVI-I Port, "displayport":Displayport, "s-video":S-Video Port, "eth":Ethernet Port, "stereo":Stereo Headphones Jack, "audio":Microphone and Stereo Headphones Jack, "sd":SD Card Slot, "microsd":MicroSD Card Slot,  "micro-usb":Micro USB, "mini-usb":Mini USB, "usb-a":USB-A Host Port, "2usb-a":Dual USB-A Host Ports, "usb-b":USB-B Port, "custom-rectangle":Regtangle of custom size, "custom-circle":Circle of custom radius]
// Position in mm of the port along the device
left_port1_position = 0;
// Side on which the port appears
left_port1_side = "top"; // ["top":Top, "bottom":Bottom]
// Width of the rectangle if "custom-regtangle" port type is selected
left_port1_custom_rectangle_width = 0;
// Height of the rectangle if "custom-regtangle" port type is selected
left_port1_custom_rectangle_height = 0;
// Radius of the circle if "custom-circle" port type is selected
left_port1_custom_circle_radius = 0;
// Elevation of the center of rectangle or center of circle from the device PCB if "custom-circle" or "custom-rectangle" port type is selected
left_port1_custom_elevation = 0;
// Type of port on the left side
left_port2 = "none"; // ["none":None, "power":5V Power Connector, "hdmi":HDMI Port, "vga":VGA Port, "dvi":DVI-I Port, "displayport":Displayport, "s-video":S-Video Port, "eth":Ethernet Port, "stereo":Stereo Headphones Jack, "audio":Microphone and Stereo Headphones Jack, "sd":SD Card Slot, "microsd":MicroSD Card Slot,  "micro-usb":Micro USB, "mini-usb":Mini USB, "usb-a":USB-A Host Port, "2usb-a":Dual USB-A Host Ports, "usb-b":USB-B Port, "custom-rectangle":Regtangle of custom size, "custom-circle":Circle of custom radius]
// Position in mm of the port along the device
left_port2_position = 0;
// Side on which the port appears
left_port2_side = "top"; // ["top":Top, "bottom":Bottom]
// Width of the rectangle if "custom-regtangle" port type is selected
left_port2_custom_rectangle_width = 0;
// Height of the rectangle if "custom-regtangle" port type is selected
left_port2_custom_rectangle_height = 0;
// Radius of the circle if "custom-circle" port type is selected
left_port2_custom_circle_radius = 0;
// Elevation of the center of rectangle or center of circle from the device PCB if "custom-circle" or "custom-rectangle" port type is selected
left_port2_custom_elevation = 0;
// Type of port on the left side
left_port3 = "none"; // ["none":None, "power":5V Power Connector, "hdmi":HDMI Port, "vga":VGA Port, "dvi":DVI-I Port, "displayport":Displayport, "s-video":S-Video Port, "eth":Ethernet Port, "stereo":Stereo Headphones Jack, "audio":Microphone and Stereo Headphones Jack, "sd":SD Card Slot, "microsd":MicroSD Card Slot,  "micro-usb":Micro USB, "mini-usb":Mini USB, "usb-a":USB-A Host Port, "2usb-a":Dual USB-A Host Ports, "usb-b":USB-B Port, "custom-rectangle":Regtangle of custom size, "custom-circle":Circle of custom radius]
// Position in mm of the port along the device
left_port3_position = 0;
// Side on which the port appears
left_port3_side = "top"; // ["top":Top, "bottom":Bottom]
// Width of the rectangle if "custom-regtangle" port type is selected
left_port3_custom_rectangle_width = 0;
// Height of the rectangle if "custom-regtangle" port type is selected
left_port3_custom_rectangle_height = 0;
// Radius of the circle if "custom-circle" port type is selected
left_port3_custom_circle_radius = 0;
// Elevation of the center of rectangle or center of circle from the device PCB if "custom-circle" or "custom-rectangle" port type is selected
left_port3_custom_elevation = 0;
// Type of port on the left side
left_port4 = "none"; // ["none":None, "power":5V Power Connector, "hdmi":HDMI Port, "vga":VGA Port, "dvi":DVI-I Port, "displayport":Displayport, "s-video":S-Video Port, "eth":Ethernet Port, "stereo":Stereo Headphones Jack, "audio":Microphone and Stereo Headphones Jack, "sd":SD Card Slot, "microsd":MicroSD Card Slot,  "micro-usb":Micro USB, "mini-usb":Mini USB, "usb-a":USB-A Host Port, "2usb-a":Dual USB-A Host Ports, "usb-b":USB-B Port, "custom-rectangle":Regtangle of custom size, "custom-circle":Circle of custom radius]
// Position in mm of the port along the device
left_port4_position = 0;
// Side on which the port appears
left_port4_side = "top"; // ["top":Top, "bottom":Bottom]
// Width of the rectangle if "custom-regtangle" port type is selected
left_port4_custom_rectangle_width = 0;
// Height of the rectangle if "custom-regtangle" port type is selected
left_port4_custom_rectangle_height = 0;
// Radius of the circle if "custom-circle" port type is selected
left_port4_custom_circle_radius = 0;
// Elevation of the center of rectangle or center of circle from the device PCB if "custom-circle" or "custom-rectangle" port type is selected
left_port4_custom_elevation = 0;
// Type of port on the left side
left_port5 = "none"; // ["none":None, "power":5V Power Connector, "hdmi":HDMI Port, "vga":VGA Port, "dvi":DVI-I Port, "displayport":Displayport, "s-video":S-Video Port, "eth":Ethernet Port, "stereo":Stereo Headphones Jack, "audio":Microphone and Stereo Headphones Jack, "sd":SD Card Slot, "microsd":MicroSD Card Slot,  "micro-usb":Micro USB, "mini-usb":Mini USB, "usb-a":USB-A Host Port, "2usb-a":Dual USB-A Host Ports, "usb-b":USB-B Port, "custom-rectangle":Regtangle of custom size, "custom-circle":Circle of custom radius]
// Position in mm of the port along the device
left_port5_position = 0;
// Side on which the port appears
left_port5_side = "top"; // ["top":Top, "bottom":Bottom]
// Width of the rectangle if "custom-regtangle" port type is selected
left_port5_custom_rectangle_width = 0;
// Height of the rectangle if "custom-regtangle" port type is selected
left_port5_custom_rectangle_height = 0;
// Radius of the circle if "custom-circle" port type is selected
left_port5_custom_circle_radius = 0;
// Elevation of the center of rectangle or center of circle from the device PCB if "custom-circle" or "custom-rectangle" port type is selected
left_port5_custom_elevation = 0;

// Type of port on the right side
right_port1 = "none"; // ["none":None, "power":5V Power Connector, "hdmi":HDMI Port, "vga":VGA Port, "dvi":DVI-I Port, "displayport":Displayport, "s-video":S-Video Port, "eth":Ethernet Port, "stereo":Stereo Headphones Jack, "audio":Microphone and Stereo Headphones Jack, "sd":SD Card Slot, "microsd":MicroSD Card Slot,  "micro-usb":Micro USB, "mini-usb":Mini USB, "usb-a":USB-A Host Port, "2usb-a":Dual USB-A Host Ports, "usb-b":USB-B Port, "custom-rectangle":Regtangle of custom size, "custom-circle":Circle of custom radius]
// Position in mm of the port along the device
right_port1_position = 0;
// Side on which the port appears
right_port1_side = "top"; // ["top":Top, "bottom":Bottom]
// Width of the rectangle if "custom-regtangle" port type is selected
right_port1_custom_rectangle_width = 0;
// Height of the rectangle if "custom-regtangle" port type is selected
right_port1_custom_rectangle_height = 0;
// Radius of the circle if "custom-circle" port type is selected
right_port1_custom_circle_radius = 0;
// Elevation of the center of rectangle or center of circle from the device PCB if "custom-circle" or "custom-rectangle" port type is selected
right_port1_custom_elevation = 0;
// Type of port on the right side
right_port2 = "none"; // ["none":None, "power":5V Power Connector, "hdmi":HDMI Port, "vga":VGA Port, "dvi":DVI-I Port, "displayport":Displayport, "s-video":S-Video Port, "eth":Ethernet Port, "stereo":Stereo Headphones Jack, "audio":Microphone and Stereo Headphones Jack, "sd":SD Card Slot, "microsd":MicroSD Card Slot,  "micro-usb":Micro USB, "mini-usb":Mini USB, "usb-a":USB-A Host Port, "2usb-a":Dual USB-A Host Ports, "usb-b":USB-B Port, "custom-rectangle":Regtangle of custom size, "custom-circle":Circle of custom radius]
// Position in mm of the port along the device
right_port2_position = 0;
// Side on which the port appears
right_port2_side = "top"; // ["top":Top, "bottom":Bottom]
// Width of the rectangle if "custom-regtangle" port type is selected
right_port2_custom_rectangle_width = 0;
// Height of the rectangle if "custom-regtangle" port type is selected
right_port2_custom_rectangle_height = 0;
// Radius of the circle if "custom-circle" port type is selected
right_port2_custom_circle_radius = 0;
// Elevation of the center of rectangle or center of circle from the device PCB if "custom-circle" or "custom-rectangle" port type is selected
right_port2_custom_elevation = 0;
// Type of port on the right side
right_port3 = "none"; // ["none":None, "power":5V Power Connector, "hdmi":HDMI Port, "vga":VGA Port, "dvi":DVI-I Port, "displayport":Displayport, "s-video":S-Video Port, "eth":Ethernet Port, "stereo":Stereo Headphones Jack, "audio":Microphone and Stereo Headphones Jack, "sd":SD Card Slot, "microsd":MicroSD Card Slot,  "micro-usb":Micro USB, "mini-usb":Mini USB, "usb-a":USB-A Host Port, "2usb-a":Dual USB-A Host Ports, "usb-b":USB-B Port, "custom-rectangle":Regtangle of custom size, "custom-circle":Circle of custom radius]
// Position in mm of the port along the device
right_port3_position = 0;
// Side on which the port appears
right_port3_side = "top"; // ["top":Top, "bottom":Bottom]
// Width of the rectangle if "custom-regtangle" port type is selected
right_port3_custom_rectangle_width = 0;
// Height of the rectangle if "custom-regtangle" port type is selected
right_port3_custom_rectangle_height = 0;
// Radius of the circle if "custom-circle" port type is selected
right_port3_custom_circle_radius = 0;
// Elevation of the center of rectangle or center of circle from the device PCB if "custom-circle" or "custom-rectangle" port type is selected
right_port3_custom_elevation = 0;
// Type of port on the right side
right_port4 = "none"; // ["none":None, "power":5V Power Connector, "hdmi":HDMI Port, "vga":VGA Port, "dvi":DVI-I Port, "displayport":Displayport, "s-video":S-Video Port, "eth":Ethernet Port, "stereo":Stereo Headphones Jack, "audio":Microphone and Stereo Headphones Jack, "sd":SD Card Slot, "microsd":MicroSD Card Slot,  "micro-usb":Micro USB, "mini-usb":Mini USB, "usb-a":USB-A Host Port, "2usb-a":Dual USB-A Host Ports, "usb-b":USB-B Port, "custom-rectangle":Regtangle of custom size, "custom-circle":Circle of custom radius]
// Position in mm of the port along the device
right_port4_position = 0;
// Side on which the port appears
right_port4_side = "top"; // ["top":Top, "bottom":Bottom]
// Width of the rectangle if "custom-regtangle" port type is selected
right_port4_custom_rectangle_width = 0;
// Height of the rectangle if "custom-regtangle" port type is selected
right_port4_custom_rectangle_height = 0;
// Radius of the circle if "custom-circle" port type is selected
right_port4_custom_circle_radius = 0;
// Elevation of the center of rectangle or center of circle from the device PCB if "custom-circle" or "custom-rectangle" port type is selected
right_port4_custom_elevation = 0;
// Type of port on the right side
right_port5 = "none"; // ["none":None, "power":5V Power Connector, "hdmi":HDMI Port, "vga":VGA Port, "dvi":DVI-I Port, "displayport":Displayport, "s-video":S-Video Port, "eth":Ethernet Port, "stereo":Stereo Headphones Jack, "audio":Microphone and Stereo Headphones Jack, "sd":SD Card Slot, "microsd":MicroSD Card Slot,  "micro-usb":Micro USB, "mini-usb":Mini USB, "usb-a":USB-A Host Port, "2usb-a":Dual USB-A Host Ports, "usb-b":USB-B Port, "custom-rectangle":Regtangle of custom size, "custom-circle":Circle of custom radius]
// Position in mm of the port along the device
right_port5_position = 0;
// Side on which the port appears
right_port5_side = "top"; // ["top":Top, "bottom":Bottom]
// Width of the rectangle if "custom-regtangle" port type is selected
right_port5_custom_rectangle_width = 0;
// Height of the rectangle if "custom-regtangle" port type is selected
right_port5_custom_rectangle_height = 0;
// Radius of the circle if "custom-circle" port type is selected
right_port5_custom_circle_radius = 0;
// Elevation of the center of rectangle or center of circle from the device PCB if "custom-circle" or "custom-rectangle" port type is selected
right_port5_custom_elevation = 0;

// Foot of the enclosure
foot_r = device_width / 20;
foot_l = device_length / 10;
foot_h = enclosure_thickness;

// Exterior thickness
wall_thickness=enclosure_thickness / 5;

// Knobs are the circles on top of blocks
knob_diameter=enclosure_thickness - (wall_thickness * 2);
knob_height=enclosure_thickness * 2  / 3;
knob_spacing=knob_diameter * 3/2;


module place_port(position, side, padded) {
  padding = padded ? enclosure_thickness : 0;
  translate ([position + padding, device_bottom_height + enclosure_thickness, 0])
    {
      if (side == "bottom") 
        mirror([0, 1, 0]) child(0);
      else
        translate ([0, pcb_thickness, 0]) child(0);
    }
}

module power() {
  cube ([10, 12, enclosure_thickness]);
}
module hdmi() {
  cube ([16, 7, enclosure_thickness]);
}
module vga() {
  // TODO
}
module dvi() {
  // TODO
}
module displayport() {
  // TODO
}
module s_video() {
  translate ([0, 8, 0]) cylinder (r=4.5, h=enclosure_thickness);
}
module eth() {
  cube ([16, 18, enclosure_thickness]);
}
module stereo () {
  translate ([0, 6.5, 0]) cylinder (r=4, h=enclosure_thickness);
}
module audio() {
  translate ([0, 6.5, 0]) cylinder (r=4, h=enclosure_thickness);
  translate ([0, 13, 0]) cylinder (r=4, h=enclosure_thickness);
}
module sd() {
  translate ([0, 1, 0]) cube ([25, 2, enclosure_thickness]);
}
module microsd() {
  cube ([12, 2, enclosure_thickness]);
}
module micro_usb() {
  cube ([9, 5, enclosure_thickness]);
}
module mini_usb() {
  cube ([9, 3.5, enclosure_thickness]);
}
module usb_a() {
  cube ([15, 8, enclosure_thickness]);
}
module usb_a2() {
  cube ([15, 16, enclosure_thickness]);
}
module usb_b() {
  cube ([12, 11, enclosure_thickness]);
}
module custom_rectangle(w, h, y) {
  translate ([0, y, 0]) cube ([w, h, enclosure_thickness]);
}
module custom_circle(r, y) {
  translate ([0, y, 0]) cylinder (r=r, h=enclosure_thickness);
}

module add_port(port, position, side, padded, w = 0, h = 0, r = 0, y = 0) {
  if (port == "none") {
  } else if (port == "hdmi") {
    place_port(position, side, padded) hdmi();
  } else if (port == "power") {
    place_port(position, side, padded) power();
  } else if (port == "vga") {
    place_port(position, side, padded) vga();
  } else if (port == "dvi") {
    place_port(position, side, padded) dvi();
  } else if (port == "displayport") {
    place_port(position, side, padded) displayport();
  } else if (port == "s-video") {
    place_port(position, side, padded) s_video();
  } else if (port == "eth") {
    place_port(position, side, padded) eth();
  } else if (port == "stereo") {
    place_port(position, side, padded) stereo();
  } else if (port == "audio") {
    place_port(position, side, padded) audio();
  } else if (port == "sd") {
    place_port(position, side, padded) sd();
  } else if (port == "microsd") {
    place_port(position, side, padded) microsd();
  } else if (port == "micro-usb") {
    place_port(position, side, padded) micro_usb();
  } else if (port == "mini-usb") {
    place_port(position, side, padded) mini_usb();
  } else if (port == "usb-a") {
    place_port(position, side, padded) usb_a();
  } else if (port == "2usb-a") {
    place_port(position, side, padded) usb_a2();
  } else if (port == "usb-b") {
    place_port(position, side, padded) usb_b();
  } else if (port == "custom-rectangle") {
    echo(position);
    place_port(position, side, padded) custom_rectangle(w, h, y);
  } else if (port == "custom-circle") {
    place_port(position, side, padded) custom_circle(r, y);
  }
}

module connector() {
  union()
  {
    translate ([0, 0, -enclosure_thickness / 2])
      cube([enclosure_thickness, device_length, enclosure_thickness / 2]);
    translate ([enclosure_thickness / 2, 0, 0])
      hull()
      {
        translate ([0, enclosure_thickness, 0])
          cylinder (r1=(enclosure_thickness / 2),
                    r2=(enclosure_thickness / 6),
                    h=(enclosure_thickness / 2));
        translate ([0, device_length - enclosure_thickness, 0])
          cylinder (r1=(enclosure_thickness / 2),
                    r2=(enclosure_thickness / 6),
                    h=(enclosure_thickness / 2));
      }
  }
}

module foot () {
  rotate([180, 0, 180])
    hull()
    {
      cylinder (r1=foot_r, r2=(foot_r / 2), h=(foot_h / 2));
      translate ([0, foot_l, 0])
        cylinder (r1=foot_r, r2=(foot_r / 2), h=(foot_h / 2));
    }
}

// The 'positive space' of a lego block
module lego_positive(length) {
  num = ((length - (wall_thickness * 2)) / knob_spacing ) + 1;
  union()
  {
    cube([length, enclosure_thickness, enclosure_thickness]);
    translate([knob_diameter / 2 + wall_thickness,
               knob_diameter / 2 + wall_thickness, 0])
      for (xcount=[0:num-1])
        {
          translate([xcount * knob_spacing, 0, enclosure_thickness])
            cylinder(r=knob_diameter / 2, h=knob_height);
        }
  }
}

// The 'negative space' of a lego block
module lego_negative(length) {
  num = ((length - (wall_thickness * 2)) / knob_spacing ) + 1;
  difference()
    {
      translate([wall_thickness, wall_thickness, -0.1])
        cube([length - wall_thickness * 2,
              enclosure_thickness - wall_thickness * 2,
              knob_height]);
      for (xcount=[1:num-1])
        translate([xcount * knob_spacing, enclosure_thickness / 2, -0.1])
          cylinder(r=knob_diameter/4,h=knob_height);
    }
}

module front_panel () {
  difference()
    { 
      union()
      {
        cube([device_width + (enclosure_thickness * 2),
              device_height + (enclosure_thickness * 2), enclosure_thickness]);
        translate([0, enclosure_thickness, enclosure_thickness])
          rotate ([180, 0, 90])
          lego_positive (device_height);
        translate([device_width + enclosure_thickness, enclosure_thickness,
                   enclosure_thickness])
          rotate ([180, 0, 90])
          lego_positive (device_height);
      }
      translate([0, device_bottom_height + enclosure_thickness,
                 enclosure_thickness * 9 / 10])
        cube([device_width + (enclosure_thickness * 2),
              pcb_thickness, enclosure_thickness / 10]);
      add_port (front_port1, front_port1_position, front_port1_side, true,
                front_port1_custom_rectangle_width,
                front_port1_custom_rectangle_height,
                front_port1_custom_circle_radius,
                front_port1_custom_elevation);
      add_port (front_port2, front_port2_position, front_port2_side, true,
                front_port2_custom_rectangle_width,
                front_port2_custom_rectangle_height,
                front_port2_custom_circle_radius,
                front_port2_custom_elevation);
      add_port (front_port3, front_port3_position, front_port3_side, true,
                front_port3_custom_rectangle_width,
                front_port3_custom_rectangle_height,
                front_port3_custom_circle_radius,
                front_port3_custom_elevation);
      add_port (front_port4, front_port4_position, front_port4_side, true,
                front_port4_custom_rectangle_width,
                front_port4_custom_rectangle_height,
                front_port4_custom_circle_radius,
                front_port4_custom_elevation);
      add_port (front_port5, front_port5_position, front_port5_side, true,
                front_port5_custom_rectangle_width,
                front_port5_custom_rectangle_height,
                front_port5_custom_circle_radius,
                front_port5_custom_elevation);
    }
}

module back_panel () {
  difference()
    {
      union()
      {
        cube([device_width + (enclosure_thickness * 2),
              device_height + (enclosure_thickness * 2), enclosure_thickness]);
        translate([enclosure_thickness, enclosure_thickness, 0])
          rotate ([0, 0, 90])
          lego_positive (device_height);
        translate([device_width + 2 * enclosure_thickness,
                   enclosure_thickness, 0])
          rotate ([0, 0, 90])
          lego_positive (device_height);
      }
      translate([0, device_bottom_height + enclosure_thickness, 0])
        cube([device_width + (enclosure_thickness * 2),
              pcb_thickness, enclosure_thickness / 10]);
      add_port (back_port1, back_port1_position, back_port1_side, true,
                back_port1_custom_rectangle_width,
                back_port1_custom_rectangle_height,
                back_port1_custom_circle_radius,
                back_port1_custom_elevation);
      add_port (back_port2, back_port2_position, back_port2_side, true,
                back_port2_custom_rectangle_width,
                back_port2_custom_rectangle_height,
                back_port2_custom_circle_radius,
                back_port2_custom_elevation);
      add_port (back_port3, back_port3_position, back_port3_side, true,
                back_port3_custom_rectangle_width,
                back_port3_custom_rectangle_height,
                back_port3_custom_circle_radius,
                back_port3_custom_elevation);
      add_port (back_port4, back_port4_position, back_port4_side, true,
                back_port4_custom_rectangle_width,
                back_port4_custom_rectangle_height,
                back_port4_custom_circle_radius,
                back_port4_custom_elevation);
      add_port (back_port5, back_port5_position, back_port5_side, true,
                back_port5_custom_rectangle_width,
                back_port5_custom_rectangle_height,
                back_port5_custom_circle_radius,
                back_port5_custom_elevation);
    }
}

module right_panel() {
  difference ()
    {
      cube([device_length, device_height + (enclosure_thickness * 2),
            enclosure_thickness]);
      translate([0, device_bottom_height + enclosure_thickness,
                 enclosure_thickness * 9/10])
        cube([device_length, pcb_thickness, enclosure_thickness / 10 ]);
      translate([0, enclosure_thickness, 0])
        rotate([0, 0, -90])
        connector();
      translate([0, device_height + enclosure_thickness * 2, 0])
        rotate([0, 0, -90])
        connector();
      translate([0, enclosure_thickness, 0])
        rotate ([90, 0, 90])
        lego_negative (device_height);
      translate([device_length, enclosure_thickness, 0])
        mirror([1, 0, 0])
        rotate ([90, 0, 90])
        lego_negative (device_height);
      add_port (right_port1, right_port1_position, right_port1_side, false,
                right_port1_custom_rectangle_width,
                right_port1_custom_rectangle_height,
                right_port1_custom_circle_radius,
                right_port1_custom_elevation);
      add_port (right_port2, right_port2_position, right_port2_side, false,
                right_port2_custom_rectangle_width,
                right_port2_custom_rectangle_height,
                right_port2_custom_circle_radius,
                right_port2_custom_elevation);
      add_port (right_port3, right_port3_position, right_port3_side, false,
                right_port3_custom_rectangle_width,
                right_port3_custom_rectangle_height,
                right_port3_custom_circle_radius,
                right_port3_custom_elevation);
      add_port (right_port4, right_port4_position, right_port4_side, false,
                right_port4_custom_rectangle_width,
                right_port4_custom_rectangle_height,
                right_port4_custom_circle_radius,
                right_port4_custom_elevation);
      add_port (right_port5, right_port5_position, right_port5_side, false,
                right_port5_custom_rectangle_width,
                right_port5_custom_rectangle_height,
                right_port5_custom_circle_radius,
                right_port5_custom_elevation);
    }
}

module left_panel () {
  add_port (right_port2, right_port2_position, right_port2_side, false);
  difference ()
    {
      cube([device_length, device_height + enclosure_thickness * 2,
            enclosure_thickness]);
      translate([0, device_bottom_height + enclosure_thickness, 0])
        cube([device_length, pcb_thickness, enclosure_thickness / 10]);
      translate([0, device_height + enclosure_thickness, enclosure_thickness])
          rotate([180, 0, 90])      
          connector();
      translate([0, 0, enclosure_thickness])
          rotate([180, 0, 90])
          connector();
      translate([0, enclosure_thickness, 0])
        rotate ([90, 0, 90])
        lego_negative (device_height);
      translate([device_length, enclosure_thickness, 0])
        mirror([1, 0, 0])
        rotate ([90, 0, 90])
        lego_negative (device_height);
      add_port (left_port1, left_port1_position, left_port1_side, false,
                left_port1_custom_rectangle_width,
                left_port1_custom_rectangle_height,
                left_port1_custom_circle_radius,
                left_port1_custom_elevation);
      add_port (left_port2, left_port2_position, left_port2_side, false,
                left_port2_custom_rectangle_width,
                left_port2_custom_rectangle_height,
                left_port2_custom_circle_radius,
                left_port2_custom_elevation);
      add_port (left_port3, left_port3_position, left_port3_side, false,
                left_port3_custom_rectangle_width,
                left_port3_custom_rectangle_height,
                left_port3_custom_circle_radius,
                left_port3_custom_elevation);
      add_port (left_port4, left_port4_position, left_port4_side, false,
                left_port4_custom_rectangle_width,
                left_port4_custom_rectangle_height,
                left_port4_custom_circle_radius,
                left_port4_custom_elevation);
      add_port (left_port5, left_port5_position, left_port5_side, false,
                left_port5_custom_rectangle_width,
                left_port5_custom_rectangle_height,
                left_port5_custom_circle_radius,
                  left_port5_custom_elevation);
    }
}

module top_panel () {
  union () 
  {
    cube ([device_width, device_length, enclosure_thickness]);
    translate([device_width, 0, enclosure_thickness])
      rotate([0, 90, 0])
      connector();
    translate([0, 0, 0])
      rotate([0, -90, 0])
      connector();
  }
}

module bottom_panel () {
  union () 
  {
    cube ([device_width, device_length, enclosure_thickness]);
    translate([device_width, 0, enclosure_thickness])
      rotate([0, 90, 0])
      connector();
    rotate([0, -90, 0])
      connector();
    
    translate([2 * foot_r, 2 * foot_r, 0])
      foot();
    translate([2 * foot_r, device_length - foot_l - 2 * foot_r, 0])
      foot();
    translate([device_width - 2 * foot_r, 2 * foot_r, 0])
      foot();
    translate([device_width - 2 * foot_r, device_length - foot_l - 2 * foot_r, 0])
      foot();
  }
}

module enclosure(padx = 0, pady = 0) {
  translate ([0, -padx + enclosure_thickness, 0])
    rotate([90, 0, 0])
    front_panel();
  translate ([0, padx + device_length + (enclosure_thickness * 2), 0])
    rotate([90, 0, 0])
    back_panel();
  translate ([-pady, enclosure_thickness, 0])
    rotate([90, 0, 90])
    left_panel();
  translate ([pady + device_width + enclosure_thickness,
        enclosure_thickness, 0])
    rotate([90, 0, 90])
    right_panel();
  translate ([enclosure_thickness, enclosure_thickness,
              device_height + enclosure_thickness])
    top_panel();
  translate ([enclosure_thickness, enclosure_thickness, 0])
    bottom_panel();
}

module animate() {
  if ($t < 0.5)
    enclosure($t * enclosure_thickness * 10, 0);
  else
    enclosure(enclosure_thickness * 10,
              ($t - 0.5) * enclosure_thickness * 10);
}


module main() {
  if (show_face == "open")
    enclosure(enclosure_thickness * 5, enclosure_thickness * 5);
  else if (show_face == "closed")
    enclosure(0, 0);
  else if (show_face == "left")
    left_panel();
  else if (show_face == "right")
    right_panel();
  else if (show_face == "top")
    top_panel();
  else if (show_face == "bottom")
    translate([0, 0, enclosure_thickness]) rotate([0, 180, 0]) bottom_panel();
  else if (show_face == "front")
    translate([0, 0, enclosure_thickness]) rotate([0, 180, 0]) front_panel();
  else if (show_face == "back")
    back_panel();
}

$fn = 20;
main();

