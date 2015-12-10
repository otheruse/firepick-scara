
// 
drive_rod_diameter = 8;
// Guidance rods and linear bearings dimensions
rod_diameter = 8;
bearing_diameter = 15;
bearing_length = 24;

arm1_length = 150; // Length of first arm
arm2_length = 150; // Length of second arm
connector_length = 60; // length of pipe connector of first arm
tool_dia = 30; // Diameter of tool head

rodspacing = 175;		// Distance between rods:	175 standard, 190 wide
PVC_pipe_OD = 32;		// Default 32mm
PVC_pipe_ID = 26;	// measure pipe ID to adjust
Drive_pipe_OD = 22.5;	// Drive pipe outter diameter: 22mm default

function nutDia(nominalDiameter) = nominalDiameter*1.8 + 1;
function boltDia(nominalDiameter) = nominalDiameter + 0.2;
function nutHeight(nominalDiameter) = nominalDiameter*0.8 + 0.4;
function nutSlot(nominalDiameter) = nominalDiameter*1.8 + 0.4;

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
