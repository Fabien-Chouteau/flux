with Flux_Benchmark;

with RP.Timer;

package RP2040_Bench_Timer is

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
      Acc : RP.Timer.Time := RP.Timer.Time'First;
      Last_Start : RP.Timer.Time := RP.Timer.Time'First;
   end record;

end RP2040_Bench_Timer;
