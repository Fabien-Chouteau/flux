package body Stopwatch_Timer is

   overriding
   procedure Reset (This : in out Instance) is
   begin
      This.W.Reset;
   end Reset;

   overriding
   procedure Start (This : in out Instance) is
   begin
      This.W.Release;
   end Start;

   overriding
   procedure Stop (This : in out Instance) is
   begin
      This.W.Hold;
   end Stop;

   overriding
   function Elapsed (This : Instance) return Duration
   is (This.W.Elapsed);

end Stopwatch_Timer;
