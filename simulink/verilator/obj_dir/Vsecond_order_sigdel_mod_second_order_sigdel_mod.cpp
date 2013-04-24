// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vsecond_order_sigdel_mod.h for the primary calling header

#include "Vsecond_order_sigdel_mod_second_order_sigdel_mod.h" // For This
#include "Vsecond_order_sigdel_mod__Syms.h"

#include "verilated_dpi.h"

//--------------------
// STATIC VARIABLES


//--------------------

VL_CTOR_IMP(Vsecond_order_sigdel_mod_second_order_sigdel_mod) {
    // Reset internal values
    // Reset structure values
    input_sig = VL_RAND_RESET_I(24);
    mod_clock = VL_RAND_RESET_I(1);
    output_sig = VL_RAND_RESET_I(1);
    __PVT__non_delaying_integrator_in = VL_RAND_RESET_I(25);
    __PVT__non_delaying_integrator_out = VL_RAND_RESET_I(25);
    __PVT__delaying_integrator_out = VL_RAND_RESET_I(25);
    __Vdly__delaying_integrator_out = VL_RAND_RESET_I(25);
}

void Vsecond_order_sigdel_mod_second_order_sigdel_mod::__Vconfigure(Vsecond_order_sigdel_mod__Syms* vlSymsp, bool first) {
    if (0 && first) {}  // Prevent unused
    this->__VlSymsp = vlSymsp;
}

Vsecond_order_sigdel_mod_second_order_sigdel_mod::~Vsecond_order_sigdel_mod_second_order_sigdel_mod() {
}

//--------------------
// Internal Methods

void Vsecond_order_sigdel_mod_second_order_sigdel_mod::_initial__TOP__v(Vsecond_order_sigdel_mod__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_PRINTF("  Vsecond_order_sigdel_mod_second_order_sigdel_mod::_initial__TOP__v\n"); );
    Vsecond_order_sigdel_mod* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    // INITIAL at ../../sigma_delta/second_order_sigdel_mod.v:28
    vlSymsp->TOP__v.__PVT__non_delaying_integrator_out = 0;
    // INITIAL at ../../sigma_delta/second_order_sigdel_mod.v:29
    vlSymsp->TOP__v.__PVT__delaying_integrator_out = 0;
}

void Vsecond_order_sigdel_mod_second_order_sigdel_mod::_sequent__TOP__v__1(Vsecond_order_sigdel_mod__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_PRINTF("  Vsecond_order_sigdel_mod_second_order_sigdel_mod::_sequent__TOP__v__1\n"); );
    Vsecond_order_sigdel_mod* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    vlSymsp->TOP__v.__Vdly__delaying_integrator_out 
	= vlSymsp->TOP__v.__PVT__delaying_integrator_out;
    // ALWAYS at ../../sigma_delta/second_order_sigdel_mod.v:35
    vlSymsp->TOP__v.__PVT__non_delaying_integrator_out 
	= vlSymsp->TOP__v.__PVT__non_delaying_integrator_in;
    // ALWAYS at ../../sigma_delta/second_order_sigdel_mod.v:36
    vlSymsp->TOP__v.__Vdly__delaying_integrator_out 
	= (0x1ffffff & (vlSymsp->TOP__v.__PVT__delaying_integrator_out 
			+ (vlSymsp->TOP__v.__PVT__non_delaying_integrator_in 
			   - VL_EXTENDS_II(25,24, (
						   (0x1000000 
						    & vlSymsp->TOP__v.__PVT__delaying_integrator_out)
						    ? 0x7fffff
						    : 0x800000)))));
    vlSymsp->TOP__v.__PVT__delaying_integrator_out 
	= vlSymsp->TOP__v.__Vdly__delaying_integrator_out;
    vlSymsp->TOP__v.output_sig = (1 & (vlSymsp->TOP__v.__PVT__delaying_integrator_out 
				       >> 0x18));
}

void Vsecond_order_sigdel_mod_second_order_sigdel_mod::_combo__TOP__v__2(Vsecond_order_sigdel_mod__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_PRINTF("  Vsecond_order_sigdel_mod_second_order_sigdel_mod::_combo__TOP__v__2\n"); );
    Vsecond_order_sigdel_mod* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    vlSymsp->TOP__v.__PVT__non_delaying_integrator_in 
	= (0x1ffffff & (vlSymsp->TOP__v.__PVT__non_delaying_integrator_out 
			+ (VL_EXTENDS_II(25,24, vlSymsp->TOP__v.input_sig) 
			   - VL_EXTENDS_II(25,24, (
						   (0x1000000 
						    & vlSymsp->TOP__v.__PVT__delaying_integrator_out)
						    ? 0x7fffff
						    : 0x800000)))));
}

void Vsecond_order_sigdel_mod_second_order_sigdel_mod::_settle__TOP__v__3(Vsecond_order_sigdel_mod__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_PRINTF("  Vsecond_order_sigdel_mod_second_order_sigdel_mod::_settle__TOP__v__3\n"); );
    Vsecond_order_sigdel_mod* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    vlSymsp->TOP__v.__PVT__non_delaying_integrator_in 
	= (0x1ffffff & (vlSymsp->TOP__v.__PVT__non_delaying_integrator_out 
			+ (VL_EXTENDS_II(25,24, vlSymsp->TOP__v.input_sig) 
			   - VL_EXTENDS_II(25,24, (
						   (0x1000000 
						    & vlSymsp->TOP__v.__PVT__delaying_integrator_out)
						    ? 0x7fffff
						    : 0x800000)))));
    vlSymsp->TOP__v.output_sig = (1 & (vlSymsp->TOP__v.__PVT__delaying_integrator_out 
				       >> 0x18));
}
