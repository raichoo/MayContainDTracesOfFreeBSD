authenticate: authenticate.c secret.h
	cc authenticate.c -o authenticate

driver: Driver.hs
	stack --resolver lts-9.18 exec ghc -- Driver.hs -o driver

fork: fork.hs
	ghc-head -threaded fork.hs

all: driver authenticate fork

clean:
	rm Driver.o Driver.hi authenticate driver fork.o fork.hi fork

timing: authenticate driver
	dtrace -s timing.d -p `pgrep -n authenticate`

providers:
	dtrace -l | sed -e 1d -e 's/^ *//' | cut -w -f2 | sort -u | nl | grep --color -E ' |syscall|fbt'
