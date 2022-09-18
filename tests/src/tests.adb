
with Testsuite.Perf.Traits;
with Testsuite.Perf.Interfaces;

procedure Tests is

begin

   Testsuite.Perf.Traits.Run_Producer;
   Testsuite.Perf.Traits.Run_Consumer;

   Testsuite.Perf.Interfaces.Run_Producer;
   Testsuite.Perf.Interfaces.Run_Consumer;

end Tests;
