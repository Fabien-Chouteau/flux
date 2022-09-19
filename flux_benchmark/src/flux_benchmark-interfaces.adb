with Interfaces;

with Flux.Interfaces;
with Flux.Interfaces.Bounded_Array.Duplex;
with Flux.Interfaces.LEB128;

with Flux_Benchmark_Config;

package body Flux_Benchmark.Interfaces is

   Prod_Buffer : constant Flux.Interfaces.Bounded_Array.Duplex.Acc
     := new Flux.Interfaces.Bounded_Array.Duplex.Instance
       (Len => Flux_Benchmark_Config.Buffer_Size);

   Consumer_Buffer : constant Flux.Interfaces.Bounded_Array.Duplex.Acc
     := new Flux.Interfaces.Bounded_Array.Duplex.Instance
       (Len => Flux_Benchmark_Config.Buffer_Size);

   ------------------
   -- Run_Producer --
   ------------------

   procedure Run_Producer (T : in out Timer'Class) is

      procedure Encode_LEB128
      is new Flux.Interfaces.LEB128.Encode (Standard.Interfaces.Unsigned_32);

      Success : Boolean;

   begin

      T.Start;
      for Count in 1 .. Flux_Benchmark_Config.Number_Of_Iterations loop
         Prod_Buffer.Reset;
         for X in Standard.Interfaces.Unsigned_32'Range loop
            Encode_LEB128 (Prod_Buffer.all, X, Success);
            exit when not Success;
         end loop;
      end loop;

      T.Stop;
   end Run_Producer;

   ------------------
   -- Run_Consumer --
   ------------------

   procedure Run_Consumer (T : in out Timer'Class) is

      procedure Decode_LEB128
      is new Flux.Interfaces.LEB128.Decode (Standard.Interfaces.Unsigned_32);

      Success : Boolean;

      Val : Standard.Interfaces.Unsigned_32;
   begin

      for Count in 1 .. Flux_Benchmark_Config.Number_Of_Iterations loop

         T.Stop;
         Consumer_Buffer.all := Prod_Buffer.all;
         T.Start;

         for X in Standard.Interfaces.Unsigned_32'Range loop
            Decode_LEB128 (Consumer_Buffer.all, Val, Success);
            exit when not Success;
         end loop;
      end loop;

      T.Stop;
   end Run_Consumer;

end Flux_Benchmark.Interfaces;
