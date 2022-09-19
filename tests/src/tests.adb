with Ada.Text_IO;

with Flux_Benchmark.Traits;
with Flux_Benchmark.Interfaces;

with Stopwatch_Timer;

procedure Tests is
   Timer : Stopwatch_Timer.Instance;
begin

   Timer.Reset;
   Flux_Benchmark.Traits.Run_Producer (Timer);
   Ada.Text_IO.Put_Line ("Traits prod:" & Timer.Elapsed'Img & " sec");

   Timer.Reset;
   Flux_Benchmark.Traits.Run_Consumer (Timer);
   Ada.Text_IO.Put_Line ("Traits consumer:" & Timer.Elapsed'Img & " sec");

   Timer.Reset;
   Flux_Benchmark.Interfaces.Run_Producer (Timer);
   Ada.Text_IO.Put_Line ("Interfaces prod:" & Timer.Elapsed'Img & " sec");

   Timer.Reset;
   Flux_Benchmark.Interfaces.Run_Consumer (Timer);
   Ada.Text_IO.Put_Line ("Interfaces consumer:" & Timer.Elapsed'Img & " sec");

end Tests;
