LMxUU = 8;				// Choose linear bearing: 8 or 12mm
rodspacing = 175;		// Distance between rods:	175 standard, 190 wide
PVC_pipe_OD = 32;		// Default 32mm
PVC_pipe_ID = 26;	// measure pipe ID to adjust
Drive_pipe_OD = 22.5;	// Drive pipe outter diameter: 22mm default
THREADLESS = true;	// True for use of threadless ball screw in z-bracket
SUPPORTED_ROD = true;	// Rods held by Z-mounts - False for platform mounted (lasercut)
Leadnut_thread = false;// Apply the thread of the leadscrew nut to the Z coupler

ENVELOPE_CHECK = false;

function nutDia(nominalDiameter) = nominalDiameter *2 + 0.8;
function boltDia(nominalDiameter) = nominalDiameter + 0.2;
function nutHeight(nominalDiameter) = nominalDiameter*0.8 + 0.6;
function nutSlot(nominalDiameter) = nominalDiameter*1.7333 + 0.4;

pi = 3.1415926536;

m3_dia = boltDia(3);
m3_nut_dia = nutDia(3);
m3_nut_slot = nutSlot(3);
m3_nut_height = nutHeight(3);

m4_dia = boltDia(4);
m4_nut_dia = nutDia(4);
m4_nut_height = nutHeight(4);

m8_dia = boltDia(8);
m8_nut_dia = nutDia(8);
m8_nut_height = nutHeight(8);

print_layer_height = 0.25;
