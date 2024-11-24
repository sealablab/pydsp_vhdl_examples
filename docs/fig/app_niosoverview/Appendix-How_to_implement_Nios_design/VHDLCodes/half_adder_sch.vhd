-- Copyright (C) 1991-2011 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- PROGRAM		"Quartus II 32-bit"
-- VERSION		"Version 11.1 Build 259 01/25/2012 Service Pack 2 SJ Web Edition"
-- CREATED		"Tue May 30 09:11:26 2017"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY half_adder_sch IS 
	PORT
	(
		x :  IN  STD_LOGIC;
		y :  IN  STD_LOGIC;
		sum :  OUT  STD_LOGIC;
		carry :  OUT  STD_LOGIC
	);
END half_adder_sch;

ARCHITECTURE bdf_type OF half_adder_sch IS 



BEGIN 



carry <= x AND y;


sum <= x XOR y;


END bdf_type;