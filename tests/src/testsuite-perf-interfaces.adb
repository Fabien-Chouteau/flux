with Ada.Text_IO;

with Interfaces;

with Stopwatch;

with Flux.Interfaces;
with Flux.Interfaces.Bounded_Array.Duplex;
with Flux.Interfaces.LEB128;

package body Testsuite.Perf.Interfaces is

   Prod_Buffer : constant Flux.Interfaces.Bounded_Array.Duplex.Acc
     := new Flux.Interfaces.Bounded_Array.Duplex.Instance (Len => Buffer_Size);

   Consumer_Buffer : constant Flux.Interfaces.Bounded_Array.Duplex.Acc
     := new Flux.Interfaces.Bounded_Array.Duplex.Instance (Len => Buffer_Size);

   ------------------
   -- Run_Producer --
   ------------------

   procedure Run_Producer is

      procedure Encode_LEB128
      is new Flux.Interfaces.LEB128.Encode (Standard.Interfaces.Unsigned_32);

      Success : Boolean;

      Watch_Interfaces : Stopwatch.Instance;
   begin

      Watch_Interfaces.Release;
      for Count in 1 .. Number_Of_Iterations loop
         Prod_Buffer.Reset;
         for X in Standard.Interfaces.Unsigned_32'Range loop
            Encode_LEB128 (Prod_Buffer.all, X, Success);
            exit when not Success;
         end loop;
      end loop;

      Watch_Interfaces.Hold;

      Ada.Text_IO.Put_Line ("Producer Interfaces Elapsed: " &
                              Watch_Interfaces.Image);
   end Run_Producer;

   ------------------
   -- Run_Consumer --
   ------------------

   procedure Run_Consumer is

      procedure Decode_LEB128
      is new Flux.Interfaces.LEB128.Decode (Standard.Interfaces.Unsigned_32);

      Success : Boolean;

      Watch : Stopwatch.Instance;
      Val : Standard.Interfaces.Unsigned_32;
   begin

      for Count in 1 .. Number_Of_Iterations loop

         Watch.Hold;
         Consumer_Buffer.all := Prod_Buffer.all;
         Watch.Release;

         for X in Standard.Interfaces.Unsigned_32'Range loop
            Decode_LEB128 (Consumer_Buffer.all, Val, Success);
            exit when not Success;
         end loop;
      end loop;

      Watch.Hold;

      Ada.Text_IO.Put_Line ("Consumer Interfaces Elapsed: " & Watch.Image);
   end Run_Consumer;

end Testsuite.Perf.Interfaces;
