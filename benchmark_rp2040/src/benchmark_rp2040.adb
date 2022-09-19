with Flux_Benchmark.Interfaces;
with Flux_Benchmark.Traits;

with RP2040_Bench_Timer;

with Ada.Text_IO;

procedure Benchmark_Rp2040 is
   Timer : RP2040_Bench_Timer.Instance;
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

end Benchmark_Rp2040;
