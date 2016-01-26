include <MCAD/teardrop.scad>

include <configuration.scad>
include <ArmPsi.scad>

module Hotend_stack(Hotend_D = 16.2, Hotend_H = 10, Mount_H = 12)
{
	difference(){
		union(){
			
			cylinder(d=30, h=14 + Mount_H);
			cylinder(d=27, h=15 + Mount_H);

		}
			
		translate([0,0,-1])	
		union(){
			cylinder(r=Hotend_D/2,h=Hotend_H);		// Mounting Hole for Hotend
			translate([0,0,Hotend_H])
				cylinder(r=3, h=8);
			translate([0,0,Hotend_H+8])
				cylinder(r1=3,r2 = 3.9,h=16);
		}

		rotate([0,45,0])
			cube([1,30,1],center=true);		
	}

	
}

module HotendMount(Hotend_D = 16.2, Hotend_H = 12,Mount_H = 12, mountpiece = true){
	difference(){
		
		union(){
			Hotend_stack(Hotend_D = Hotend_D, Hotend_H = Hotend_H, Mount_H = Mount_H);
			// mounting piece
			if (mountpiece){
				difference(){
					translate([13,0,Mount_H-1])
						cube([8,12,20],center = true);
				
					translate([17,0,Mount_H-10])
						rotate([0,45,0])
							cube([12,13,12],center = true);
				}
			}
		}
		
	
		union(){
			translate([0,0,0])
				cylinder(d=12,h=16 + Mount_H);

		// Arm mounting holes with "drop" openings
		translate([-3,7,Mount_H+3])
			rotate([0,90,0])
				cylinder(r=2, h=45);
		translate([-6,7,Mount_H+3])
			rotate([0,90,0])
				cylinder(r=3.5, r2 = 2, h=3);
		translate([-16,7,Mount_H+3])
			rotate([0,90,0])
				cylinder(r=4,h=10);
		translate([-11,7,Mount_H+5.828])
			rotate([45,0,0])
				cube([10,4,4], center = true);

		
		#translate([-3,-7,Mount_H+3])
			rotate([0,90,0])
				cylinder(r=2, h=45);
		translate([-6,-7,Mount_H+3])
			rotate([0,90,0])
				cylinder(r=3.5, r2 = 2, h=3);
		
		translate([-16,-7,Mount_H+3])
			rotate([0,90,0])
				cylinder(r=4,h=10);
		translate([-11,-7,Mount_H+5.828])
			rotate([45,0,0])
				cube([10,4,4], center = true);
	
		// mounting holes for J-Head

		translate([6,20,Hotend_H-7])
			rotate([90,0,0])
				cylinder(r=1.5, h=40);
		translate([-6,20,Hotend_H-7])
			rotate([90,0,0])
				cylinder(r=1.5, h=40);

		// Subtract the beam
		translate([0,0,Mount_H-10])
			Beam(StackRadius = 30/2);

//		// M4 inner section  for 1.75 filament support
//		translate([0,0,0])
//			linear_extrude(h=400)
//				projection()
//					nutHole(6, tolerance = 0.5);
		}
	}
	//SupportCylinder (r1 = 2, r2 = 7, h=10);
//	translate([0,0,Hotend_H-1])
//		cylinder(r=Hotend_D / 2, h=.4);
}


module E3DSlot(height, top_dia = 20) {
    groove_bottom = 3.2; // thickness of flange below groove
    groove_support = 1.2;
    groove_len = 5.5; // height of groove
    groove_radius = 6.2; // diameter of groove
    flange_radius = 8.3; // diameter of flange
    translate([0,0,-10])cylinder(h=10,r=20);
    translate([0,0,-1])cylinder(h=height,r=groove_radius);
    translate([0,0,groove_support])cylinder(h=groove_bottom,r=flange_radius);
    translate([0,0,groove_bottom+groove_support])cylinder(h=2.5,r1=flange_radius,r2=groove_radius);
    translate([0,0,groove_len + groove_bottom + groove_support])cylinder(h=height-(groove_len + groove_bottom+groove_support),d=top_dia);
 

}

