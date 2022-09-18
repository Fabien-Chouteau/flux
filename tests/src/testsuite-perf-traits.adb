with Flux.Traits.Bounded_Array_Duplex;
with Flux.Traits.LEB128;

with Ada.Text_IO;

with Interfaces;

with Stopwatch;

package body Testsuite.Perf.Traits is

   Prod_Buffer : constant Flux.Traits.Bounded_Array_Duplex.Acc
     := new Flux.Traits.Bounded_Array_Duplex.Instance'(Len => Buffer_Size,
                                                            others => <>);

   Consumer_Buffer : constant Flux.Traits.Bounded_Array_Duplex.Acc
     := new Flux.Traits.Bounded_Array_Duplex.Instance'(Len => Buffer_Size,
                                                            others => <>);

   ------------------
   -- Run_Producer --
   ------------------

   procedure Run_Producer is

      procedure Encode_LEB128
      is new Flux.Traits.LEB128.Encode
        (Interfaces.Unsigned_32,
         Flux.Traits.Bounded_Array_Duplex.Sink_Traits);

      Success : Boolean;

      Watch : Stopwatch.Instance;
   begin
      Watch.Release;
      for Count in 1 .. Number_Of_Iterations loop

         Flux.Traits.Bounded_Array_Duplex.Reset (Prod_Buffer.all);

         for X in Interfaces.Unsigned_32'Range loop
            Encode_LEB128 (Prod_Buffer.all, X, Success);
            exit when not Success;
         end loop;
      end loop;
      Watch.Hold;

      Ada.Text_IO.Put_Line ("Producer Traits Elapsed: " & Watch.Image);
   end Run_Producer;

   ------------------
   -- Run_Producer --
   ------------------

   procedure Run_Consumer is

      procedure Decode_LEB128
      is new Flux.Traits.LEB128.Decode
        (Interfaces.Unsigned_32,
         Flux.Traits.Bounded_Array_Duplex.Seekable_Traits);

      Success : Boolean;

      Watch : Stopwatch.Instance;
      Val : Interfaces.Unsigned_32;
   begin

      for Count in 1 .. Number_Of_Iterations loop

         Watch.Hold;
         Consumer_Buffer.all := Prod_Buffer.all;
         Watch.Release;

         for X in Interfaces.Unsigned_32'Range loop
            Decode_LEB128 (Consumer_Buffer.all, Val, Success);
            exit when not Success;
         end loop;
      end loop;

      Watch.Hold;

      Ada.Text_IO.Put_Line ("Consumer Traits Elapsed: " & Watch.Image);
   end Run_Consumer;

end Testsuite.Perf.Traits;
