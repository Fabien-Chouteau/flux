with Flux.Traits.Bounded_Array_Duplex;
with Flux.Traits.LEB128;

with Interfaces;

with Flux_Benchmark_Config;

package body Flux_Benchmark.Traits is

   Prod_Buffer : constant Flux.Traits.Bounded_Array_Duplex.Acc
     := new Flux.Traits.Bounded_Array_Duplex.Instance'
       (Len => Flux_Benchmark_Config.Buffer_Size,
        others => <>);

   Consumer_Buffer : constant Flux.Traits.Bounded_Array_Duplex.Acc
     := new Flux.Traits.Bounded_Array_Duplex.Instance'
       (Len => Flux_Benchmark_Config.Buffer_Size,
        others => <>);

   ------------------
   -- Run_Producer --
   ------------------

   procedure Run_Producer (T : in out Timer'Class) is

      procedure Encode_LEB128
      is new Flux.Traits.LEB128.Encode
        (Interfaces.Unsigned_32,
         Flux.Traits.Bounded_Array_Duplex.Sink_Traits);

      Success : Boolean;
   begin
      T.Start;
      for Count in 1 .. Flux_Benchmark_Config.Number_Of_Iterations loop

         Flux.Traits.Bounded_Array_Duplex.Reset (Prod_Buffer.all);

         for X in Interfaces.Unsigned_32'Range loop
            Encode_LEB128 (Prod_Buffer.all, X, Success);
            exit when not Success;
         end loop;
      end loop;
      T.Stop;
   end Run_Producer;

   ------------------
   -- Run_Producer --
   ------------------

   procedure Run_Consumer (T : in out Timer'Class) is

      procedure Decode_LEB128
      is new Flux.Traits.LEB128.Decode
        (Interfaces.Unsigned_32,
         Flux.Traits.Bounded_Array_Duplex.Seekable_Traits);

      Success : Boolean;

      Val : Interfaces.Unsigned_32;
   begin

      for Count in 1 .. Flux_Benchmark_Config.Number_Of_Iterations loop

         T.Stop;
         Consumer_Buffer.all := Prod_Buffer.all;
         T.Start;

         for X in Interfaces.Unsigned_32'Range loop
            Decode_LEB128 (Consumer_Buffer.all, Val, Success);
            exit when not Success;
         end loop;
      end loop;

      T.Stop;
   end Run_Consumer;

end Flux_Benchmark.Traits;
