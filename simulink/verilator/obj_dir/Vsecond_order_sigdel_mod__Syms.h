// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table internal header
//
// Internal details; most calling programs do not need this header

#ifndef _Vsecond_order_sigdel_mod__Syms_H_
#define _Vsecond_order_sigdel_mod__Syms_H_

#include "verilated.h"

// INCLUDE MODULE CLASSES
#include "Vsecond_order_sigdel_mod.h"
#include "Vsecond_order_sigdel_mod_second_order_sigdel_mod.h"

// DPI TYPES for DPI Export callbacks (Internal use)

// SYMS CLASS
class Vsecond_order_sigdel_mod__Syms : public VerilatedSyms {
  public:
    
    // LOCAL STATE
    const char* __Vm_namep;
    bool	__Vm_activity;		///< Used by trace routines to determine change occurred
    bool	__Vm_didInit;
    //char	__VpadToAlign10[6];
    
    // SUBCELL STATE
    Vsecond_order_sigdel_mod*      TOPp;
    Vsecond_order_sigdel_mod_second_order_sigdel_mod TOP__v;
    
    // COVERAGE
    
    // SCOPE NAMES
    VerilatedScope __Vscope_TOP;
    VerilatedScope __Vscope_v;
    
    // CREATORS
    Vsecond_order_sigdel_mod__Syms(Vsecond_order_sigdel_mod* topp, const char* namep);
    ~Vsecond_order_sigdel_mod__Syms() {};
    
    // METHODS
    inline const char* name() { return __Vm_namep; }
    inline bool getClearActivity() { bool r=__Vm_activity; __Vm_activity=false; return r;}
    
} VL_ATTR_ALIGNED(64);

#endif  /*guard*/
