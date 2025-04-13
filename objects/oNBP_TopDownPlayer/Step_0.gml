// Test
rb.addForce((keyboard_check(ord("D")) - keyboard_check(ord("A"))) * 20,
	(keyboard_check(ord("S")) - keyboard_check(ord("W"))) * 20);
rb.integrate(1 / 60);