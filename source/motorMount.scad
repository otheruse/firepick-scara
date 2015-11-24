include <shapes.scad>
include <configuration.scad>

module Motor(MotorH = 50, MotorW = 42){
	translate([0,0,MotorH/2])
		intersection(){
			cube([MotorW*1.285,MotorW*1.285,MotorH],center=true);
			rotate([0,0,45])
				cube([MotorW,MotorW,MotorH],center=true);
		}

}

module MotorMount(Height = 50, Mheight = 48){

	if (Height < Mheight+2)
	{
		echo ("Help");
	}	
	
	rotate([0,90,0])
	{
		difference(){
			
			union() {
				Motor(Height + 4, 44+10);
                // base plates
				translate([0,30,0])
					cylinder(r=20,h=4);
				translate([0,-25,0])
					cylinder(r=20,h=4);

                // Support structure
				intersection(){
                    support_width = 3;
					union(){
						translate([10,-32,25])
							rotate([0,0,-45])
								cube([13,support_width,50],center=true);
						mirror()
				  			translate([10,-32,25])
								rotate([0,0,-45])
									cube([13,support_width,50],center=true);
		
						translate([10,32,25])
							rotate([0,0,45])
								cube([13,support_width,50],center=true);
						mirror()
				  			translate([10,32,25])
								rotate([0,0,45])
									cube([13,support_width,50],center=true);
					}

					cylinder(r1=40, r2=29, h=50);
				}

			}
			translate([0,0,0])
				Motor(Height, 44);
			translate([65,0,25])
				cube([100,100,100],center=true);
			translate([-65,0,25])
				cube([100,100,100],center=true);
			translate([0,22,Height - 5])
				cylinder(h=10,d=m3_dia);
			translate([0,-22,Height - 5])
				cylinder(h=10,d=m3_dia);
			translate([0,-38, 0])
				cylinder(h=10,d=m3_dia);
			intersection(){
				translate([0,25,5])
					cube([20,50,10],center=true);
				translate([0,-38,0])
					difference(){
						cylinder(r=79.5, h=10);
						cylinder(r=76.5, h=10);
					}
			}
			translate([0,0,Height - 5])
				cylinder(h=10,d=22);
			
			translate([0,0,Height/2])
				cube([37,37,Height],center=true);

		}
	} 

}

$fa=3;
$fs=0.3;
MotorMount(Height=50);
//MotorMount(Height=70);