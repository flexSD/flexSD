// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table implementation internals

#include "Vsecond_order_sigdel_mod__Syms.h"
#include "Vsecond_order_sigdel_mod.h"
#include "Vsecond_order_sigdel_mod_second_order_sigdel_mod.h"

// FUNCTIONS
Vsecond_order_sigdel_mod__Syms::Vsecond_order_sigdel_mod__Syms(Vsecond_order_sigdel_mod* topp, const char* namep)
	// Setup locals
	: __Vm_namep(namep)
	, __Vm_activity(false)
	, __Vm_didInit(false)
	// Setup submodule names
	, TOP__v                         (Verilated::catName(topp->name(),"v"))
{
    // Pointer to top level
    TOPp = topp;
    // Setup each module's pointers to their submodules
    TOPp->v                         = &TOP__v;
    // Setup each module's pointer back to symbol table (for public functions)
    TOPp->__Vconfigure(this, true);
    TOP__v.__Vconfigure(this, true);
    // Setup scope names
    __Vscope_TOP.configure(this,name(),"TOP");
    __Vscope_v.configure(this,name(),"v");
    // Setup export functions
    for (int __Vfinal=0; __Vfinal<2; __Vfinal++) {
	__Vscope_TOP.varInsert(__Vfinal,"input_sig", &(TOPp->input_sig), VLVT_UINT32,VLVD_IN|VLVF_PUB_RW,1 ,23,0);
	__Vscope_TOP.varInsert(__Vfinal,"mod_clock", &(TOPp->mod_clock), VLVT_UINT8,VLVD_IN|VLVF_PUB_RW,0);
	__Vscope_TOP.varInsert(__Vfinal,"output_sig", &(TOPp->output_sig), VLVT_UINT8,VLVD_OUT|VLVF_PUB_RW,0);
	__Vscope_v.varInsert(__Vfinal,"input_sig", &(TOP__v.input_sig), VLVT_UINT32,VLVD_IN|VLVF_PUB_RW,1 ,23,0);
	__Vscope_v.varInsert(__Vfinal,"mod_clock", &(TOP__v.mod_clock), VLVT_UINT8,VLVD_IN|VLVF_PUB_RW,0);
	__Vscope_v.varInsert(__Vfinal,"output_sig", &(TOP__v.output_sig), VLVT_UINT8,VLVD_OUT|VLVF_PUB_RW,0);
    }
}
