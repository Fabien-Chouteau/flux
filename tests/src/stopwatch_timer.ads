with Flux_Benchmark;
with Stopwatch;

package Stopwatch_Timer is

   type Instance
   is new Flux_Benchmark.Timer
   with private;

   overriding
   procedure Reset (This : in out Instance);

   overriding
   procedure Start (This : in out Instance);

   overriding
   procedure Stop (This : in out Instance);

   overriding
   function Elapsed (This : Instance) return Duration;

private

   type Instance
   is new Flux_Benchmark.Timer
   with record
      W : Stopwatch.Instance;
   end record;

end Stopwatch_Timer;
