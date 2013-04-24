// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Primary design header
//
// This header should be included by all source files instantiating the design.
// The class here is then constructed to instantiate the design.
// See the Verilator manual for examples.

#ifndef _Vsecond_order_sigdel_mod_H_
#define _Vsecond_order_sigdel_mod_H_

#include "verilated.h"
#include "Vsecond_order_sigdel_mod__Dpi.h"

class Vsecond_order_sigdel_mod__Syms;
class Vsecond_order_sigdel_mod_second_order_sigdel_mod;

//----------

VL_MODULE(Vsecond_order_sigdel_mod) {
  public:
    // CELLS
    // Public to allow access to /*verilator_public*/ items;
    // otherwise the application code can consider these internals.
    Vsecond_order_sigdel_mod_second_order_sigdel_mod*	v;
    
    // PORTS
    // The application code writes and reads these signals to
    // propagate new values into/out from the Verilated model.
    VL_IN8(mod_clock,0,0);
    VL_OUT8(output_sig,0,0);
    //char	__VpadToAlign2[2];
    VL_IN(input_sig,23,0);
    
    // LOCAL SIGNALS
    // Internals; generally not touched by application code
    
    // LOCAL VARIABLES
    // Internals; generally not touched by application code
    VL_SIG8(__Vclklast__TOP__v__mod_clock,1,0);
    //char	__VpadToAlign17[3];
    
    // INTERNAL VARIABLES
    // Internals; generally not touched by application code
    Vsecond_order_sigdel_mod__Syms*	__VlSymsp;		// Symbol table
    
    // PARAMETERS
    // Parameters marked /*verilator public*/ for use by application code
    
    // CONSTRUCTORS
  private:
    Vsecond_order_sigdel_mod& operator= (const Vsecond_order_sigdel_mod&);	///< Copying not allowed
    Vsecond_order_sigdel_mod(const Vsecond_order_sigdel_mod&);	///< Copying not allowed
  public:
    /// Construct the model; called by application code
    /// The special name  may be used to make a wrapper with a
    /// single model invisible WRT DPI scope names.
    Vsecond_order_sigdel_mod(const char* name="TOP");
    /// Destroy the model; called (often implicitly) by application code
    ~Vsecond_order_sigdel_mod();
    
    // USER METHODS
    
    // API METHODS
    /// Evaluate the model.  Application must call when inputs change.
    void eval();
    /// Simulation complete, run final blocks.  Application must call on completion.
    void final();
    
    // INTERNAL METHODS
  private:
    static void _eval_initial_loop(Vsecond_order_sigdel_mod__Syms* __restrict vlSymsp);
  public:
    void __Vconfigure(Vsecond_order_sigdel_mod__Syms* symsp, bool first);
  private:
    static IData	_change_request(Vsecond_order_sigdel_mod__Syms* __restrict vlSymsp);
  public:
    static void	_combo__TOP__1(Vsecond_order_sigdel_mod__Syms* __restrict vlSymsp);
    static void	_eval(Vsecond_order_sigdel_mod__Syms* __restrict vlSymsp);
    static void	_eval_initial(Vsecond_order_sigdel_mod__Syms* __restrict vlSymsp);
    static void	_eval_settle(Vsecond_order_sigdel_mod__Syms* __restrict vlSymsp);
    static void	_settle__TOP__3(Vsecond_order_sigdel_mod__Syms* __restrict vlSymsp);
} VL_ATTR_ALIGNED(128);

#endif  /*guard*/