module countersunkBolt(depth, nominalDia) {
    cylinder(d1=boltDia(nominalDia), d2=nutDia(nominalDia), h = nutDia(nominalDia)-boltDia(nominalDia));
    translate([0,0,nutDia(nominalDia)-boltDia(nominalDia)])cylinder(d=nutDia(nominalDia), h=depth-(nutDia(nominalDia)-boltDia(nominalDia)));
    
}

module E3DMountBase(height = 37) {
	difference() {
		union(){ 
			cylinder(d=30, h=height-14);
            translate([0,0,height-11])rotate_extrude()translate([12,0])circle(d=3);
			translate([0,0,height-14])cylinder(d2=27, d1=30, h=3);
            cylinder(d=25, h=height);
        }
        E3DSlot(height = height+2);
    }
    // Print support
    color([1,0,0,1])translate([0,0,9.9-print_layer_height])cylinder(d=30, h=print_layer_height);
    color([1,0,0,1])translate([0,0,1.2-print_layer_height])cylinder(d=30, h=print_layer_height);
}

module E3DMountClamp() {
    difference() {
        union() {
            E3DMountBase();
            // screw mount
            translate([0,11,7])rotate([0,90,0])cylinder(d=m3_nut_dia+3, h=10);
            translate([0,-11,7])rotate([0,90,0])cylinder(d=m3_nut_dia+3, h=10);
        }
        E3DSlot(39);
        // Slice half off
        translate([-30,-30,0])cube([30,60,22]);
        // Slice top off
        translate([0,0,21.5])cylinder(d=40, h=60);
        // screw head space
        translate([5,11,7])rotate([0,90,0])cylinder(d=m3_nut_dia, h=10);
        translate([5,-11,7])rotate([0,90,0])cylinder(d=m3_nut_dia, h=10);
//        translate([8,11,7])teardrop(radius=m3_nut_dia/2, length=10, angle=90);
//        translate([8,-11,7])teardrop(radius=m3_nut_dia/2, length=10, angle=90);
        // screw holes
        translate([-1,11,7])rotate([0,90,0])cylinder(d=m3_dia, h=20);
        translate([-1,-11,7])rotate([0,90,0])cylinder(d=m3_dia, h=20);
    }
}

module E3DMount(height=70) {
	translate([0,0,height])rotate([180,0,0])difference(){
        E3DMountBase(height);
        // Screw holes
        translate([0,-7,height-22])rotate([0,90,0])cylinder(d=m3_dia, h=40);
        translate([10.5,-7,height-22])rotate([0,-90,0])countersunkBolt(depth = 11, nominalDia = 3);
        translate([0,7,height-22])rotate([0,90,0])cylinder(d=m3_dia, h=40);
        translate([10.5,7,height-22])rotate([0,-90,0])countersunkBolt(depth = 11, nominalDia = 3);
        // Slice half off
        translate([-30,-30,0])cube([30,60,height-15]);
        // screw holes
        translate([-1,11,7])rotate([0,90,0])cylinder(d=m3_dia, h=20);
        translate([-1,-11,7])rotate([0,90,0])cylinder(d=m3_dia, h=20);
        // nutslot
        translate([3,11,7])hull() {
            rotate([0,90,0])rotate([0,0,30])cylinder(d=m3_nut_slot, h=m3_nut_height, $fn=6);
            translate([0,4,0])rotate([0,90,0])rotate([0,0,30])cylinder(d=m3_nut_slot, h=m3_nut_height, $fn=6);
        }
        translate([3,-15,7])hull() {
            rotate([0,90,0])rotate([0,0,30])cylinder(d=m3_nut_slot, h=m3_nut_height, $fn=6);
            translate([0,4,0])rotate([0,90,0])rotate([0,0,30])cylinder(d=m3_nut_slot, h=m3_nut_height, $fn=6);
        }
    }
}

$fs = 0.2;
$fa = 2;
//translate([0,40,0])HotendMount();
//translate([8,-40,0])rotate([0,-90,0])countersunkBolt(8, 3);

//translate([0,0,37])rotate([180,0,0])E3DMount();
//rotate([0,0,180])E3DMountClamp();

E3DMount();
//translate([0,40,0])E3DMountClamp();
//translate([0,70,0])difference() {
//    cylinder(d=13, h=50);
//    cylinder(d=8, h=50);
//}
