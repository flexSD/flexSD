// --------------------------------------------------------------------
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// --------------------------------------------------------------------
// Copyright (c) 2005 by Lattice Semiconductor Corporation
// --------------------------------------------------------------------
//
//
//                     Lattice Semiconductor Corporation
//                     5555 NE Moore Court
//                     Hillsboro, OR 97214
//                     U.S.A.
//
//                     TEL: 1-800-Lattice  (USA and Canada)
//                          1-408-826-6000 (other locations)
//
//                     web: http://www.latticesemi.com/
//                     email: techsupport@latticesemi.com
//
// --------------------------------------------------------------------
//
// Simulation Library File for ECP2
//
// $Header: /home/dmsys/pvcs/RCSMigTest/rcs/verilog/pkg/versclibs/data/ecp2/RCS/FSUB2B.v,v 1.1 2005/07/08 14:28:41 pradeep Exp $ 
//
`resetall
`timescale 1 ns / 1 ps

`celldefine

module FSUB2B (A0, A1, B0, B1, BI, BOUT, S0, S1);
  input  A0, A1, B0, B1, BI;
  output BOUT, S0, S1;

wire BOUT0;

  and INST10 (I3, BI, I9);
  and INST11 (I4, A0, BI);
  or INST12 (BOUT0, I3, I4, I5);
  xor INST13 (S0, A0, I9, BI);
  not INST19 (I9, B0);
  and INST2 (I5, I9, A0);

  xor INST23 (S1, A1, I22, BOUT0);
  or INST24 (BOUT, I32, I31, I30);
  and INST25 (I31, A1, BOUT0);
  and INST26 (I32, BOUT0, I22);
  and INST27 (I30, I22, A1);
  not INST35 (I22, B1);


endmodule 
`endcelldefine
