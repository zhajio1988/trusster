/*
Trusster Open Source License version 1.0a (TRUST)
copyright (c) 2006 Mike Mintz and Robert Ekendahl.  All rights reserved. 

Redistribution and use in source and binary forms, with or without modification, 
are permitted provided that the following conditions are met: 
   
  * Redistributions of source code must retain the above copyright notice, 
    this list of conditions and the following disclaimer.
  * Redistributions in binary form must reproduce the above copyright notice, 
    this list of conditions and the following disclaimer in the documentation 
    and/or other materials provided with the distribution.
  * Redistributions in any form must be accompanied by information on how to obtain 
    complete source code for this software and any accompanying software that uses this software.
    The source code must either be included in the distribution or be available in a timely fashion for no more than 
    the cost of distribution plus a nominal fee, and must be freely redistributable under reasonable and no more 
    restrictive conditions. For an executable file, complete source code means the source code for all modules it 
    contains. It does not include source code for modules or files that typically accompany the major components 
    of the operating system on which the executable file runs.
 

THIS SOFTWARE IS PROVIDED BY MIKE MINTZ AND ROBERT EKENDAHL ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, 
INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, 
OR NON-INFRINGEMENT, ARE DISCLAIMED. IN NO EVENT SHALL MIKE MINTZ AND ROBERT EKENDAHL OR ITS CONTRIBUTORS 
BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, 
BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; 
OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, 
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, 
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

`include "driver.svh"

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function alu_driver::new (string name, virtual alu_input a);
   super.new (name);
   alu_input_ = a;
//   log_.show_debug_level (4); 
endfunction

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
task alu_driver::send_operation (alu_operation an_operation);
  alu_input_.operand_a <= an_operation.operand_a;
  alu_input_.operand_b <= an_operation.operand_b;
  alu_input_.op_code   <= an_operation.op_code;
  alu_input_.op_valid <= 1;
//   log_.debug ({"Drive: ", an_operation.sreport ()});

  @ (posedge (alu_input_.operation_done));
  alu_input_.op_valid <= 0;
  @ (negedge (alu_input_.operation_done));
endtask

task alu_driver::time_zero_setup ();                       log_.debug (" time_zero_setup"); endtask
task alu_driver::out_of_reset (truss::reset r);                     log_.debug (" out of reset"); endtask
task alu_driver::start ();                                 log_.debug (" start "); endtask
task alu_driver::stop ();                                  log_.debug (" stop"); endtask
task alu_driver::randomize2 ();                             log_.debug (" randomize"); endtask
task alu_driver::write_to_hardware ();                     log_.debug (" write to hardware"); endtask
task alu_driver::wait_for_completion ();                   log_.debug (" wait_for_completion"); endtask
function void alu_driver::report (string prefix);          log_.debug ({prefix, " report"}); endfunction


