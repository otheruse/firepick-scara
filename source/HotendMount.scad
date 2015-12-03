include <configuration.scad>
include <ArmPsi.scad>

module Hotend_stack(Hotend_D = 16.2, Hotend_H = 10, Mount_H = 12)
{
	difference(){
		union(){
			
			cylinder(r=30/2, h=14 + Mount_H);
			cylinder(r=27/2, h=15 + Mount_H);

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

module E3DMount() {
    Mount_H = 12;
	difference(){
		union(){
			cylinder(d=30, h=14 + Mount_H);
			cylinder(d=27, h=15 + Mount_H);
            // 
            cylinder(d=25, h=25 + Mount_H);
        }
        E3DSlot(27+Mount_H);
        // Screw holes
        translate([0,-7,Mount_H+3])rotate([0,90,0])cylinder(d=m3_dia, h=40);
        translate([10.5,-7,Mount_H+3])rotate([0,-90,0])countersunkBolt(depth = 11, nominalDia = 3);
        translate([0,7,Mount_H+3])rotate([0,90,0])cylinder(d=m3_dia, h=40);
        translate([10.5,7,Mount_H+3])rotate([0,-90,0])countersunkBolt(depth = 11, nominalDia = 3);
        // Slice half off
        translate([-30,-30,0])cube([30,60,Mount_H+10]);
        // screw holes
        translate([-1,11,7])rotate([0,90,0])cylinder(d=m3_dia, h=5);
        translate([-1,-11,7])rotate([0,90,0])cylinder(d=m3_dia, h=5);
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

E3DMount();
//translate([0,30,0])E3DSlot(50);
