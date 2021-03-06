include <configuration.scad>
include <MCAD/teardrop.scad>
include <BearingMount.scad>
include <BearingScrew.scad>

module BracketBase(bearing_diameter = 15, bearing_length = 24){
	difference(){
		union(){
			translate([(rodspacing)/2,0,0])
				rotate([0,0,90])BracketBearingMount(bearing_diameter = bearing_diameter, bearing_length = bearing_length);
			translate([(rodspacing)/-2,0,0])
				rotate([0,0,-90])mirror()BracketBearingMount(bearing_diameter = bearing_diameter, bearing_length = bearing_length);
			difference(){
			  union(){
				translate([0,-14.5,25]){
					cube([rodspacing,3,50],center=true);
						
				}
			
				translate([0,-25.5,1.5]){
					intersection(){
						cube ([rodspacing+20, 25, 3],center=true);
						translate([0,rodspacing*1.5-6,-2])	
							cylinder(r=rodspacing*1.5, h=5);

					}			
				}
			  }
		
			}		
			cylinder(r=23,h=50);
		}

		cylinder(r=19,h=50);
		translate([-25,-13,0])
		cube([50,50,50]);

		translate([45,-30,22])
			rotate([0,0,90])
				teardrop(16, 50, 90);
				
		translate([-45,-30,22])
			rotate([0,0,90])
				teardrop(16, 50, 90);
				
		// Magnet hole
//		#translate([rodspacing/-2+LMxUU/1.5, LMxUU*-1.756, 0])
//			cylinder(d=5, h=3);
	}
}

module BracketBearingMount(bearing_diameter = 15, bearing_length = 24) {
    bearing_count=3;
    mount_height = (bearing_length+2)*3+2;
    wall_thickness = 3;

    difference() {
        // bearing tube base
        hull() {
            translate([-13+bearing_diameter/2, 0, 0])cylinder(d=bearing_diameter + 2*wall_thickness, h = mount_height);
            cylinder(d=bearing_diameter + 2*wall_thickness, h = mount_height);
        }
        cylinder(d=bearing_diameter, h = mount_height);
       // slice half off
        translate([0,-bearing_diameter/2 - wall_thickness,-1])cube([bearing_diameter+2*wall_thickness, bearing_diameter+2*wall_thickness, mount_height+2]);
    }
    // bearing tube
    BearingTube(bearing_od = bearing_diameter, bearing_h=bearing_length, bearing_count=bearing_count, wall_thickness = wall_thickness);
    // screw mounts
    translate([0,-bearing_diameter/2,15])screwMount(thickness = 11, hex=false);
    translate([0,-bearing_diameter/2,mount_height-15])screwMount(thickness = 11, hex=false);
    translate([0,bearing_diameter/2,15])mirror([0,1,0])screwMount(thickness = 13, hex=false);
    translate([0,bearing_diameter/2,mount_height-15])mirror([0,1,0])screwMount(thickness = 11, hex=false);
    //Limit switch interruptors
    hull() {
        translate([-bearing_diameter/2-5,0,mount_height-0.5])rotate([90,0,0])cylinder(d=1, h=1,center = true);
        translate([-bearing_diameter/2-18,0,mount_height-8])rotate([90,0,0])cylinder(d=1, h=1,center = true);
        translate([-bearing_diameter/2-5,0,mount_height-25])rotate([90,0,0])cylinder(d=1, h=1,center = true);
        translate([-bearing_diameter/2-18,0,mount_height-0.5])rotate([90,0,0])cylinder(d=1, h=1,center = true);
    }
    hull() {
        translate([-bearing_diameter/2-5,0,0.5])rotate([90,0,0])cylinder(d=1, h=1,center = true);
        translate([-bearing_diameter/2-18,0,8])rotate([90,0,0])cylinder(d=1, h=1,center = true);
        translate([-bearing_diameter/2-5,0,25])rotate([90,0,0])cylinder(d=1, h=1,center = true);
        translate([-bearing_diameter/2-18,0,0.5])rotate([90,0,0])cylinder(d=1, h=1,center = true);
    }
}


module ZMountBracketIntegrated() {
    translate([0,-40,0])rotate([0,0,90])BearingScrew();
    difference() {
        union() {
            BracketBase(16);
            translate([-12,-28,0])cube([24,15,13]);
        }
        translate([0,-40,0])cylinder(d=37, h=13);
        cylinder(r=20, h=13);
        translate([(rodspacing)/2-(9+m3_nut_dia/2),-12,15])rotate([90,0,0])cylinder(d=m3_nut_dia, h=20);
        translate([-(rodspacing)/2+(9+m3_nut_dia/2),-12,15])rotate([90,0,0])cylinder(d=m3_nut_dia, h=20);
    }
}

module ZMountBracket(bearing_diameter = 15, bearing_length = 24) {
//    screw_
    difference() {
        union() {
            BracketBase(bearing_diameter = bearing_diameter, bearing_length = bearing_length);
            // bearingscrew mount
            hull() {
                translate([0,-40,0])cylinder(d=39, h=6);
                translate([-19.5,-15,0])cube([39,1,6]);
            }
        }
        // Space for bearingScrew
        translate([0,-40,6])cylinder(d=39.5, h=20);
        // Printability
        translate([0,-40,26])cylinder(d1=39.5, d2=34.5, h=6);
        // axis
        translate([0,-40,0])cylinder(d=12, h=20);
        // drive tube
		cylinder(r=19,h=50);
        translate([0,-40,0])for (a=[0:120:359]) {
            // Mount holes
            rotate([0,0,a])translate([0,15, -1])cylinder(d=m4_dia, h=20);
        }
        // bearing mount screws
        translate([(rodspacing)/2-(bearing_diameter/2+1.5+m3_nut_dia/2),-9,15])rotate([90,0,0])cylinder(d=m3_nut_dia, h=20);
        translate([-(rodspacing)/2+(bearing_diameter/2+1.5+m3_nut_dia/2),-9,15])rotate([90,0,0])cylinder(d=m3_nut_dia, h=20);
    }
}

//$fa=3;
//$fs=0.2;
//ZMountBracket(bearing_diameter = 21, bearing_length = 30);

//color([1,0,0,1])translate([0,-50,0])
//ZMountBracket(bearing_diameter = 15, bearing_length = 24);
//%translate([0,-40,6])rotate([0,0,60])BearingScrew();

//%color([1,0,1,0.5])cylinder(d=Drive_pipe_OD, h=200, center=true);
