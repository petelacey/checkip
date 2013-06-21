This is a Sinatra version of the CheckIP service.

Both the server and ab were run on my laptop:
  Intel Core i7 CPU M 620 @ 2.67GHz × 4
  3.7 GiB
  Ubuntu 12.10 (64-bit)

I benchmarked it on three different web servers using three different concurrency models.
All servers were started with their default configurations. No futher tuning was attempted.

Unicorn: Multi-process
Puma:    Multi-threaded (JRuby on JVM)
Thin:    Reactor pattern

As expected for this use case, the reactor pattern won.  You can see the various ab results
in the ab-{server-name].out files
