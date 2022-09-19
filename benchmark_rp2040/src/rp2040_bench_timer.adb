with RP.Timer; use RP.Timer;

package body RP2040_Bench_Timer is

   overriding
   procedure Reset (This : in out Instance) is
   begin
      This.Acc := Time'First;
   end Reset;

   overriding
   procedure Start (This : in out Instance) is
   begin
      This.Last_Start := Clock;
   end Start;

   overriding
   procedure Stop (This : in out Instance) is
      Elapsed : constant Time := Clock - This.Last_Start;
   begin
      This.Acc := This.Acc + Elapsed;
   end Stop;

   overriding
   function Elapsed (This : Instance) return Duration
   is (Duration (This.Acc) / Duration (RP.Timer.Ticks_Per_Second));

end RP2040_Bench_Timer;
