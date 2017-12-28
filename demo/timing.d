#pragma D option dynvarsize=512m

int len;

BEGIN
{
  len = 0;
}

pid$$target:authenticate:check:entry
{
  self->enter = vtimestamp;
  self->arg = copyinstr(arg0);
}

pid$$target:authenticate:check:return
/self->enter/
{
  @timing[self->arg] = lquantize(vtimestamp - self->enter, 1000, 1200, 10);
  if (strlen(self->arg) != len) {
    len = strlen(self->arg);
    trunc(@timing);
  }
  self->enter = 0;
}

pid$$target:authenticate:check:return
/arg1 == 1/
{
  printf("Password is: %s\n", self->arg);
  exit(0);
}

pid$$target:authenticate:check:return
{
  self->arg = 0;
}

tick-3s
{
  printa(@timing);
}
