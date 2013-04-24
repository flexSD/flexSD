// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vsecond_order_sigdel_mod.h for the primary calling header

#ifndef _Vsecond_order_sigdel_mod_second_order_sigdel_mod_H_
#define _Vsecond_order_sigdel_mod_second_order_sigdel_mod_H_

#include "verilated.h"
#include "Vsecond_order_sigdel_mod__Dpi.h"

class Vsecond_order_sigdel_mod__Syms;

//----------

VL_MODULE(Vsecond_order_sigdel_mod_second_order_sigdel_mod) {
  public:
    // CELLS
    
    // PORTS
    VL_IN8(mod_clock,0,0);
    VL_OUT8(output_sig,0,0);
    //char	__VpadToAlign2[2];
    VL_IN(input_sig,23,0);
    
    // LOCAL SIGNALS
    VL_SIG(__PVT__non_delaying_integrator_in,25,0);
    VL_SIG(__PVT__non_delaying_integrator_out,25,0);
    VL_SIG(__PVT__delaying_integrator_out,25,0);
    
    // LOCAL VARIABLES
    VL_SIG(__Vdly__delaying_integrator_out,25,0);
    
    // INTERNAL VARIABLES
  private:
    //char	__VpadToAlign36[4];
    Vsecond_order_sigdel_mod__Syms*	__VlSymsp;		// Symbol table
  public:
    
    // PARAMETERS
    
    // CONSTRUCTORS
  private:
    Vsecond_order_sigdel_mod_second_order_sigdel_mod& operator= (const Vsecond_order_sigdel_mod_second_order_sigdel_mod&);	///< Copying not allowed
    Vsecond_order_sigdel_mod_second_order_sigdel_mod(const Vsecond_order_sigdel_mod_second_order_sigdel_mod&);	///< Copying not allowed
  public:
    Vsecond_order_sigdel_mod_second_order_sigdel_mod(const char* name="TOP");
    ~Vsecond_order_sigdel_mod_second_order_sigdel_mod();
    
    // USER METHODS
    
    // API METHODS
    
    // INTERNAL METHODS
    void __Vconfigure(Vsecond_order_sigdel_mod__Syms* symsp, bool first);
    static void	_combo__TOP__v__2(Vsecond_order_sigdel_mod__Syms* __restrict vlSymsp);
    static void	_initial__TOP__v(Vsecond_order_sigdel_mod__Syms* __restrict vlSymsp);
    static void	_sequent__TOP__v__1(Vsecond_order_sigdel_mod__Syms* __restrict vlSymsp);
    static void	_settle__TOP__v__3(Vsecond_order_sigdel_mod__Syms* __restrict vlSymsp);
} VL_ATTR_ALIGNED(128);

#endif  /*guard*/
