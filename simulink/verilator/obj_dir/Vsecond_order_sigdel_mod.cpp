// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vsecond_order_sigdel_mod.h for the primary calling header

#include "Vsecond_order_sigdel_mod.h" // For This
#include "Vsecond_order_sigdel_mod__Syms.h"

#include "verilated_dpi.h"

//--------------------
// STATIC VARIABLES


//--------------------

VL_CTOR_IMP(Vsecond_order_sigdel_mod) {
    Vsecond_order_sigdel_mod__Syms* __restrict vlSymsp = __VlSymsp = new Vsecond_order_sigdel_mod__Syms(this, name());
    Vsecond_order_sigdel_mod* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    VL_CELL (v, Vsecond_order_sigdel_mod_second_order_sigdel_mod);
    // Reset internal values
    
    // Reset structure values
    input_sig = VL_RAND_RESET_I(24);
    mod_clock = VL_RAND_RESET_I(1);
    output_sig = VL_RAND_RESET_I(1);
    __Vclklast__TOP__v__mod_clock = VL_RAND_RESET_I(1);
}

void Vsecond_order_sigdel_mod::__Vconfigure(Vsecond_order_sigdel_mod__Syms* vlSymsp, bool first) {
    if (0 && first) {}  // Prevent unused
    this->__VlSymsp = vlSymsp;
}

Vsecond_order_sigdel_mod::~Vsecond_order_sigdel_mod() {
    delete __VlSymsp; __VlSymsp=NULL;
}

//--------------------


void Vsecond_order_sigdel_mod::eval() {
    Vsecond_order_sigdel_mod__Syms* __restrict vlSymsp = this->__VlSymsp; // Setup global symbol table
    Vsecond_order_sigdel_mod* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Initialize
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) _eval_initial_loop(vlSymsp);
    // Evaluate till stable
    VL_DEBUG_IF(VL_PRINTF("\n----TOP Evaluate Vsecond_order_sigdel_mod::eval\n"); );
    int __VclockLoop = 0;
    IData __Vchange=1;
    while (VL_LIKELY(__Vchange)) {
	VL_DEBUG_IF(VL_PRINTF(" Clock loop\n"););
	vlSymsp->__Vm_activity = true;
	_eval(vlSymsp);
	__Vchange = _change_request(vlSymsp);
	if (++__VclockLoop > 100) vl_fatal(__FILE__,__LINE__,__FILE__,"Verilated model didn't converge");
    }
}

void Vsecond_order_sigdel_mod::_eval_initial_loop(Vsecond_order_sigdel_mod__Syms* __restrict vlSymsp) {
    vlSymsp->__Vm_didInit = true;
    _eval_initial(vlSymsp);
    vlSymsp->__Vm_activity = true;
    int __VclockLoop = 0;
    IData __Vchange=1;
    while (VL_LIKELY(__Vchange)) {
	_eval_settle(vlSymsp);
	_eval(vlSymsp);
	__Vchange = _change_request(vlSymsp);
	if (++__VclockLoop > 100) vl_fatal(__FILE__,__LINE__,__FILE__,"Verilated model didn't DC converge");
    }
}

//--------------------
// Internal Methods

void Vsecond_order_sigdel_mod::_combo__TOP__1(Vsecond_order_sigdel_mod__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_PRINTF("    Vsecond_order_sigdel_mod::_combo__TOP__1\n"); );
    Vsecond_order_sigdel_mod* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    vlSymsp->TOP__v.input_sig = vlTOPp->input_sig;
    vlSymsp->TOP__v.mod_clock = vlTOPp->mod_clock;
}

void Vsecond_order_sigdel_mod::_settle__TOP__3(Vsecond_order_sigdel_mod__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_PRINTF("    Vsecond_order_sigdel_mod::_settle__TOP__3\n"); );
    Vsecond_order_sigdel_mod* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    vlTOPp->output_sig = vlSymsp->TOP__v.output_sig;
}

void Vsecond_order_sigdel_mod::_eval(Vsecond_order_sigdel_mod__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_PRINTF("    Vsecond_order_sigdel_mod::_eval\n"); );
    Vsecond_order_sigdel_mod* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    vlTOPp->_combo__TOP__1(vlSymsp);
    if (((IData)(vlSymsp->TOP__v.mod_clock) & (~ (IData)(vlTOPp->__Vclklast__TOP__v__mod_clock)))) {
	vlSymsp->TOP__v._sequent__TOP__v__1(vlSymsp);
    }
    vlSymsp->TOP__v._combo__TOP__v__2(vlSymsp);
    if (((IData)(vlSymsp->TOP__v.mod_clock) & (~ (IData)(vlTOPp->__Vclklast__TOP__v__mod_clock)))) {
	vlTOPp->_settle__TOP__3(vlSymsp);
    }
    // Final
    vlTOPp->__Vclklast__TOP__v__mod_clock = vlSymsp->TOP__v.mod_clock;
}

void Vsecond_order_sigdel_mod::_eval_initial(Vsecond_order_sigdel_mod__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_PRINTF("    Vsecond_order_sigdel_mod::_eval_initial\n"); );
    Vsecond_order_sigdel_mod* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    vlSymsp->TOP__v._initial__TOP__v(vlSymsp);
}

void Vsecond_order_sigdel_mod::final() {
    VL_DEBUG_IF(VL_PRINTF("    Vsecond_order_sigdel_mod::final\n"); );
    // Variables
    Vsecond_order_sigdel_mod__Syms* __restrict vlSymsp = this->__VlSymsp;
    Vsecond_order_sigdel_mod* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
}

void Vsecond_order_sigdel_mod::_eval_settle(Vsecond_order_sigdel_mod__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_PRINTF("    Vsecond_order_sigdel_mod::_eval_settle\n"); );
    Vsecond_order_sigdel_mod* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    vlTOPp->_combo__TOP__1(vlSymsp);
    vlSymsp->TOP__v._settle__TOP__v__3(vlSymsp);
    vlTOPp->_settle__TOP__3(vlSymsp);
}

IData Vsecond_order_sigdel_mod::_change_request(Vsecond_order_sigdel_mod__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_PRINTF("    Vsecond_order_sigdel_mod::_change_request\n"); );
    Vsecond_order_sigdel_mod* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    // Change detection
    IData __req = false;  // Logically a bool
    return __req;
}
