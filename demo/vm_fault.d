#pragma D option quiet

/* protection codes */
inline vm_prot_t VM_PROT_NONE         = 0x00;
inline vm_prot_t VM_PROT_READ         = 0x01;
inline vm_prot_t VM_PROT_WRITE        = 0x02;
inline vm_prot_t VM_PROT_EXECUTE      = 0x04;
inline vm_prot_t VM_PROT_COPY         = 0x08; /* copy-on-read */
inline vm_prot_t VM_PROT_FAULT_LOOKUP = 0x10;

inline vm_prot_t VM_PROT_ALL = VM_PROT_READ|VM_PROT_WRITE|VM_PROT_EXECUTE;
inline vm_prot_t VM_PROT_RW  = VM_PROT_READ|VM_PROT_WRITE;

inline string fault_type[vm_prot_t p] =
  p == VM_PROT_NONE         ? "VM_PROT_NONE" :
  p == VM_PROT_READ         ? "VM_PROT_READ" :
  p == VM_PROT_WRITE        ? "VM_PROT_WRITE" :
  p == VM_PROT_EXECUTE      ? "VM_PROT_EXECUTE" :
  p == VM_PROT_COPY         ? "VM_PROT_COPY" :
  p == VM_PROT_FAULT_LOOKUP ? "VM_PROT_FAULT_LOOKUP" :
  p == VM_PROT_ALL          ? "VM_PROT_ALL" :
  p == VM_PROT_RW           ? "VM_PROT_RW" :
  "";

/* fault options */
inline int VM_FAULT_NORMAL = 0; /* Nothing special */
inline int VM_FAULT_WIRE   = 1; /* Wire the mapped page */
inline int VM_FAULT_DIRTY  = 2; /* Dirty the page; use w/VM_PROT_COPY */

inline string fault_flags[int f] =
  f == VM_FAULT_NORMAL ? "VM_FAULT_NORMAL" :
  f == VM_FAULT_WIRE   ? "VM_FAULT_WIRE" :
  f == VM_FAULT_DIRTY  ? "VM_FAULT_DIRTY" :
  "";

fbt:kernel:vm_fault:entry
/pid != $pid/
{
  printf("Process: %s(%d) 0x%x\ntype: %s\nflags: %s\n"
        , execname
        , pid
        , arg1
        , fault_type[arg2]
        , fault_flags[arg3]
        );

  printf("\n");
  print(*args[0]);
  exit(0);
}
