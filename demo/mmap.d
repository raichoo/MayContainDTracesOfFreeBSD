syscall::mmap:entry
{
  self->follow = 1;
}

fbt:::
/self->follow/
{}

syscall::mmap:return
/self->follow/
{
  self->follow = 0;
  exit(0);
}
