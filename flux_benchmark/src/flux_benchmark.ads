package Flux_Benchmark is

   type Timer is interface;

   procedure Reset (This : in out Timer) is abstract;
   procedure Start (This : in out Timer) is abstract;
   procedure Stop (This : in out Timer) is abstract;
   function Elapsed (This : Timer) return Duration is abstract;

end Flux_Benchmark;
